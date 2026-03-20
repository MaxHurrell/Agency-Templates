#!/bin/bash
# Usage: bash build-from-instagram.sh "@handle" "Business Name" "niche"
# Full pipeline: Instagram scrape + Google Places + build brief
# Example: bash build-from-instagram.sh "@balooplumbing" "Baloo Plumbing" "plumbing"
# SECURITY: Never prints API keys. All secrets read from env silently.

set -euo pipefail

HANDLE="${1#@}"
BUSINESS="${2:-}"
NICHE="${3:-}"

source ~/.zshrc

if [ -z "$HANDLE" ]; then
  echo "Usage: bash build-from-instagram.sh \"@handle\" \"Business Name\" \"niche\""
  echo "Example: bash build-from-instagram.sh \"@balooplumbing\" \"Baloo Plumbing\" \"plumbing\""
  exit 1
fi

echo ""
echo "════════════════════════════════════════"
echo "  7THSENSE: BUILD FROM INSTAGRAM"
echo "════════════════════════════════════════"
echo "  Business: ${BUSINESS:-TBD (will extract from profile)}"
echo "  Handle:   @$HANDLE"
echo "  Niche:    ${NICHE:-TBD (will detect from category)}"
echo "════════════════════════════════════════"
echo ""

# ──────────────────────────────────
# STEP 1: Scrape Instagram
# ──────────────────────────────────
echo "━━━ Step 1/3: Scraping Instagram ━━━"
bash ~/agency-templates/7thsense-system/scripts/scrape-instagram.sh "$HANDLE"

ASSET_DIR=~/agency-templates/outreach/instagram-assets/$HANDLE

# Read back key fields from context
if [ ! -f "$ASSET_DIR/context.md" ]; then
  echo "ERROR: Instagram scrape failed — no context.md"
  exit 1
fi

# Extract business name from profile if not provided
if [ -z "$BUSINESS" ]; then
  BUSINESS=$(grep "Full Name:" "$ASSET_DIR/context.md" | head -1 | sed 's/.*Full Name: //')
  echo "  Auto-detected business name: $BUSINESS"
fi

# Extract niche from category if not provided
if [ -z "$NICHE" ]; then
  NICHE=$(grep "Category:" "$ASSET_DIR/context.md" | head -1 | sed 's/.*Category: //')
  echo "  Auto-detected niche: $NICHE"
fi

# ──────────────────────────────────
# STEP 2: Google Places data
# ──────────────────────────────────
echo ""
echo "━━━ Step 2/3: Getting Google Places data ━━━"

PLACE_ID=""
GOOGLE_RATING=""
GOOGLE_REVIEWS_COUNT=""
GOOGLE_PHONE=""
GOOGLE_ADDRESS=""
GOOGLE_HOURS=""
REVIEWS_TEXT=""

if [ -z "${GOOGLE_MAPS_API_KEY:-}" ]; then
  echo "  WARNING: GOOGLE_MAPS_API_KEY not set — skipping Google Places"
else
  # Find place
  ENCODED_NAME=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$BUSINESS'))" 2>/dev/null)
  PLACES=$(curl -s "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$ENCODED_NAME&inputtype=textquery&fields=place_id,name,rating,user_ratings_total,formatted_address&key=$GOOGLE_MAPS_API_KEY")

  PLACE_ID=$(echo "$PLACES" | python3 -c "import json,sys; d=json.load(sys.stdin); c=d.get('candidates',[]); print(c[0].get('place_id','') if c else '')" 2>/dev/null)
  GOOGLE_RATING=$(echo "$PLACES" | python3 -c "import json,sys; d=json.load(sys.stdin); c=d.get('candidates',[]); print(c[0].get('rating','') if c else '')" 2>/dev/null)
  GOOGLE_REVIEWS_COUNT=$(echo "$PLACES" | python3 -c "import json,sys; d=json.load(sys.stdin); c=d.get('candidates',[]); print(c[0].get('user_ratings_total','') if c else '')" 2>/dev/null)
  GOOGLE_ADDRESS=$(echo "$PLACES" | python3 -c "import json,sys; d=json.load(sys.stdin); c=d.get('candidates',[]); print(c[0].get('formatted_address','') if c else '')" 2>/dev/null)

  if [ ! -z "$PLACE_ID" ]; then
    echo "  Place ID: $PLACE_ID"
    echo "  Rating: $GOOGLE_RATING/5 ($GOOGLE_REVIEWS_COUNT reviews)"

    # Get full details + reviews
    DETAILS=$(curl -s "https://maps.googleapis.com/maps/api/place/details/json?place_id=$PLACE_ID&fields=name,formatted_phone_number,website,rating,user_ratings_total,formatted_address,opening_hours,reviews&key=$GOOGLE_MAPS_API_KEY")

    GOOGLE_PHONE=$(echo "$DETAILS" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('result',{}).get('formatted_phone_number',''))" 2>/dev/null)
    GOOGLE_HOURS=$(echo "$DETAILS" | python3 -c "
import json,sys
d=json.load(sys.stdin)
hours = d.get('result',{}).get('opening_hours',{}).get('weekday_text',[])
print('\n'.join(hours))
" 2>/dev/null)

    REVIEWS_TEXT=$(echo "$DETAILS" | python3 -c "
import json,sys
d=json.load(sys.stdin)
reviews = d.get('result',{}).get('reviews',[])
for r in reviews[:5]:
    name = r.get('author_name','')
    rating = r.get('rating','')
    text = r.get('text','')
    initials = ''.join([w[0] for w in name.split()[:2]]).upper() if name else 'XX'
    print(f'### {name} ({rating}/5) [{initials}]')
    print(f'\"{text}\"')
    print()
" 2>/dev/null)
  else
    echo "  WARNING: No Google Places match found for '$BUSINESS'"
  fi
fi

# ──────────────────────────────────
# STEP 3: Generate build brief
# ──────────────────────────────────
echo ""
echo "━━━ Step 3/3: Generating build brief ━━━"

SLUG=$(echo "$BUSINESS" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9-]//g')
INSTAGRAM_CONTEXT=$(cat "$ASSET_DIR/context.md" 2>/dev/null)

# Count downloaded assets
ASSET_COUNT=$(ls "$ASSET_DIR"/*.jpg 2>/dev/null | wc -l | tr -d ' ')

cat > "$ASSET_DIR/build-brief.md" << BRIEF
# Build Brief: $BUSINESS
Generated: $(date)
Source: Instagram @$HANDLE + Google Places API

## DATA SOURCES
| Source | Available |
|--------|-----------|
| Instagram Profile | Yes — @$HANDLE |
| Google Places | ${PLACE_ID:+Yes — $PLACE_ID} ${PLACE_ID:-No match found} |
| Existing Website | Check Instagram bio link |
| Downloaded Images | $ASSET_COUNT files |

## GOOGLE PLACES DATA
- Place ID: $PLACE_ID
- Rating: $GOOGLE_RATING/5 ($GOOGLE_REVIEWS_COUNT reviews)
- Phone: $GOOGLE_PHONE
- Address: $GOOGLE_ADDRESS
- Reviews URL: https://search.google.com/local/reviews?placeid=$PLACE_ID

### Operating Hours
$GOOGLE_HOURS

### Google Reviews (verbatim)
$REVIEWS_TEXT

## INSTAGRAM CONTEXT
$INSTAGRAM_CONTEXT

## BUILD CONFIG
- Deploy slug: $SLUG
- Deploy to: ~/client-sites/$SLUG/
- Tally source: $SLUG
- Niche: $NICHE

## NEXT STEPS
1. Read this build brief
2. Read CLAUDE.md and BRAIN.md
3. Read all relevant skills (locked-components, niche, systems-architect, visual-system, copy-architect, image-agent)
4. Extract services from Instagram captions
5. Use Google reviews as testimonials
6. Use downloaded post images where appropriate
7. Generate Gemini images for hero and remaining service sections
8. Build demo site at ~/client-sites/$SLUG/index.html
9. Deploy with: bash ~/client-sites/deploy-client.sh $SLUG
BRIEF

echo "  Build brief: $ASSET_DIR/build-brief.md"
echo ""
echo "════════════════════════════════════════════════"
echo "  PIPELINE COMPLETE — READY FOR BUILD"
echo "════════════════════════════════════════════════"
echo ""
echo "  Business:    $BUSINESS"
echo "  Handle:      @$HANDLE"
echo "  Niche:       $NICHE"
echo "  Slug:        $SLUG"
echo "  Place ID:    ${PLACE_ID:-not found}"
echo "  Rating:      ${GOOGLE_RATING:-n/a}/5 (${GOOGLE_REVIEWS_COUNT:-0} reviews)"
echo "  Phone:       ${GOOGLE_PHONE:-see Instagram}"
echo "  Images:      $ASSET_COUNT downloaded"
echo ""
echo "  Build brief: $ASSET_DIR/build-brief.md"
echo ""
echo "  ┌─────────────────────────────────────────┐"
echo "  │  Run in Claude Code:                     │"
echo "  │                                          │"
echo "  │  Read $ASSET_DIR/build-brief.md          │"
echo "  │  Build demo for $BUSINESS                │"
echo "  └─────────────────────────────────────────┘"
echo ""
echo "════════════════════════════════════════════════"
