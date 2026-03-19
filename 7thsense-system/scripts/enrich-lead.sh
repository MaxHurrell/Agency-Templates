#!/bin/bash
# 7thsense Lead Enrichment Script
# Usage: bash enrich-lead.sh "Business Name" "website.co.za"
# Enriches a single lead with all available contact points
# Output: formatted data ready to paste into Google Sheet

BUSINESS="$1"
WEBSITE="$2"

if [ -z "$BUSINESS" ] || [ -z "$WEBSITE" ]; then
  echo "Usage: bash enrich-lead.sh \"Business Name\" \"website.co.za\""
  exit 1
fi

echo ""
echo "════════════════════════════════════════"
echo "7THSENSE LEAD ENRICHMENT"
echo "════════════════════════════════════════"
echo "Business: $BUSINESS"
echo "Website:  $WEBSITE"
echo "════════════════════════════════════════"
echo ""

# 1. WEBSITE SCRAPE — extract contact details
echo "▶ Scraping website for contact details..."
SITE_DATA=$(curl -s --max-time 10 "https://$WEBSITE" 2>/dev/null || curl -s --max-time 10 "http://$WEBSITE" 2>/dev/null)

# Extract phone numbers
PHONES=$(echo "$SITE_DATA" | grep -oE '(\+27|0)[0-9]{9}' | sort -u | head -5)
# Extract emails
EMAILS=$(echo "$SITE_DATA" | grep -oE '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' | grep -v "example\|test\|noreply\|wordpress" | sort -u | head -5)
# Extract WhatsApp links
WHATSAPP=$(echo "$SITE_DATA" | grep -oE 'wa\.me/[0-9]+|whatsapp\.com/send\?phone=[0-9]+' | head -3)
# Extract Instagram
INSTAGRAM=$(echo "$SITE_DATA" | grep -oE 'instagram\.com/[a-zA-Z0-9._]+' | head -3)
# Extract Facebook
FACEBOOK=$(echo "$SITE_DATA" | grep -oE 'facebook\.com/[a-zA-Z0-9._/]+' | grep -v "sharer\|share\|dialog" | head -3)

echo "📞 PHONES FOUND:"
if [ -z "$PHONES" ]; then echo "  None found on website"; else echo "$PHONES" | sed 's/^/  /'; fi

echo ""
echo "📧 EMAILS FOUND:"
if [ -z "$EMAILS" ]; then echo "  None found on website"; else echo "$EMAILS" | sed 's/^/  /'; fi

echo ""
echo "💬 WHATSAPP FOUND:"
if [ -z "$WHATSAPP" ]; then echo "  None found on website"; else echo "$WHATSAPP" | sed 's/^/  /'; fi

echo ""
echo "📸 INSTAGRAM FOUND:"
if [ -z "$INSTAGRAM" ]; then echo "  None found on website"; else echo "$INSTAGRAM" | sed 's/^/  /'; fi

echo ""
echo "👥 FACEBOOK FOUND:"
if [ -z "$FACEBOOK" ]; then echo "  None found on website"; else echo "$FACEBOOK" | sed 's/^/  /'; fi

echo ""
echo "════════════════════════════════════════"
echo "▶ Checking contact page..."
CONTACT_DATA=$(curl -s --max-time 10 "https://$WEBSITE/contact" 2>/dev/null)
CONTACT_EMAILS=$(echo "$CONTACT_DATA" | grep -oE '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' | grep -v "example\|test\|noreply" | sort -u | head -5)
CONTACT_PHONES=$(echo "$CONTACT_DATA" | grep -oE '(\+27|0)[0-9]{9}' | sort -u | head -5)

echo "📧 CONTACT PAGE EMAILS:"
if [ -z "$CONTACT_EMAILS" ]; then echo "  None found"; else echo "$CONTACT_EMAILS" | sed 's/^/  /'; fi

echo ""
echo "📞 CONTACT PAGE PHONES:"
if [ -z "$CONTACT_PHONES" ]; then echo "  None found"; else echo "$CONTACT_PHONES" | sed 's/^/  /'; fi

echo ""
echo "════════════════════════════════════════"
echo "▶ Manual research needed for:"
echo ""
echo "  👤 OWNER NAME:"
echo "     Search: \"$BUSINESS owner\" OR \"$BUSINESS dentist\" OR \"$BUSINESS dr\""
echo "     Google: https://www.google.com/search?q=$(echo "$BUSINESS+owner+dentist" | sed 's/ /+/g')"
echo ""
echo "  💼 LINKEDIN:"
echo "     Search: https://www.linkedin.com/search/results/people/?keywords=$(echo "$BUSINESS" | sed 's/ /+/g')"
echo ""
echo "  📸 INSTAGRAM:"
echo "     Search: https://www.instagram.com/$(echo "$BUSINESS" | tr '[:upper:]' '[:lower:]' | sed 's/ //g')/"
echo ""
echo "  👥 FACEBOOK:"
echo "     Search: https://www.facebook.com/search/top?q=$(echo "$BUSINESS" | sed 's/ /+/g')"
echo ""
echo "════════════════════════════════════════"
echo "▶ GOOGLE PLACES DATA"
echo "  Place ID lookup:"
echo "  https://developers.google.com/maps/documentation/javascript/examples/places-placeid-finder"
echo ""

# Google Places API lookup if key available — key loaded silently
GOOGLE_MAPS_API_KEY="${GOOGLE_MAPS_API_KEY:-}"
if [ -z "$GOOGLE_MAPS_API_KEY" ] && [ -f ~/.zshrc ]; then
  GOOGLE_MAPS_API_KEY=$(grep -oP 'GOOGLE_MAPS_API_KEY=\K[^\s"]+' ~/.zshrc 2>/dev/null || true)
fi

if [ ! -z "$GOOGLE_MAPS_API_KEY" ]; then
  echo "  ▶ Auto-fetching Google Places data..."
  PLACES=$(curl -s "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$(echo "$BUSINESS" | sed 's/ /%20/g')&inputtype=textquery&fields=name,formatted_phone_number,website,rating,user_ratings_total,place_id&key=$GOOGLE_MAPS_API_KEY")
  PLACE_PHONE=$(echo "$PLACES" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('candidates',[{}])[0].get('formatted_phone_number','Not found'))" 2>/dev/null)
  PLACE_RATING=$(echo "$PLACES" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('candidates',[{}])[0].get('rating','Not found'))" 2>/dev/null)
  PLACE_REVIEWS=$(echo "$PLACES" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('candidates',[{}])[0].get('user_ratings_total','Not found'))" 2>/dev/null)
  PLACE_ID=$(echo "$PLACES" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('candidates',[{}])[0].get('place_id','Not found'))" 2>/dev/null)
  echo "  Phone: $PLACE_PHONE"
  echo "  Rating: $PLACE_RATING ⭐ ($PLACE_REVIEWS reviews)"
  echo "  Place ID: $PLACE_ID"
fi

echo ""
echo "════════════════════════════════════════"
echo "▶ GOOGLE SHEET ROW — copy this:"
echo "════════════════════════════════════════"
echo ""
echo "Business Name: $BUSINESS"
echo "Website: $WEBSITE"
echo "Phone: ${PHONES:-$PLACE_PHONE}"
echo "Email: ${EMAILS:-${CONTACT_EMAILS:-NOT FOUND}}"
echo "WhatsApp: ${WHATSAPP:-NOT FOUND — check manually}"
echo "Instagram: ${INSTAGRAM:-NOT FOUND — check manually}"
echo "Facebook: ${FACEBOOK:-NOT FOUND — check manually}"
echo "LinkedIn: MANUAL — see link above"
echo "Google Rating: ${PLACE_RATING:-run script}"
echo "Place ID: ${PLACE_ID:-run script}"
echo ""
echo "════════════════════════════════════════"
echo "ENRICHMENT COMPLETE — $(date)"
echo "════════════════════════════════════════"
