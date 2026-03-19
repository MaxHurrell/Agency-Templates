#!/usr/bin/env zsh
# ═══════════════════════════════════════════════════════════════════
# 7thsense AUTOMATED PROSPECT PIPELINE
# ═══════════════════════════════════════════════════════════════════
# Usage: zsh prospect-pipeline.sh "Niche" "Location" [--count N]
# Example: zsh prospect-pipeline.sh "dentist" "Bellville Cape Town" --count 5
# ═══════════════════════════════════════════════════════════════════
setopt pipefail 2>/dev/null

SCRIPT_DIR="${0:A:h}"
NICHE="${1:-}"
LOCATION="${2:-}"
COUNT=10

# Parse --count flag
if [[ $# -ge 4 ]] && [[ "$3" = "--count" ]]; then COUNT="$4"; fi

if [[ -z "$NICHE" ]] || [[ -z "$LOCATION" ]]; then
  echo "Usage: zsh prospect-pipeline.sh \"Niche\" \"Location\" [--count N]"
  exit 1
fi

source ~/.zshrc 2>/dev/null
if [[ -z "${GOOGLE_MAPS_API_KEY:-}" ]]; then
  echo "ERROR: GOOGLE_MAPS_API_KEY not set"; exit 1
fi

DATE=$(date +"%Y-%m-%d")
TS=$(date +"%Y%m%d-%H%M")
OUTDIR="$HOME/agency-templates/outreach"
mkdir -p "$OUTDIR"
MD="$OUTDIR/pipeline-${TS}.md"
CSV="$OUTDIR/pipeline-${TS}.csv"

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "  7THSENSE PROSPECT PIPELINE"
echo "  Niche: $NICHE | Location: $LOCATION | Count: $COUNT | $DATE"
echo "═══════════════════════════════════════════════════════════════"
echo ""

# ─── STEP 1: GOOGLE MAPS SEARCH ──────────────────────────────────
echo "STEP 1: Searching Google Maps..."
QUERY=$(echo "${NICHE} in ${LOCATION}" | sed 's/ /%20/g')
SEARCH=$(curl -s "https://maps.googleapis.com/maps/api/place/textsearch/json?query=${QUERY}&key=${GOOGLE_MAPS_API_KEY}")

PLACES=$(echo "$SEARCH" | python3 -c "
import json,sys
d=json.load(sys.stdin)
for r in d.get('results',[])[:${COUNT}]:
    n=r.get('name','?')
    p=r.get('place_id','')
    rt=r.get('rating',0)
    rv=r.get('user_ratings_total',0)
    a=r.get('formatted_address','')
    print(f'{n}\t{p}\t{rt}\t{rv}\t{a}')
" 2>/dev/null)

TOTAL=$(echo "$PLACES" | grep -c . 2>/dev/null || echo 0)
echo "  Found: $TOTAL businesses"

if [[ "$TOTAL" -eq 0 ]]; then echo "ERROR: No businesses found."; exit 1; fi

# Init output files
echo "# 7thsense Pipeline: $NICHE in $LOCATION — $DATE" > "$MD"
echo "" >> "$MD"
echo "Business Name,Website,Location,Phone,Email,WhatsApp,Instagram,Facebook,Rating,Reviews,Domain Age,Google Ads,Meta Ads,Pain Quote,Score,Priority,Angle,Message" > "$CSV"

# ─── STEP 2: PROCESS EACH BUSINESS ───────────────────────────────
IDX=0
echo "$PLACES" | while IFS=$'\t' read -r NAME PID RATING REVIEWS ADDR; do
  IDX=$((IDX + 1))
  echo ""
  echo "═══ [$IDX/$TOTAL] $NAME ═══"
  echo "  $RATING stars | $REVIEWS reviews | $ADDR"

  # Get details
  DET=$(curl -s "https://maps.googleapis.com/maps/api/place/details/json?place_id=${PID}&fields=website,formatted_phone_number,reviews&key=${GOOGLE_MAPS_API_KEY}")
  WEBSITE=$(echo "$DET" | python3 -c "import json,sys;print(json.load(sys.stdin).get('result',{}).get('website',''))" 2>/dev/null)
  PHONE=$(echo "$DET" | python3 -c "import json,sys;print(json.load(sys.stdin).get('result',{}).get('formatted_phone_number',''))" 2>/dev/null)

  DOMAIN=""
  [[ -n "$WEBSITE" ]] && DOMAIN=$(echo "$WEBSITE" | sed 's|https\?://||;s|/.*||;s|www\.||')
  echo "  Web: ${WEBSITE:-NONE} | Phone: ${PHONE:-N/A}"

  # Init scores
  S_PAIN=0; S_URG=0; S_ACC=0; S_CONV=0; S_BUD=0
  SIGS=""; ANGLE="general"; PQUOTE=""; GADS="NO"; MADS="NO"
  DAGE="N/A"; EMAIL=""; WA=""; IG=""; FB=""

  if [[ -z "$WEBSITE" ]]; then
    echo "  >> NO WEBSITE — critical"
    S_PAIN=5; S_CONV=5; SIGS="no_website "; ANGLE="no_website"
  else
    SRC=$(curl -sL --max-time 8 "$WEBSITE" 2>/dev/null)
    if [[ -z "$SRC" ]]; then
      echo "  >> Site unreachable"
      S_PAIN=4; S_CONV=4; SIGS="unreachable "; ANGLE="broken_site"
    else
      # Site quality checks
      V=$(echo "$SRC" | grep -ci "viewport" 2>/dev/null); V=${V:-0}; [[ "$V" =~ ^[0-9]+$ ]] || V=0
      F=$(echo "$SRC" | grep -ciE '<form|<input|tally\.so|typeform' 2>/dev/null); F=${F:-0}; [[ "$F" =~ ^[0-9]+$ ]] || F=0
      T=$(echo "$SRC" | grep -ci "tel:" 2>/dev/null); T=${T:-0}; [[ "$T" =~ ^[0-9]+$ ]] || T=0
      W=$(echo "$SRC" | grep -ciE 'wa\.me|whatsapp' 2>/dev/null); W=${W:-0}; [[ "$W" =~ ^[0-9]+$ ]] || W=0
      SS=0
      [[ $V -gt 0 ]] && SS=$((SS+2))
      [[ $F -gt 0 ]] && SS=$((SS+2))
      [[ $T -gt 0 ]] && SS=$((SS+2))
      [[ $W -gt 0 ]] && SS=$((SS+1))
      curl -sI --max-time 4 "https://$DOMAIN" >/dev/null 2>&1 && SS=$((SS+1))
      echo "  >> Site quality: $SS/8"

      if [[ $SS -le 2 ]]; then S_PAIN=4; S_CONV=4; SIGS="terrible_site "; ANGLE="broken_site"
      elif [[ $SS -le 4 ]]; then S_PAIN=3; S_CONV=3; SIGS="weak_site "; ANGLE="weak_site"
      elif [[ $SS -le 6 ]]; then S_PAIN=2; S_CONV=2; SIGS="mediocre_site "
      else S_PAIN=1; S_CONV=1; SIGS="decent_site "; fi

      # Google Ads detection
      AO=$(bash "$SCRIPT_DIR/detect-google-ads.sh" "$DOMAIN" 2>/dev/null)
      GADS=$(echo "$AO" | grep "GOOGLE_ADS=" | cut -d= -f2)
      if [[ "$GADS" = "YES" ]] || [[ "$GADS" = "LIKELY" ]]; then
        S_BUD=$((S_BUD+3)); S_URG=$((S_URG+2)); SIGS="${SIGS}gads "; ANGLE="ad_waste"
        echo "  >> Google Ads: $GADS"
      fi

      # Meta Ads detection
      MO=$(bash "$SCRIPT_DIR/detect-meta-ads.sh" "$DOMAIN" 2>/dev/null)
      MADS=$(echo "$MO" | grep "META_ADS=" | cut -d= -f2)
      if [[ "$MADS" = "YES" ]] || [[ "$MADS" = "LIKELY" ]]; then
        S_BUD=$((S_BUD+2)); SIGS="${SIGS}meta "; [[ "$ANGLE" = "general" ]] && ANGLE="ad_waste"
        echo "  >> Meta Ads: $MADS"
      fi

      # Social media
      SO=$(bash "$SCRIPT_DIR/check-social-activity.sh" "$DOMAIN" 2>/dev/null)
      FB=$(echo "$SO" | grep "^FACEBOOK=" | cut -d= -f2); [[ "$FB" = "NOT_FOUND" ]] && FB=""
      IG=$(echo "$SO" | grep "^INSTAGRAM=" | cut -d= -f2); [[ "$IG" = "NOT_FOUND" ]] && IG=""
      SC=$(echo "$SO" | grep "SOCIAL_SCORE=" | cut -d= -f2)
      [[ "$SC" = "HIGH" ]] && S_BUD=$((S_BUD+1)) && SIGS="${SIGS}social "

      # Domain age
      DA=$(bash "$SCRIPT_DIR/check-domain-age.sh" "$DOMAIN" 2>/dev/null)
      DAGE=$(echo "$DA" | grep "DOMAIN_AGE_YEARS=" | cut -d= -f2)
      EU=$(echo "$DA" | grep "EXPIRY_URGENCY=" | cut -d= -f2)
      [[ "$EU" = "CRITICAL" ]] && S_URG=$((S_URG+2)) && SIGS="${SIGS}expiring "

      # Contact enrichment from site source
      EMAIL=$(echo "$SRC" | grep -oE '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' | grep -v 'example\|test\|noreply\|wordpress\|wix\|sentry' | sort -u | head -1)
      WA=$(echo "$SRC" | grep -oE 'wa\.me/[0-9]+' | head -1)
      [[ -n "$WA" ]] && WA="https://$WA"
    fi
  fi

  # Mine negative reviews
  RO=$(bash "$SCRIPT_DIR/mine-negative-reviews.sh" "$PID" 2>/dev/null)
  PL=$(echo "$RO" | grep "PAIN_LANGUAGE=" | cut -d= -f2)
  if [[ "$PL" = "YES" ]]; then
    PQUOTE=$(echo "$RO" | sed -n '/---QUOTES---/,$ p' | tail -n +2 | head -1)
    S_URG=$((S_URG+2)); SIGS="${SIGS}pain_reviews "
    [[ "$ANGLE" = "general" ]] && ANGLE="reviews"
    echo "  >> Pain language found"
  fi

  # Accessibility score
  if [[ "$REVIEWS" -lt 20 ]]; then S_ACC=4
  elif [[ "$REVIEWS" -lt 50 ]]; then S_ACC=3
  else S_ACC=2; fi
  [[ -n "$PHONE" ]] && S_ACC=$((S_ACC+1))

  # Cap at 5
  [[ $S_PAIN -gt 5 ]] && S_PAIN=5; [[ $S_URG -gt 5 ]] && S_URG=5
  [[ $S_ACC -gt 5 ]] && S_ACC=5; [[ $S_CONV -gt 5 ]] && S_CONV=5
  [[ $S_BUD -gt 5 ]] && S_BUD=5

  TOTAL_S=$((S_PAIN+S_URG+S_ACC+S_CONV+S_BUD))
  PRI="PASS"
  [[ $TOTAL_S -ge 10 ]] && PRI="MEDIUM"
  [[ $TOTAL_S -ge 15 ]] && PRI="HIGH"
  [[ $TOTAL_S -ge 20 ]] && PRI="PRIORITY"

  echo "  ┌─ SCORE: $TOTAL_S/25 — $PRI"
  echo "  │  Pain:$S_PAIN Urg:$S_URG Acc:$S_ACC Conv:$S_CONV Bud:$S_BUD"
  echo "  └─ Signals: $SIGS| Angle: $ANGLE"

  # Write MD
  cat >> "$MD" << EOF
## $IDX. $NAME — $TOTAL_S/25 [$PRI]
Rating: $RATING ($REVIEWS) | ${WEBSITE:-NO WEBSITE} | ${PHONE:-N/A}
Scores: Pain:$S_PAIN Urg:$S_URG Acc:$S_ACC Conv:$S_CONV Bud:$S_BUD
Signals: $SIGS | Angle: $ANGLE
Pain: ${PQUOTE:-None} | Email: ${EMAIL:-N/A} | WA: ${WA:-N/A}

---

EOF

  # Write CSV
  CN=$(echo "$NAME" | sed 's/,/;/g')
  CA=$(echo "$ADDR" | sed 's/,/;/g')
  CP=$(echo "$PQUOTE" | sed "s/,/;/g;s/\"/''/g" | head -c 200)
  echo "\"$CN\",\"${WEBSITE:-}\",\"$CA\",\"${PHONE:-}\",\"${EMAIL:-}\",\"${WA:-}\",\"${IG:-}\",\"${FB:-}\",\"$RATING\",\"$REVIEWS\",\"${DAGE:-N/A}\",\"$GADS\",\"$MADS\",\"$CP\",\"$TOTAL_S\",\"$PRI\",\"$ANGLE\",\"\"" >> "$CSV"

  sleep 1
done

# ─── STEP 3: GENERATE AI MESSAGES ────────────────────────────────
echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "  STEP 3: AI message generation..."
echo "═══════════════════════════════════════════════════════════════"

if [[ -n "${ANTHROPIC_API_KEY:-}" ]]; then
  echo "" >> "$MD"; echo "# Outreach Messages" >> "$MD"; echo "" >> "$MD"
  tail -n +2 "$CSV" | while IFS='' read -r LINE; do
    PN=$(echo "$LINE" | python3 -c "import csv,sys;r=list(csv.reader(sys.stdin))[0];print(r[0])" 2>/dev/null)
    PS=$(echo "$LINE" | python3 -c "import csv,sys;r=list(csv.reader(sys.stdin))[0];print(r[14])" 2>/dev/null)
    PP=$(echo "$LINE" | python3 -c "import csv,sys;r=list(csv.reader(sys.stdin))[0];print(r[15])" 2>/dev/null)
    PA=$(echo "$LINE" | python3 -c "import csv,sys;r=list(csv.reader(sys.stdin))[0];print(r[16])" 2>/dev/null)
    PR=$(echo "$LINE" | python3 -c "import csv,sys;r=list(csv.reader(sys.stdin))[0];print(r[8])" 2>/dev/null)
    PV=$(echo "$LINE" | python3 -c "import csv,sys;r=list(csv.reader(sys.stdin))[0];print(r[9])" 2>/dev/null)
    PQ=$(echo "$LINE" | python3 -c "import csv,sys;r=list(csv.reader(sys.stdin))[0];print(r[13])" 2>/dev/null)

    if [[ "$PP" = "HIGH" ]] || [[ "$PP" = "PRIORITY" ]]; then
      echo "  >> Generating for: $PN ($PP)..."
      PROMPT="Business: ${PN}. Niche: ${NICHE}. Location: ${LOCATION}. Rating: ${PR} stars, ${PV} reviews. Signal: ${PA}. Pain: ${PQ}. Write the WhatsApp message."
      JPROMPT=$(python3 -c "import json;print(json.dumps('$PROMPT'))" 2>/dev/null || echo "\"$PROMPT\"")

      MSG=$(curl -s "https://api.anthropic.com/v1/messages" \
        -H "x-api-key: ${ANTHROPIC_API_KEY}" \
        -H "anthropic-version: 2023-06-01" \
        -H "content-type: application/json" \
        -d "{\"model\":\"claude-haiku-4-5-20251001\",\"max_tokens\":250,\"system\":\"You write short personalised WhatsApp outreach for 7thsense, a web agency in Cape Town SA. We build a free demo first — they pay R5,000 only if they love it. Lead with ONE specific problem. Max 4 sentences. No emojis. Use we not I.\",\"messages\":[{\"role\":\"user\",\"content\":${JPROMPT}}]}" 2>/dev/null \
        | python3 -c "import json,sys;print(json.load(sys.stdin).get('content',[{}])[0].get('text','[error]'))" 2>/dev/null)

      echo "### $PN ($PP)" >> "$MD"
      echo '```' >> "$MD"; echo "$MSG" >> "$MD"; echo '```' >> "$MD"; echo "" >> "$MD"
      sleep 1
    fi
  done
else
  echo "  ANTHROPIC_API_KEY not set — skipping AI messages"
  echo "" >> "$MD"; echo "*AI messages skipped — no ANTHROPIC_API_KEY*" >> "$MD"
fi

# ─── SUMMARY ─────────────────────────────────────────────────────
PC=$(grep -c "PRIORITY" "$CSV" 2>/dev/null || echo 0)
HC=$(grep -c '"HIGH"' "$CSV" 2>/dev/null || echo 0)

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "  PIPELINE COMPLETE"
echo "  Scanned: $TOTAL | PRIORITY: $PC | HIGH: $HC"
echo "  Report: $MD"
echo "  CSV:    $CSV"
echo "═══════════════════════════════════════════════════════════════"
