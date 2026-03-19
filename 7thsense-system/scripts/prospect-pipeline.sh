#!/usr/bin/env zsh
# ═══════════════════════════════════════════════════════════════════
# 7thsense AUTOMATED PROSPECT PIPELINE v2
# ═══════════════════════════════════════════════════════════════════
# Usage: zsh prospect-pipeline.sh "Niche" "Location" [--count N]
# Example: zsh prospect-pipeline.sh "dentist" "Bellville Cape Town" --count 5
#
# 5-Dimension 25-Point Scoring:
#   D1 Website Quality (0-5)
#   D2 Online Visibility Gap (0-5)
#   D3 Budget Signals (0-5)
#   D4 Pain Signals (0-5)
#   D5 Urgency Signals (0-5)
# ═══════════════════════════════════════════════════════════════════
setopt pipefail 2>/dev/null

SCRIPT_DIR="${0:A:h}"
NICHE="${1:-}"
LOCATION="${2:-}"
COUNT=10

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
MASTER="$OUTDIR/master-leads.csv"

# Ensure master-leads.csv exists
if [[ ! -f "$MASTER" ]]; then
  echo 'Business Name,Website,Phone,Email,WhatsApp,Instagram,Facebook,Google Rating,Review Count,Place ID,Domain Status,Score,Priority,Status,Last Updated,Data Source,Data Confidence' > "$MASTER"
fi

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "  7THSENSE PROSPECT PIPELINE v2"
echo "  Niche: $NICHE | Location: $LOCATION | Count: $COUNT | $DATE"
echo "  Master CSV: $MASTER"
echo "═══════════════════════════════════════════════════════════════"
echo ""

# ─── HELPER: Check master-leads.csv for existing data ─────────────
lookup_master() {
  local bname="$1"
  grep -i "\"${bname}\"" "$MASTER" 2>/dev/null | head -1
}

# ─── HELPER: Website verification chain ───────────────────────────
verify_website() {
  local bname="$1"
  local api_website="$2"
  local result="" vstatus="NOT_FOUND" confidence="LOW"

  # Step 1: Check master-leads.csv
  local existing=$(lookup_master "$bname")
  if [[ -n "$existing" ]]; then
    local master_web=$(echo "$existing" | python3 -c "import csv,sys;r=list(csv.reader(sys.stdin))[0];print(r[1])" 2>/dev/null)
    local master_status=$(echo "$existing" | python3 -c "import csv,sys;r=list(csv.reader(sys.stdin))[0];print(r[10])" 2>/dev/null)
    if [[ -n "$master_web" ]] && [[ "$master_status" = "VERIFIED" ]]; then
      echo "WEBSITE=${master_web}"
      echo "DOMAIN_STATUS=VERIFIED"
      echo "DATA_CONFIDENCE=HIGH"
      return
    fi
    [[ -n "$master_web" ]] && result="$master_web"
  fi

  # Step 2: Google Place Details website field
  if [[ -z "$result" ]] && [[ -n "$api_website" ]]; then
    result="$api_website"
  fi

  # Step 3: Common domain patterns
  if [[ -z "$result" ]]; then
    local clean=$(echo "$bname" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]//g')
    local surname=$(echo "$bname" | awk '{print $NF}' | tr '[:upper:]' '[:lower:]')
    local patterns=("${clean}.co.za" "${clean}.com" "dr${surname}.co.za" "${surname}dental.co.za" "${clean}dental.co.za" "www.${clean}.co.za")
    for pat in "${patterns[@]}"; do
      local code=$(curl -sI --max-time 5 "https://${pat}" 2>/dev/null | head -1 | grep -oE '[0-9]{3}' | head -1)
      if [[ "$code" = "200" ]] || [[ "$code" = "301" ]] || [[ "$code" = "302" ]]; then
        result="https://${pat}"
        break
      fi
    done
  fi

  # Step 4: curl HEAD verification
  if [[ -n "$result" ]]; then
    local domain=$(echo "$result" | sed 's|https\?://||;s|/.*||;s|www\.||')
    local vcode=$(curl -sI --max-time 6 "https://${domain}" 2>/dev/null | head -1 | grep -oE '[0-9]{3}' | head -1)
    if [[ "$vcode" = "200" ]] || [[ "$vcode" = "301" ]] || [[ "$vcode" = "302" ]]; then
      vstatus="VERIFIED"; confidence="HIGH"
    else
      vcode=$(curl -sI --max-time 6 "http://${domain}" 2>/dev/null | head -1 | grep -oE '[0-9]{3}' | head -1)
      if [[ "$vcode" = "200" ]] || [[ "$vcode" = "301" ]] || [[ "$vcode" = "302" ]]; then
        vstatus="VERIFIED"; confidence="HIGH"; result="http://${domain}"
      else
        vstatus="UNVERIFIED"; confidence="MEDIUM"
      fi
    fi
  fi

  echo "WEBSITE=${result}"
  echo "DOMAIN_STATUS=${vstatus}"
  echo "DATA_CONFIDENCE=${confidence}"
}

# ─── HELPER: Hellopeter complaints ────────────────────────────────
check_hellopeter() {
  local bname="$1"
  local encoded=$(echo "$bname" | sed 's/ /+/g')
  local page=$(curl -sL --max-time 8 "https://www.hellopeter.com/search?q=${encoded}" 2>/dev/null)
  local count=$(echo "$page" | grep -oE '[0-9]+ review' | head -1 | grep -oE '[0-9]+')
  local complaint=$(echo "$page" | grep -oiE '[^.]*((terrible|horrible|worst|never again|waste|avoid|scam|rude|unprofessional)[^.]*\.)' 2>/dev/null | head -1 | head -c 200)
  echo "HP_COUNT=${count:-0}"
  echo "HP_QUOTE=${complaint}"
}

# ─── HELPER: Pain language mining from reviews ────────────────────
mine_pain_language() {
  local reviews_json="$1"
  local pain=$(echo "$reviews_json" | python3 -c "
import json,sys
try:
  data=json.load(sys.stdin)
  reviews=data.get('result',{}).get('reviews',[])
  keywords=['can\\'t find','no website','hard to reach','no response','couldn\\'t book','no online booking','website doesn\\'t work','couldn\\'t contact','no email','goes to voicemail','never answer','no reply','impossible to reach','couldn\\'t get hold','waiting forever']
  for r in reviews:
    txt=r.get('text','').lower()
    for kw in keywords:
      if kw in txt:
        print('PAIN_FOUND=YES')
        print('PAIN_QUOTE='+r.get('text','')[:200])
        sys.exit(0)
  print('PAIN_FOUND=NO')
  print('PAIN_QUOTE=')
except:
  print('PAIN_FOUND=NO')
  print('PAIN_QUOTE=')
" 2>/dev/null)
  echo "$pain"
}

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

# Init output
echo "# 7thsense Pipeline v2: $NICHE in $LOCATION — $DATE" > "$MD"
echo "" >> "$MD"
echo "Business Name,Website,Location,Phone,Email,WhatsApp,Facebook,Rating,Reviews,Place ID,Domain Status,Domain Age,Google Ads,Meta Ads,Pain Quote,Hellopeter,D1_WebQuality,D2_Visibility,D3_Budget,D4_Pain,D5_Urgency,Total Score,Priority,Angle,Data Confidence" > "$CSV"

# ─── STEP 2: PROCESS EACH BUSINESS ───────────────────────────────
IDX=0
echo "$PLACES" | while IFS=$'\t' read -r NAME PID RATING REVIEWS ADDR; do
  IDX=$((IDX + 1))
  echo ""
  echo "═══ [$IDX/$TOTAL] $NAME ═══"
  echo "  $RATING stars | $REVIEWS reviews | $ADDR"

  # ─── Place Details (two-step: we already have place_id from textsearch) ───
  DET=$(curl -s "https://maps.googleapis.com/maps/api/place/details/json?place_id=${PID}&fields=name,formatted_phone_number,website,rating,user_ratings_total,formatted_address,reviews&key=${GOOGLE_MAPS_API_KEY}")
  API_WEBSITE=$(echo "$DET" | python3 -c "import json,sys;print(json.load(sys.stdin).get('result',{}).get('website',''))" 2>/dev/null)
  PHONE=$(echo "$DET" | python3 -c "import json,sys;print(json.load(sys.stdin).get('result',{}).get('formatted_phone_number',''))" 2>/dev/null)

  # ─── Website verification chain ───
  VOUT=$(verify_website "$NAME" "$API_WEBSITE")
  WEBSITE=$(echo "$VOUT" | grep "^WEBSITE=" | cut -d= -f2-)
  DSTATUS=$(echo "$VOUT" | grep "^DOMAIN_STATUS=" | cut -d= -f2)
  DCONF=$(echo "$VOUT" | grep "^DATA_CONFIDENCE=" | cut -d= -f2)

  DOMAIN=""
  [[ -n "$WEBSITE" ]] && DOMAIN=$(echo "$WEBSITE" | sed 's|https\?://||;s|/.*||;s|www\.||')
  echo "  Web: ${WEBSITE:-NONE} [$DSTATUS/$DCONF] | Phone: ${PHONE:-N/A}"

  # Init dimension scores
  D1=0; D2=0; D3=0; D4=0; D5=0
  SIGS=""; ANGLE="general"; PQUOTE=""; GADS="NO"; MADS="NO"
  DAGE="N/A"; EMAIL=""; WA=""; FB=""; HP_COUNT=0

  # ─── D1: Website Quality (0-5) ───
  if [[ -z "$WEBSITE" ]] || [[ "$DSTATUS" = "NOT_FOUND" ]]; then
    D1=5; SIGS="no_website "; ANGLE="no_website"
    echo "  >> NO WEBSITE — D1=5"
  else
    SRC=$(curl -sL --max-time 8 "$WEBSITE" 2>/dev/null)
    if [[ -z "$SRC" ]]; then
      D1=4; SIGS="unreachable "; ANGLE="broken_site"
      echo "  >> Site unreachable — D1=4"
    else
      V=$(echo "$SRC" | grep -ci "viewport" 2>/dev/null); V=${V:-0}; [[ "$V" =~ ^[0-9]+$ ]] || V=0
      F=$(echo "$SRC" | grep -ciE '<form|<input|tally\.so|typeform' 2>/dev/null); F=${F:-0}; [[ "$F" =~ ^[0-9]+$ ]] || F=0
      T=$(echo "$SRC" | grep -ci "tel:" 2>/dev/null); T=${T:-0}; [[ "$T" =~ ^[0-9]+$ ]] || T=0
      W=$(echo "$SRC" | grep -ciE 'wa\.me|whatsapp' 2>/dev/null); W=${W:-0}; [[ "$W" =~ ^[0-9]+$ ]] || W=0
      RV=$(echo "$SRC" | grep -ciE 'review|testimonial|google.*review' 2>/dev/null); RV=${RV:-0}; [[ "$RV" =~ ^[0-9]+$ ]] || RV=0
      SQ=0
      [[ $V -gt 0 ]] && SQ=$((SQ+1))
      [[ $F -gt 0 ]] && SQ=$((SQ+1))
      [[ $T -gt 0 ]] && SQ=$((SQ+1))
      [[ $W -gt 0 ]] && SQ=$((SQ+1))
      [[ $RV -gt 0 ]] && SQ=$((SQ+1))
      curl -sI --max-time 4 "https://$DOMAIN" >/dev/null 2>&1 && SQ=$((SQ+1))

      # Map site quality 0-6 → D1 (inverted: worse site = higher score = higher priority)
      if [[ $SQ -le 1 ]]; then D1=4; SIGS="terrible_site "; ANGLE="broken_site"
      elif [[ $SQ -le 2 ]]; then D1=3; SIGS="weak_site "; ANGLE="weak_site"
      elif [[ $SQ -le 3 ]]; then D1=2; SIGS="mediocre_site "
      elif [[ $SQ -le 4 ]]; then D1=1; SIGS="decent_site "
      else D1=0; SIGS="good_site "; fi

      echo "  >> Site quality: $SQ/6 → D1=$D1"

      # Contact enrichment
      EMAIL=$(echo "$SRC" | grep -oE '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' | grep -v 'example\|test\|noreply\|wordpress\|wix\|sentry' | sort -u | head -1)
      WA=$(echo "$SRC" | grep -oE 'wa\.me/[0-9]+' | head -1)
      [[ -n "$WA" ]] && WA="https://$WA"
    fi
  fi

  # ─── D2: Online Visibility Gap (0-5) ───
  if [[ "$REVIEWS" -eq 0 ]] && [[ -z "$WEBSITE" ]]; then D2=5
  elif [[ "$REVIEWS" -lt 10 ]]; then D2=4
  elif [[ "$REVIEWS" -lt 30 ]]; then D2=3
  elif [[ "$REVIEWS" -lt 100 ]]; then D2=2
  elif [[ "$REVIEWS" -lt 200 ]]; then D2=1
  else D2=0; fi
  # Boost if rating low
  if (( $(echo "$RATING < 4.0" | bc -l 2>/dev/null || echo 0) )); then D2=$((D2 > 4 ? 5 : D2+1)); fi
  [[ $D2 -gt 5 ]] && D2=5
  echo "  >> Visibility gap → D2=$D2"

  # ─── D3: Budget Signals (0-5) ───
  if [[ -n "$DOMAIN" ]]; then
    # Google Ads
    AO=$(bash "$SCRIPT_DIR/detect-google-ads.sh" "$DOMAIN" 2>/dev/null)
    GADS=$(echo "$AO" | grep "GOOGLE_ADS=" | cut -d= -f2)
    if [[ "$GADS" = "YES" ]] || [[ "$GADS" = "LIKELY" ]]; then
      D3=$((D3+2)); SIGS="${SIGS}gads "; ANGLE="ad_waste"
      echo "  >> Google Ads: $GADS (+2 budget)"
    fi

    # Meta Ads
    MO=$(bash "$SCRIPT_DIR/detect-meta-ads.sh" "$DOMAIN" 2>/dev/null)
    MADS=$(echo "$MO" | grep "META_ADS=" | cut -d= -f2)
    if [[ "$MADS" = "YES" ]] || [[ "$MADS" = "LIKELY" ]]; then
      D3=$((D3+2)); SIGS="${SIGS}meta "
      [[ "$ANGLE" = "general" ]] && ANGLE="ad_waste"
      echo "  >> Meta Ads: $MADS (+2 budget)"
    fi

    # Hiring signal
    HO=$(bash "$SCRIPT_DIR/check-hiring.sh" "$NAME" 2>/dev/null)
    HIRING=$(echo "$HO" | grep "HIRING=" | cut -d= -f2)
    if [[ "$HIRING" = "YES" ]]; then
      D3=$((D3+1)); SIGS="${SIGS}hiring "
      echo "  >> Hiring detected (+1 budget)"
    fi

    # Social (Facebook only — Instagram removed per spec)
    SO=$(bash "$SCRIPT_DIR/check-social-activity.sh" "$DOMAIN" 2>/dev/null)
    FB=$(echo "$SO" | grep "^FACEBOOK=" | cut -d= -f2); [[ "$FB" = "NOT_FOUND" ]] && FB=""

    # Domain age
    DA=$(bash "$SCRIPT_DIR/check-domain-age.sh" "$DOMAIN" 2>/dev/null)
    DAGE=$(echo "$DA" | grep "DOMAIN_AGE_YEARS=" | cut -d= -f2)
  fi
  [[ $D3 -gt 5 ]] && D3=5
  echo "  >> Budget signals → D3=$D3"

  # ─── D4: Pain Signals (0-5) ───
  # Negative reviews
  PLOUT=$(mine_pain_language "$DET")
  PF=$(echo "$PLOUT" | grep "^PAIN_FOUND=" | cut -d= -f2)
  if [[ "$PF" = "YES" ]]; then
    PQUOTE=$(echo "$PLOUT" | grep "^PAIN_QUOTE=" | cut -d= -f2-)
    D4=$((D4+2)); SIGS="${SIGS}pain_reviews "
    [[ "$ANGLE" = "general" ]] && ANGLE="reviews"
    echo "  >> Pain language in reviews (+2)"
  fi

  # Also try the dedicated mine script
  if [[ "$PF" != "YES" ]]; then
    RO=$(bash "$SCRIPT_DIR/mine-negative-reviews.sh" "$PID" 2>/dev/null)
    PL=$(echo "$RO" | grep "PAIN_LANGUAGE=" | cut -d= -f2)
    if [[ "$PL" = "YES" ]]; then
      PQUOTE=$(echo "$RO" | sed -n '/---QUOTES---/,$ p' | tail -n +2 | head -1)
      D4=$((D4+2)); SIGS="${SIGS}pain_reviews "
      [[ "$ANGLE" = "general" ]] && ANGLE="reviews"
      echo "  >> Pain language (mine script) (+2)"
    fi
  fi

  # Hellopeter complaints
  HPOUT=$(check_hellopeter "$NAME")
  HP_COUNT=$(echo "$HPOUT" | grep "^HP_COUNT=" | cut -d= -f2)
  HP_QUOTE=$(echo "$HPOUT" | grep "^HP_QUOTE=" | cut -d= -f2-)
  if [[ "${HP_COUNT:-0}" -gt 0 ]]; then
    D4=$((D4+1)); SIGS="${SIGS}hellopeter "
    echo "  >> Hellopeter: ${HP_COUNT} mentions (+1)"
    [[ -z "$PQUOTE" ]] && [[ -n "$HP_QUOTE" ]] && PQUOTE="$HP_QUOTE"
  fi

  # Broken pages
  if [[ "$DSTATUS" = "UNVERIFIED" ]] || [[ -n "$(echo "$SIGS" | grep -o 'unreachable')" ]]; then
    D4=$((D4+1)); echo "  >> Broken/unreachable site (+1)"
  fi

  # No contact info
  if [[ -z "$PHONE" ]] && [[ -z "$EMAIL" ]]; then
    D4=$((D4+1)); echo "  >> No contact info visible (+1)"
  fi

  [[ $D4 -gt 5 ]] && D4=5
  echo "  >> Pain signals → D4=$D4"

  # ─── D5: Urgency Signals (0-5) ───
  # Ads to weak page
  if [[ $D3 -ge 2 ]] && [[ $D1 -ge 3 ]]; then
    D5=$((D5+2)); SIGS="${SIGS}burning_money "
    ANGLE="ad_waste"
    echo "  >> Running ads to weak site (+2 urgency)"
  fi

  # Domain expiring
  EU=$(echo "$DA" | grep "EXPIRY_URGENCY=" | cut -d= -f2)
  [[ "$EU" = "CRITICAL" ]] && D5=$((D5+1)) && SIGS="${SIGS}expiring " && echo "  >> Domain expiring (+1)"

  # New business (< 1 year domain)
  if [[ -n "$DAGE" ]] && [[ "$DAGE" != "N/A" ]] && [[ "$DAGE" != "UNKNOWN" ]]; then
    if (( $(echo "$DAGE < 1" | bc -l 2>/dev/null || echo 0) )); then
      D5=$((D5+1)); SIGS="${SIGS}new_biz "
      echo "  >> New business (<1yr) (+1)"
    fi
  fi

  # Business age vs presence gap (STAGNANT)
  if [[ -n "$DAGE" ]] && [[ "$DAGE" != "N/A" ]] && [[ "$DAGE" != "UNKNOWN" ]]; then
    if (( $(echo "$DAGE > 5" | bc -l 2>/dev/null || echo 0) )) && [[ $D1 -ge 3 ]]; then
      D5=$((D5+1)); SIGS="${SIGS}stagnant "
      echo "  >> Stagnant: old domain + poor site (+1)"
    fi
  fi

  [[ $D5 -gt 5 ]] && D5=5
  echo "  >> Urgency signals → D5=$D5"

  # ─── TOTAL SCORE & ROUTING ───
  TOTAL_S=$((D1+D2+D3+D4+D5))
  PRI="PASS"
  [[ $TOTAL_S -ge 10 ]] && PRI="MEDIUM"
  [[ $TOTAL_S -ge 15 ]] && PRI="HIGH"
  [[ $TOTAL_S -ge 20 ]] && PRI="CRITICAL"

  echo ""
  echo "  ┌─ SCORE: $TOTAL_S/25 — $PRI"
  echo "  │  D1_Web:$D1 D2_Vis:$D2 D3_Bud:$D3 D4_Pain:$D4 D5_Urg:$D5"
  echo "  └─ Signals: $SIGS| Angle: $ANGLE | Confidence: $DCONF"

  # ─── Write to MD report ───
  cat >> "$MD" << MDEOF
## $IDX. $NAME — $TOTAL_S/25 [$PRI]
Rating: $RATING ($REVIEWS reviews) | ${WEBSITE:-NO WEBSITE} [$DSTATUS]
Phone: ${PHONE:-N/A} | Email: ${EMAIL:-N/A} | WA: ${WA:-N/A}
Scores: D1_Web:$D1 D2_Vis:$D2 D3_Bud:$D3 D4_Pain:$D4 D5_Urg:$D5
Signals: $SIGS | Angle: $ANGLE | Confidence: $DCONF
Pain: ${PQUOTE:-None found}
Hellopeter: ${HP_COUNT:-0} mentions
Domain Age: ${DAGE:-N/A}

---

MDEOF

  # ─── Write to CSV ───
  CN=$(echo "$NAME" | sed 's/,/;/g')
  CA=$(echo "$ADDR" | sed 's/,/;/g')
  CP=$(echo "$PQUOTE" | sed "s/,/;/g;s/\"/''/g" | head -c 200)
  echo "\"$CN\",\"${WEBSITE:-}\",\"$CA\",\"${PHONE:-}\",\"${EMAIL:-}\",\"${WA:-}\",\"${FB:-}\",\"$RATING\",\"$REVIEWS\",\"${PID}\",\"$DSTATUS\",\"${DAGE:-N/A}\",\"$GADS\",\"$MADS\",\"$CP\",\"${HP_COUNT:-0}\",\"$D1\",\"$D2\",\"$D3\",\"$D4\",\"$D5\",\"$TOTAL_S\",\"$PRI\",\"$ANGLE\",\"$DCONF\"" >> "$CSV"

  # ─── Update master-leads.csv ───
  # Remove old entry if exists, append new
  if grep -qi "\"${CN}\"" "$MASTER" 2>/dev/null; then
    grep -vi "\"${CN}\"" "$MASTER" > "${MASTER}.tmp" && mv "${MASTER}.tmp" "$MASTER"
  fi
  echo "\"$CN\",\"${WEBSITE:-}\",\"${PHONE:-}\",\"${EMAIL:-}\",\"${WA:-}\",\"\",\"${FB:-}\",\"$RATING\",\"$REVIEWS\",\"${PID}\",\"$DSTATUS\",\"$TOTAL_S\",\"$PRI\",\"pipeline\",\"$DATE\",\"pipeline-${TS}\",\"$DCONF\"" >> "$MASTER"

  sleep 1
done

# ─── STEP 3: AI MESSAGES ─────────────────────────────────────────
echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "  STEP 3: AI message generation..."
echo "═══════════════════════════════════════════════════════════════"

if [[ -n "${ANTHROPIC_API_KEY:-}" ]]; then
  echo "" >> "$MD"; echo "# Outreach Messages" >> "$MD"; echo "" >> "$MD"
  tail -n +2 "$CSV" | while IFS='' read -r LINE; do
    PN=$(echo "$LINE" | python3 -c "import csv,sys;r=list(csv.reader(sys.stdin))[0];print(r[0])" 2>/dev/null)
    PP=$(echo "$LINE" | python3 -c "import csv,sys;r=list(csv.reader(sys.stdin))[0];print(r[22])" 2>/dev/null)
    PA=$(echo "$LINE" | python3 -c "import csv,sys;r=list(csv.reader(sys.stdin))[0];print(r[23])" 2>/dev/null)
    PR=$(echo "$LINE" | python3 -c "import csv,sys;r=list(csv.reader(sys.stdin))[0];print(r[7])" 2>/dev/null)
    PV=$(echo "$LINE" | python3 -c "import csv,sys;r=list(csv.reader(sys.stdin))[0];print(r[8])" 2>/dev/null)
    PQ=$(echo "$LINE" | python3 -c "import csv,sys;r=list(csv.reader(sys.stdin))[0];print(r[14])" 2>/dev/null)

    if [[ "$PP" = "HIGH" ]] || [[ "$PP" = "CRITICAL" ]]; then
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
CC=$(grep -c '"CRITICAL"' "$CSV" 2>/dev/null || echo 0)
HC=$(grep -c '"HIGH"' "$CSV" 2>/dev/null || echo 0)
MC=$(grep -c '"MEDIUM"' "$CSV" 2>/dev/null || echo 0)

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "  PIPELINE v2 COMPLETE"
echo "  Scanned: $TOTAL | CRITICAL: $CC | HIGH: $HC | MEDIUM: $MC"
echo "  Report: $MD"
echo "  CSV:    $CSV"
echo "  Master: $MASTER (updated)"
echo "═══════════════════════════════════════════════════════════════"
