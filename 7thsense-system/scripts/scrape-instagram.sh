#!/bin/bash
# Usage: bash scrape-instagram.sh "instagram_handle"
# Scrapes public Instagram profile and extracts all business context
# Returns structured JSON ready for site builder
# SECURITY: Never prints API keys. All secrets read from env silently.

set -euo pipefail

HANDLE="${1#@}"  # Strip @ if included
source ~/.zshrc

if [ -z "${APIFY_API_KEY:-}" ]; then
  echo "ERROR: APIFY_API_KEY not set"
  echo "Sign up at apify.com → Settings → Integrations → API token"
  echo "Then: echo 'export APIFY_API_KEY=YOUR_KEY' >> ~/.zshrc && source ~/.zshrc"
  exit 1
fi

echo "Scraping Instagram: @$HANDLE"

# Run Apify Instagram Profile Scraper
PROFILE=$(curl -s -X POST \
  "https://api.apify.com/v2/acts/apify~instagram-profile-scraper/run-sync-get-dataset-items?token=$APIFY_API_KEY&timeout=120" \
  -H "Content-Type: application/json" \
  -d "{\"usernames\": [\"$HANDLE\"], \"resultsLimit\": 1}")

# Check if we got data
PROFILE_COUNT=$(echo "$PROFILE" | python3 -c "import json,sys; d=json.load(sys.stdin); print(len(d))" 2>/dev/null || echo "0")
if [ "$PROFILE_COUNT" = "0" ] || [ -z "$PROFILE_COUNT" ]; then
  echo "ERROR: No profile data returned for @$HANDLE"
  echo "Check the handle is correct and the profile is public"
  exit 1
fi

# Extract profile data
FULL_NAME=$(echo "$PROFILE" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d[0].get('fullName',''))" 2>/dev/null)
BIO=$(echo "$PROFILE" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d[0].get('biography',''))" 2>/dev/null)
FOLLOWERS=$(echo "$PROFILE" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d[0].get('followersCount',0))" 2>/dev/null)
WEBSITE=$(echo "$PROFILE" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d[0].get('externalUrl',''))" 2>/dev/null)
PROFILE_PIC=$(echo "$PROFILE" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d[0].get('profilePicUrlHD', d[0].get('profilePicUrl','')))" 2>/dev/null)
CATEGORY=$(echo "$PROFILE" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d[0].get('businessCategoryName',''))" 2>/dev/null)
BUSINESS_EMAIL=$(echo "$PROFILE" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d[0].get('businessEmail',''))" 2>/dev/null)
BUSINESS_PHONE=$(echo "$PROFILE" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d[0].get('businessPhoneNumber',''))" 2>/dev/null)
BUSINESS_ADDRESS=$(echo "$PROFILE" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d[0].get('businessAddress',''))" 2>/dev/null)
POST_COUNT=$(echo "$PROFILE" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d[0].get('postsCount',0))" 2>/dev/null)
IS_VERIFIED=$(echo "$PROFILE" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d[0].get('verified',False))" 2>/dev/null)
IS_BUSINESS=$(echo "$PROFILE" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d[0].get('isBusinessAccount',False))" 2>/dev/null)

# Extract phone/email from bio if not in business fields
PHONE_FROM_BIO=$(echo "$BIO" | grep -oE '(\+27|0)[0-9 ]{9,13}' | head -1 | tr -d ' ')
EMAIL_FROM_BIO=$(echo "$BIO" | grep -oE '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' | head -1)
WHATSAPP_FROM_BIO=$(echo "$BIO" | grep -oiE '(wa\.me/[0-9]+|whatsapp[: ]*(\+27|0)[0-9 ]{9,13})' | head -1)

# Extract latest post captions and images
LATEST_POSTS=$(echo "$PROFILE" | python3 -c "
import json,sys
d=json.load(sys.stdin)
posts = d[0].get('latestPosts', [])
for i, p in enumerate(posts[:12]):
    caption = p.get('caption','')[:500] if p.get('caption') else ''
    img = p.get('displayUrl','')
    likes = p.get('likesCount',0)
    comments = p.get('commentsCount',0)
    timestamp = p.get('timestamp','')
    print(f'POST_{i}|{likes}|{comments}|{timestamp}|{img}|{caption}')
" 2>/dev/null)

# Create asset directory
ASSET_DIR=~/agency-templates/outreach/instagram-assets/$HANDLE
mkdir -p "$ASSET_DIR"

# Download profile pic as potential logo
if [ ! -z "$PROFILE_PIC" ] && [ "$PROFILE_PIC" != "None" ]; then
  curl -s -L -o "$ASSET_DIR/profile-pic.jpg" "$PROFILE_PIC" 2>/dev/null
  if [ -f "$ASSET_DIR/profile-pic.jpg" ] && [ -s "$ASSET_DIR/profile-pic.jpg" ]; then
    echo "  Profile pic saved"
  fi
fi

# Download top post images (up to 6)
IMG_COUNT=0
echo "$LATEST_POSTS" | while IFS='|' read -r post_id likes comments timestamp img caption; do
  if [ ! -z "$img" ] && [ "$img" != "None" ] && [ $IMG_COUNT -lt 6 ]; then
    curl -s -L -o "$ASSET_DIR/post-$(printf '%02d' $IMG_COUNT).jpg" "$img" 2>/dev/null
    if [ -f "$ASSET_DIR/post-$(printf '%02d' $IMG_COUNT).jpg" ] && [ -s "$ASSET_DIR/post-$(printf '%02d' $IMG_COUNT).jpg" ]; then
      echo "  Post image $IMG_COUNT saved"
    fi
    IMG_COUNT=$((IMG_COUNT + 1))
  fi
done

# Extract services/themes from post captions
SERVICES_EXTRACTED=$(echo "$LATEST_POSTS" | python3 -c "
import sys, re
captions = []
for line in sys.stdin:
    parts = line.strip().split('|', 5)
    if len(parts) > 5 and parts[5]:
        captions.append(parts[5])
# Find repeated themes/services
all_text = ' '.join(captions).lower()
# Extract hashtags as service indicators
hashtags = re.findall(r'#(\w+)', all_text)
# Count and rank
from collections import Counter
tag_counts = Counter(hashtags)
top_tags = [tag for tag, count in tag_counts.most_common(15) if count >= 2]
print('\n'.join(top_tags[:10]))
" 2>/dev/null)

# Build context file
cat > "$ASSET_DIR/context.md" << CONTEXT
# Instagram Scrape: @$HANDLE
Scraped: $(date)

## Business Info
- Full Name: $FULL_NAME
- Category: $CATEGORY
- Followers: $FOLLOWERS
- Posts: $POST_COUNT
- Verified: $IS_VERIFIED
- Business Account: $IS_BUSINESS
- Website: $WEBSITE

## Contact Details
- Phone (business field): $BUSINESS_PHONE
- Phone (from bio): $PHONE_FROM_BIO
- Email (business field): $BUSINESS_EMAIL
- Email (from bio): $EMAIL_FROM_BIO
- WhatsApp (from bio): $WHATSAPP_FROM_BIO
- Address: $BUSINESS_ADDRESS

## Bio
$BIO

## Top Hashtags / Service Indicators
$SERVICES_EXTRACTED

## Recent Post Captions
$(echo "$LATEST_POSTS" | while IFS='|' read -r post_id likes comments timestamp img caption; do
  if [ ! -z "$caption" ] && [ "$caption" != "None" ]; then
    echo "---"
    echo "Likes: $likes | Comments: $comments | Date: $timestamp"
    echo "$caption"
    echo ""
  fi
done)

## Downloaded Assets
- Profile pic: instagram-assets/$HANDLE/profile-pic.jpg
- Post images: instagram-assets/$HANDLE/post-*.jpg
CONTEXT

echo ""
echo "════════════════════════════════════════"
echo "  INSTAGRAM SCRAPE COMPLETE"
echo "════════════════════════════════════════"
echo ""
echo "  Business:   $FULL_NAME"
echo "  Category:   $CATEGORY"
echo "  Followers:  $FOLLOWERS"
echo "  Posts:       $POST_COUNT"
echo "  Verified:   $IS_VERIFIED"
echo "  Business:   $IS_BUSINESS"
echo "  Phone:      ${BUSINESS_PHONE:-${PHONE_FROM_BIO:-not found}}"
echo "  Email:      ${BUSINESS_EMAIL:-${EMAIL_FROM_BIO:-not found}}"
echo "  Website:    ${WEBSITE:-none}"
echo ""
echo "  Bio: $BIO"
echo ""
echo "  Context: $ASSET_DIR/context.md"
echo "════════════════════════════════════════"
