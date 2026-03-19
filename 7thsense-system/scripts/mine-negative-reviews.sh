#!/bin/bash
# 7thsense — Mine negative reviews for pain language
# Usage: bash mine-negative-reviews.sh [place_id]
# Uses Google Places API to fetch reviews and filter for access/booking friction
set -uo pipefail

PLACE_ID="${1:-}"
if [ -z "$PLACE_ID" ]; then echo "Usage: bash mine-negative-reviews.sh [place_id]"; exit 1; fi

# Load API key silently
source ~/.zshrc 2>/dev/null
if [ -z "${GOOGLE_MAPS_API_KEY:-}" ]; then
  echo "REVIEWS=SKIPPED"
  echo "REASON=no_api_key"
  exit 0
fi

# Fetch place details with reviews
DETAILS=$(curl -s "https://maps.googleapis.com/maps/api/place/details/json?place_id=${PLACE_ID}&fields=reviews,rating,user_ratings_total&key=${GOOGLE_MAPS_API_KEY}" 2>/dev/null)

RATING=$(echo "$DETAILS" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('result',{}).get('rating','N/A'))" 2>/dev/null)
TOTAL=$(echo "$DETAILS" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('result',{}).get('user_ratings_total',0))" 2>/dev/null)

echo "RATING=$RATING"
echo "REVIEW_COUNT=$TOTAL"

# Extract reviews and search for pain language
PAIN_KEYWORDS="hard to find|can't book|cant book|no website|no response|didn't call|didnt call|couldn't reach|couldnt reach|no answer|difficult to contact|no online|can't get through|website down|website doesn't|never called back|never responded|waited for|no reply|unprofessional|rude receptionist|long wait|didn't answer|closed when|wrong hours"

PAIN_QUOTES=$(echo "$DETAILS" | python3 -c "
import json, sys, re
d = json.load(sys.stdin)
reviews = d.get('result', {}).get('reviews', [])
pain_re = re.compile(r'${PAIN_KEYWORDS}', re.IGNORECASE)
for r in reviews:
    text = r.get('text', '')
    rating = r.get('rating', 5)
    author = r.get('author_name', 'Anonymous')
    if rating <= 3 or pain_re.search(text):
        # Truncate to 200 chars
        snippet = text[:200].replace('\n', ' ').strip()
        if snippet:
            print(f'[{rating}/5] {author}: \"{snippet}\"')
" 2>/dev/null)

if [ -n "$PAIN_QUOTES" ]; then
  PAIN_COUNT=$(echo "$PAIN_QUOTES" | wc -l | tr -d ' ')
  echo "PAIN_REVIEWS=$PAIN_COUNT"
  echo "PAIN_LANGUAGE=YES"
  echo "---QUOTES---"
  echo "$PAIN_QUOTES"
else
  echo "PAIN_REVIEWS=0"
  echo "PAIN_LANGUAGE=NO"
fi
