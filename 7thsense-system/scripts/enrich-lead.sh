#!/bin/bash
# 7thsense Lead Enrichment Script v2
# Usage: bash enrich-lead.sh "Business Name" "website.co.za"
# Two-step Google Places: findplacefromtext → Place Details
# Output: formatted data ready to paste into Google Sheet

BUSINESS="$1"
WEBSITE="$2"

if [ -z "$BUSINESS" ]; then
  echo "Usage: bash enrich-lead.sh \"Business Name\" [\"website.co.za\"]"
  exit 1
fi

echo ""
echo "════════════════════════════════════════"
echo "7THSENSE LEAD ENRICHMENT v2"
echo "════════════════════════════════════════"
echo "Business: $BUSINESS"
echo "Website:  ${WEBSITE:-Will attempt to find}"
echo "════════════════════════════════════════"
echo ""

PLACE_PHONE="" PLACE_RATING="" PLACE_REVIEWS="" PLACE_ID="" PLACE_WEBSITE="" PLACE_ADDR=""

# ─── STEP 1: Google Places — findplacefromtext → place_id ─────────
if [ -n "${GOOGLE_MAPS_API_KEY:-}" ]; then
  echo "▶ Step 1: Finding Place ID..."
  FIND=$(curl -s "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$(echo "$BUSINESS" | sed 's/ /%20/g')&inputtype=textquery&fields=place_id&key=$GOOGLE_MAPS_API_KEY")
  PLACE_ID=$(echo "$FIND" | python3 -c "import json,sys;d=json.load(sys.stdin);print(d.get('candidates',[{}])[0].get('place_id',''))" 2>/dev/null)

  if [ -n "$PLACE_ID" ]; then
    echo "  Place ID: $PLACE_ID"

    # ─── STEP 2: Place Details — full data ───
    echo "▶ Step 2: Fetching Place Details..."
    DET=$(curl -s "https://maps.googleapis.com/maps/api/place/details/json?place_id=${PLACE_ID}&fields=name,formatted_phone_number,website,rating,user_ratings_total,formatted_address,reviews&key=$GOOGLE_MAPS_API_KEY")
    PLACE_PHONE=$(echo "$DET" | python3 -c "import json,sys;print(json.load(sys.stdin).get('result',{}).get('formatted_phone_number',''))" 2>/dev/null)
    PLACE_RATING=$(echo "$DET" | python3 -c "import json,sys;print(json.load(sys.stdin).get('result',{}).get('rating',''))" 2>/dev/null)
    PLACE_REVIEWS=$(echo "$DET" | python3 -c "import json,sys;print(json.load(sys.stdin).get('result',{}).get('user_ratings_total',''))" 2>/dev/null)
    PLACE_WEBSITE=$(echo "$DET" | python3 -c "import json,sys;print(json.load(sys.stdin).get('result',{}).get('website',''))" 2>/dev/null)
    PLACE_ADDR=$(echo "$DET" | python3 -c "import json,sys;print(json.load(sys.stdin).get('result',{}).get('formatted_address',''))" 2>/dev/null)

    echo "  Phone: ${PLACE_PHONE:-N/A}"
    echo "  Rating: ${PLACE_RATING:-N/A} (${PLACE_REVIEWS:-0} reviews)"
    echo "  Website: ${PLACE_WEBSITE:-N/A}"
    echo "  Address: ${PLACE_ADDR:-N/A}"

    # Mine pain language from reviews
    echo ""
    echo "▶ Mining review pain language..."
    PAIN=$(echo "$DET" | python3 -c "
import json,sys
data=json.load(sys.stdin)
reviews=data.get('result',{}).get('reviews',[])
keywords=['can\\'t find','no website','hard to reach','no response','couldn\\'t book','no online booking','website doesn\\'t work','couldn\\'t contact','no email','goes to voicemail','never answer','no reply']
found=[]
for r in reviews:
    txt=r.get('text','').lower()
    for kw in keywords:
        if kw in txt:
            found.append(r.get('text','')[:200])
            break
if found:
    for f in found[:3]:
        print('  PAIN: '+f)
else:
    print('  No pain language found in reviews')
" 2>/dev/null)
    echo "$PAIN"
  else
    echo "  No Place ID found"
  fi
else
  echo "  GOOGLE_MAPS_API_KEY not set — skipping Places API"
fi

# ─── Determine best website ───
BEST_WEBSITE="${WEBSITE:-$PLACE_WEBSITE}"

# If still no website, try common patterns
if [ -z "$BEST_WEBSITE" ]; then
  echo ""
  echo "▶ Trying common domain patterns..."
  CLEAN=$(echo "$BUSINESS" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]//g')
  SURNAME=$(echo "$BUSINESS" | awk '{print $NF}' | tr '[:upper:]' '[:lower:]')
  for PAT in "${CLEAN}.co.za" "${CLEAN}.com" "dr${SURNAME}.co.za" "${SURNAME}dental.co.za"; do
    CODE=$(curl -sI --max-time 5 "https://${PAT}" 2>/dev/null | head -1 | grep -oE '[0-9]{3}' | head -1)
    if [ "$CODE" = "200" ] || [ "$CODE" = "301" ] || [ "$CODE" = "302" ]; then
      BEST_WEBSITE="https://${PAT}"
      echo "  Found: $BEST_WEBSITE (HTTP $CODE)"
      break
    fi
  done
  [ -z "$BEST_WEBSITE" ] && echo "  No domain patterns matched"
fi

# ─── Verify website ───
DOMAIN_STATUS="NOT_FOUND"
if [ -n "$BEST_WEBSITE" ]; then
  VDOMAIN=$(echo "$BEST_WEBSITE" | sed 's|https\?://||;s|/.*||;s|www\.||')
  VCODE=$(curl -sI --max-time 6 "https://${VDOMAIN}" 2>/dev/null | head -1 | grep -oE '[0-9]{3}' | head -1)
  if [ "$VCODE" = "200" ] || [ "$VCODE" = "301" ] || [ "$VCODE" = "302" ]; then
    DOMAIN_STATUS="VERIFIED"
  else
    VCODE=$(curl -sI --max-time 6 "http://${VDOMAIN}" 2>/dev/null | head -1 | grep -oE '[0-9]{3}' | head -1)
    [ "$VCODE" = "200" ] || [ "$VCODE" = "301" ] || [ "$VCODE" = "302" ] && DOMAIN_STATUS="VERIFIED" || DOMAIN_STATUS="UNVERIFIED"
  fi
fi

# ─── Website scrape ───
PHONES="" EMAILS="" WHATSAPP="" FACEBOOK=""
if [ -n "$BEST_WEBSITE" ] && [ "$DOMAIN_STATUS" != "NOT_FOUND" ]; then
  echo ""
  echo "▶ Scraping website for contact details..."
  SITE_DATA=$(curl -s --max-time 10 "$BEST_WEBSITE" 2>/dev/null)
  PHONES=$(echo "$SITE_DATA" | grep -oE '(\+27|0)[0-9]{9}' | sort -u | head -5)
  EMAILS=$(echo "$SITE_DATA" | grep -oE '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' | grep -v "example\|test\|noreply\|wordpress" | sort -u | head -5)
  WHATSAPP=$(echo "$SITE_DATA" | grep -oE 'wa\.me/[0-9]+|whatsapp\.com/send\?phone=[0-9]+' | head -3)
  FACEBOOK=$(echo "$SITE_DATA" | grep -oE 'facebook\.com/[a-zA-Z0-9._/]+' | grep -v "sharer\|share\|dialog" | head -3)

  echo "  Phones: ${PHONES:-None}"
  echo "  Emails: ${EMAILS:-None}"
  echo "  WhatsApp: ${WHATSAPP:-None}"
  echo "  Facebook: ${FACEBOOK:-None}"

  # Check contact page too
  CONTACT_DATA=$(curl -s --max-time 8 "${BEST_WEBSITE}/contact" 2>/dev/null)
  [ -n "$CONTACT_DATA" ] && {
    CE=$(echo "$CONTACT_DATA" | grep -oE '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' | grep -v "example\|test\|noreply" | sort -u | head -3)
    [ -z "$EMAILS" ] && [ -n "$CE" ] && EMAILS="$CE"
  }
fi

# ─── Determine confidence ───
DATA_CONF="LOW"
[ "$DOMAIN_STATUS" = "VERIFIED" ] && DATA_CONF="HIGH"
[ "$DOMAIN_STATUS" = "UNVERIFIED" ] && DATA_CONF="MEDIUM"

# ─── Output ───
echo ""
echo "════════════════════════════════════════"
echo "▶ ENRICHMENT SUMMARY"
echo "════════════════════════════════════════"
echo ""
echo "Business:    $BUSINESS"
echo "Website:     ${BEST_WEBSITE:-NOT FOUND} [$DOMAIN_STATUS]"
echo "Phone:       ${PHONES:-${PLACE_PHONE:-NOT FOUND}}"
echo "Email:       ${EMAILS:-NOT FOUND}"
echo "WhatsApp:    ${WHATSAPP:-NOT FOUND}"
echo "Facebook:    ${FACEBOOK:-NOT FOUND}"
echo "Rating:      ${PLACE_RATING:-N/A} (${PLACE_REVIEWS:-0} reviews)"
echo "Place ID:    ${PLACE_ID:-N/A}"
echo "Address:     ${PLACE_ADDR:-N/A}"
echo "Confidence:  $DATA_CONF"
echo ""
echo "════════════════════════════════════════"
echo "ENRICHMENT COMPLETE — $(date)"
echo "════════════════════════════════════════"
