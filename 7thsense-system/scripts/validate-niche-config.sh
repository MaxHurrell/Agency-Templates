#!/usr/bin/env bash
# validate-niche-config.sh - Run BEFORE building. Catches config errors early.
# Usage: bash validate-niche-config.sh path/to/niche-config.json

set -eu

CONFIG="$1"
ERRORS=0
WARNINGS=0

if [ ! -f "$CONFIG" ]; then
  echo "ERROR: Config file not found: $CONFIG"
  exit 1
fi

echo "==========================================="
echo "  7thsense Niche Config Validator"
echo "==========================================="
echo "  File: $CONFIG"
echo ""

get_val() {
  python3 -c "
import json, sys
d = json.load(open(sys.argv[1]))
keys = sys.argv[2].split('.')
v = d
for k in keys:
    v = v.get(k, '')
    if v == '': break
print(v if v else '')
" "$CONFIG" "$1" 2>/dev/null || echo ""
}

check_required() {
  local jpath="$1"
  local label="$2"
  local val
  val=$(get_val "$jpath")
  if [ -z "$val" ] || [ "$val" = "None" ] || [ "$val" = "" ]; then
    echo "  FAIL: $label is empty or missing"
    ERRORS=$((ERRORS + 1))
  else
    echo "  OK:   $label = $val"
  fi
}

check_one_of() {
  local jpath="$1"
  local label="$2"
  local allowed="$3"
  local val
  val=$(get_val "$jpath")
  if echo "$allowed" | grep -qw "$val"; then
    echo "  OK:   $label = $val"
  else
    echo "  FAIL: $label = '$val' not in allowed list"
    ERRORS=$((ERRORS + 1))
  fi
}

echo "--- Client Info ---"
check_required "client.business_name" "business_name"
check_required "client.niche" "niche"
check_required "client.phone" "phone"
check_required "client.city" "city"

echo ""
echo "--- Brand Colours ---"
check_required "brand.primary" "primary colour"
check_required "brand.footer_bg" "footer background"
check_required "brand.extraction_method" "colour extraction method"

echo ""
echo "--- Typography ---"
ALLOWED_HEADINGS="DM Sans Syne Outfit Plus Jakarta Sans Urbanist Satoshi Cabinet Grotesk General Sans"
check_one_of "typography.heading_font" "heading_font" "$ALLOWED_HEADINGS"

echo ""
echo "--- Hero ---"
check_required "hero.layout" "hero layout"
check_required "hero.cta_text" "hero CTA text"

echo ""
echo "--- Sections ---"
SECTION_COUNT=$(python3 -c "
import json, sys
d = json.load(open(sys.argv[1]))
print(len(d.get('sections',{}).get('order',[])))
" "$CONFIG" 2>/dev/null || echo "0")

if [ "$SECTION_COUNT" -lt 7 ]; then
  echo "  FAIL: Only $SECTION_COUNT sections -- minimum is 7"
  ERRORS=$((ERRORS + 1))
elif [ "$SECTION_COUNT" -gt 12 ]; then
  echo "  WARN: $SECTION_COUNT sections -- consider trimming to 10 max"
  WARNINGS=$((WARNINGS + 1))
else
  echo "  OK:   $SECTION_COUNT sections in order"
fi

FIRST_SECTION=$(python3 -c "
import json, sys
d = json.load(open(sys.argv[1]))
order = d.get('sections',{}).get('order',[])
print(order[0] if order else '')
" "$CONFIG" 2>/dev/null || echo "")

if [ "$FIRST_SECTION" != "hero" ]; then
  echo "  FAIL: First section must be 'hero', got '$FIRST_SECTION'"
  ERRORS=$((ERRORS + 1))
else
  echo "  OK:   First section is hero"
fi

echo ""
echo "--- CTA Config ---"
check_required "cta_config.floating_bar_text" "floating bar text"
check_required "cta_config.primary_action" "primary CTA"

PHONE_TYPE=$(get_val "client.phone_type")
WA_ENABLED=$(get_val "cta_config.whatsapp_enabled")
if [ "$PHONE_TYPE" = "landline" ] && [ "$WA_ENABLED" = "True" ]; then
  echo "  FAIL: WhatsApp enabled but phone is landline -- HARD RULE VIOLATION"
  ERRORS=$((ERRORS + 1))
else
  echo "  OK:   WhatsApp/phone type consistent"
fi

echo ""
echo "--- Copy Register ---"
check_required "copy_register.emotional_tone" "emotional tone"
check_required "copy_register.formality" "formality level"

echo ""
echo "--- Images ---"
check_required "images.source" "image source"
check_required "images.hero_image_prompt" "hero image prompt"

echo ""
echo "==========================================="
if [ "$ERRORS" -gt 0 ]; then
  echo "  RESULT: FAILED -- $ERRORS errors, $WARNINGS warnings"
  echo "  Fix all errors before building."
  exit 1
else
  echo "  RESULT: PASSED -- 0 errors, $WARNINGS warnings"
  echo "  Config is ready. Start building."
  exit 0
fi
