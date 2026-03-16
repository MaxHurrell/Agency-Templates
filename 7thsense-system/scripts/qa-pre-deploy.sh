#!/usr/bin/env bash
# qa-pre-deploy.sh — Run AFTER building, BEFORE committing/deploying.
# Enforces every CLAUDE.md hard rule automatically.
# Usage: ./qa-pre-deploy.sh path/to/index.html path/to/niche-config.json

set -eu

HTML="$1"
CONFIG="$2"
ERRORS=0
WARNINGS=0

if [ ! -f "$HTML" ]; then echo "ERROR: HTML file not found: $HTML"; exit 1; fi
if [ ! -f "$CONFIG" ]; then echo "ERROR: Config file not found: $CONFIG"; exit 1; fi

echo "==========================================="
echo "  7thsense Pre-Deploy QA Check"
echo "==========================================="
echo "  HTML:   $HTML"
echo "  Config: $CONFIG"
echo ""

fail() { echo "  FAIL: $1"; ERRORS=$((ERRORS + 1)); }
pass() { echo "  OK:   $1"; }
warn() { echo "  WARN: $1"; WARNINGS=$((WARNINGS + 1)); }

# ─── COLOUR RULES ───
echo "--- Colour Rules ---"

PRIMARY=$(python3 -c "import json; print(json.load(open('$CONFIG'))['brand']['primary'])" 2>/dev/null)

# Check brand colour not used as section background outside hero
# Count occurrences of primary colour as background-color (rough heuristic)
BG_USES=$(grep -c "background-color: *${PRIMARY}" "$HTML" 2>/dev/null || echo "0")
# It should appear in hero and maybe buttons, but not >3 times as bg
if [ "$BG_USES" -gt 5 ]; then
  fail "Brand primary ($PRIMARY) used as background $BG_USES times — likely overused outside hero"
else
  pass "Brand primary background usage looks reasonable ($BG_USES occurrences)"
fi

# Footer should use dark colour, not brand primary
FOOTER_BG=$(python3 -c "import json; print(json.load(open('$CONFIG'))['brand']['footer_bg'])" 2>/dev/null)
if grep -q "footer" "$HTML" && ! grep -q "$FOOTER_BG" "$HTML"; then
  warn "Footer may not be using the configured dark background ($FOOTER_BG)"
fi

# ─── TYPOGRAPHY RULES ───
echo ""
echo "--- Typography Rules ---"

if grep -qi "playfair" "$HTML"; then
  fail "Playfair Display detected — HARD RULE VIOLATION"
else
  pass "No Playfair Display"
fi

# Check serif fonts (common offenders)
for font in "Georgia" "Times New Roman" "Merriweather" "Lora" "Cormorant"; do
  if grep -qi "$font" "$HTML"; then
    fail "Ornate serif font detected: $font"
  fi
done

if grep -q "display=swap" "$HTML"; then
  pass "Font loaded with display=swap"
else
  fail "Missing display=swap on font import"
fi

HEADING_FONT=$(python3 -c "import json; print(json.load(open('$CONFIG'))['typography']['heading_font'])" 2>/dev/null)
if grep -q "$HEADING_FONT" "$HTML"; then
  pass "Configured heading font ($HEADING_FONT) found in HTML"
else
  fail "Configured heading font ($HEADING_FONT) not found in HTML"
fi

# ─── MOBILE RULES ───
echo ""
echo "--- Mobile / Floating Bar Rules ---"

PHONE_TYPE=$(python3 -c "import json; print(json.load(open('$CONFIG'))['client']['phone_type'])" 2>/dev/null)
WA_ENABLED=$(python3 -c "import json; print(json.load(open('$CONFIG'))['cta_config']['whatsapp_enabled'])" 2>/dev/null)
FLOAT_TEXT=$(python3 -c "import json; print(json.load(open('$CONFIG'))['cta_config']['floating_bar_text'])" 2>/dev/null)

if [ "$PHONE_TYPE" = "landline" ] && grep -qi "whatsapp" "$HTML"; then
  fail "WhatsApp found in HTML but phone is landline — HARD RULE VIOLATION"
else
  pass "WhatsApp/landline rule OK"
fi

if grep -q "$FLOAT_TEXT" "$HTML"; then
  pass "Floating bar text matches config: '$FLOAT_TEXT'"
else
  warn "Configured floating bar text ('$FLOAT_TEXT') not found in HTML"
fi

# Check tap target sizes (look for min-height: 48px or similar)
if grep -q "min-height: *48px\|min-height: *3rem\|padding: *12px\|padding: *14px\|padding: *16px" "$HTML"; then
  pass "Tap target sizing appears present"
else
  warn "Could not confirm 48px minimum tap targets — verify manually"
fi

# ─── CONTENT RULES ───
echo ""
echo "--- Content Rules ---"

if grep -qi "lorem ipsum" "$HTML"; then
  fail "Lorem ipsum detected — HARD RULE VIOLATION"
else
  pass "No lorem ipsum"
fi

# Check for placeholder patterns
for placeholder in "XXX" "TODO" "PLACEHOLDER" "TBD" "[INSERT"; do
  if grep -qi "$placeholder" "$HTML"; then
    fail "Placeholder text detected: $placeholder"
  fi
done

# Check for VERIFY/DEMO placeholder comments in reviews (Rule 30)
if grep -q '<!-- DEMO:' "$HTML" || grep -q '<!-- VERIFY' "$HTML"; then
  fail "Placeholder review text found — replace with real verbatim quotes before deploying"
else
  pass "No DEMO/VERIFY placeholder comments"
fi

# ─── SPACING RULES ───
echo ""
echo "--- Spacing Rules ---"

# Check for excessive padding (>96px desktop, >64px mobile)
if grep -qE "padding: *1(2[89]|[3-9][0-9]|[0-9]{3,})px" "$HTML"; then
  warn "Possible excessive padding detected (>120px) — check manually"
fi

# ─── TECHNICAL RULES ───
echo ""
echo "--- Technical Rules ---"

if grep -q "<meta.*description" "$HTML"; then
  pass "Meta description present"
else
  fail "Missing meta description"
fi

if grep -q "<title>" "$HTML"; then
  pass "Title tag present"
else
  fail "Missing title tag"
fi

if grep -qi "LocalBusiness\|schema.org" "$HTML"; then
  pass "Schema markup detected"
else
  fail "Missing LocalBusiness schema"
fi

if grep -q 'alt="' "$HTML"; then
  pass "Image alt text present"
  # Count images without alt
  IMG_COUNT=$(grep -c "<img" "$HTML" 2>/dev/null || echo "0")
  ALT_COUNT=$(grep -c 'alt="[^"]\+"' "$HTML" 2>/dev/null || echo "0")
  if [ "$IMG_COUNT" -gt "$ALT_COUNT" ]; then
    warn "$((IMG_COUNT - ALT_COUNT)) images may be missing alt text"
  fi
else
  fail "No alt text found on any images"
fi

# Check CSS variables defined
if grep -q "\-\-primary\|:root" "$HTML"; then
  pass "CSS variables / :root block detected"
else
  fail "No CSS variables found — should define :root block"
fi

# ─── SEO & SOCIAL META ───
echo ""
echo "--- SEO & Social Meta ---"

if grep -q 'og:title' "$HTML"; then
  pass "Open Graph title present"
else
  fail "Missing og:title — shared links will show blank on WhatsApp/Facebook"
fi

if grep -q 'og:image' "$HTML"; then
  pass "Open Graph image present"
else
  fail "Missing og:image — shared links will have no preview image"
fi

if grep -q 'rel="canonical"' "$HTML"; then
  pass "Canonical URL present"
else
  warn "Missing canonical URL"
fi

if grep -q 'rel="icon"\|favicon' "$HTML"; then
  pass "Favicon reference present"
else
  fail "Missing favicon — browser tab shows generic icon"
fi

if grep -q 'theme-color' "$HTML"; then
  pass "Theme colour set for mobile browser chrome"
else
  warn "Missing theme-color meta tag"
fi

# ─── FORM VALIDATION ───
echo ""
echo "--- Form Functionality ---"

if grep -q 'tally\.so' "$HTML"; then
  pass "Tally.so contact form component detected (Rule 16)"
  # Check source attribution parameter
  if grep -q 'source=' "$HTML"; then
    pass "Tally form has source attribution parameter"
  else
    fail "Tally form missing &source= parameter for lead attribution"
  fi
elif grep -q '<form' "$HTML"; then
  if grep -q 'formspree\|netlify\|action="https\|fetch(' "$HTML"; then
    pass "Form has real submission endpoint"
  else
    fail "Form has no real submission — leads go nowhere (use Formspree or similar)"
  fi

  if grep -q 'field-error\|error-message\|invalid' "$HTML"; then
    pass "Form has inline validation/error states"
  else
    warn "Form may lack visible validation error states"
  fi
else
  fail "No contact form found — must use Tally component (Rule 16) or <form> with real endpoint"
fi

# ─── HERO CONTRAST (Rule 15) ───
echo ""
echo "--- Hero Contrast (Rule 15) ---"

if grep -q 'text-shadow' "$HTML"; then
  pass "text-shadow found (hero/nav text contrast)"
else
  fail "No text-shadow found — Rule 15 requires text-shadow on hero headings"
fi

if grep -qE 'rgba\(0,\s*0,\s*0,\s*0\.7' "$HTML"; then
  pass "Directional gradient overlay detected (0.7+ opacity)"
else
  warn "Could not confirm directional gradient overlay — verify hero contrast manually"
fi

# ─── PERFORMANCE ───
echo ""
echo "--- Performance ---"

if grep -q 'rel="preload"' "$HTML"; then
  pass "Preload hint found (likely hero image)"
else
  warn "No preload hints — consider preloading hero image for LCP"
fi

LAZY_COUNT=$(grep -c 'loading="lazy"' "$HTML" 2>/dev/null || echo "0")
if [ "$LAZY_COUNT" -gt 0 ]; then
  pass "Lazy loading on $LAZY_COUNT images"
else
  warn "No lazy loading found on images"
fi

# ─── SECTION ORDER MATCH ───
echo ""
echo "--- Section Order ---"

CONFIGURED_ORDER=$(python3 -c "import json; print(','.join(json.load(open('$CONFIG'))['sections']['order']))" 2>/dev/null)
echo "  Configured: $CONFIGURED_ORDER"
echo "  (Manual verification: check HTML section IDs match this order)"

# ─── DIFFERENTIATION CHECK ───
echo ""
echo "--- Visual Differentiation ---"

HERO_LAYOUT=$(python3 -c "import json; print(json.load(open('$CONFIG'))['hero']['layout'])" 2>/dev/null)
BORDER_RADIUS=$(python3 -c "import json; print(json.load(open('$CONFIG'))['visual_personality']['border_radius'])" 2>/dev/null)
CARD_STYLE=$(python3 -c "import json; print(json.load(open('$CONFIG'))['visual_personality']['card_style'])" 2>/dev/null)
PERSONALITY=$(python3 -c "import json; print(json.load(open('$CONFIG'))['typography']['personality'])" 2>/dev/null)

echo "  Hero layout:  $HERO_LAYOUT"
echo "  Border radius: $BORDER_RADIUS"
echo "  Card style:   $CARD_STYLE"
echo "  Personality:  $PERSONALITY"
echo "  (Compare against previous builds to confirm differentiation)"

# ─── LOCKED COMPONENTS (Rules 17-26) ───
echo ""
echo "--- Locked Components ---"

# Rule 18: Google badge must use full wordmark SVG
if grep -q 'viewBox="0 0 272 92"' "$HTML"; then
  pass "Google wordmark SVG (272x92) present"
else
  if grep -qi 'google' "$HTML" && grep -qi 'review\|rating' "$HTML"; then
    fail "Google reviews present but full wordmark SVG (272x92) missing — use locked component"
  fi
fi

# Rule 19: Stars as HTML entities, not SVGs
STAR_SVGS=$(grep -c 'polygon.*points="12 2 15.09' "$HTML" 2>/dev/null || echo "0")
if [ "$STAR_SVGS" -gt 0 ]; then
  fail "Star SVGs detected ($STAR_SVGS instances) — use HTML entities &#9733; instead (Rule 19)"
else
  pass "No star SVG bloat detected"
fi

# Rule 20: No generic review placeholders
for generic in "Excellent service" "always a pleasant experience" "Best dentist in the area" "wonderful and caring" "highly professional team"; do
  if grep -qi "$generic" "$HTML"; then
    warn "Possible generic review text detected: '$generic' — verify this is a real verbatim Google quote"
  fi
done

# Rule 21: Review avatars — two-letter initials
SINGLE_INITIAL=$(grep -cE 'avatar">[A-Z]</' "$HTML" 2>/dev/null || echo "0")
DOUBLE_INITIAL=$(grep -cE 'avatar">[A-Z][A-Z]</' "$HTML" 2>/dev/null || echo "0")
if [ "$SINGLE_INITIAL" -gt 0 ] && [ "$DOUBLE_INITIAL" -eq 0 ]; then
  fail "Review avatars use single-letter initials — must be two letters (Rule 21)"
fi

# Rule 24: No emoji favicons
if grep -q "favicon.*emoji\|'🦷'\|'🏠'\|'⚖'\|'🔧'\|'💈'" "$HTML"; then
  fail "Emoji favicon detected — use SVG with brand colour + initials (Rule 24)"
fi

# ─── IMAGE FILE VERIFICATION (Rule 26) ───
echo ""
echo "--- Image File Verification ---"
HTML_DIR=$(dirname "$HTML")
MISSING_IMAGES=0
for img_src in $(grep -oE 'src="[^"]+\.(png|jpg|jpeg|webp|svg)"' "$HTML" | sed 's/src="//;s/"$//' | grep -v '^http' | grep -v '^data:'); do
  if [ ! -f "$HTML_DIR/$img_src" ]; then
    fail "Missing image file: $img_src"
    MISSING_IMAGES=$((MISSING_IMAGES + 1))
  fi
done
if [ "$MISSING_IMAGES" -eq 0 ]; then
  pass "All local image files exist"
fi

# ─── FONT RULES (Rule 33) ───
echo ""
echo "--- Font Rules (Rule 33) ---"

if grep -qiE "font-family.*syne|font-family.*bebas|font-family.*oswald|family=Syne|family=Bebas|family=Oswald" "$HTML" 2>/dev/null; then
  fail "Banned font detected (Syne/Bebas/Oswald) — replace with approved font per Rule 33"
else
  pass "No banned fonts detected"
fi

if grep -qiE "font-family.*raleway|family=Raleway" "$HTML" 2>/dev/null; then
  warn "Raleway detected — condensed display font, consider replacing per Rule 33"
fi

# ─── HERO CONTRAST (Rule 34) ───
echo ""
echo "--- Hero Text Contrast (Rule 34) ---"

DARK_HERO_TEXT=$(grep -A5 '\.hero h1\|\.hero-title' "$HTML" 2>/dev/null | grep -c 'color.*#[0-3]' || echo "0")
if [ "$DARK_HERO_TEXT" -gt 0 ]; then
  warn "Possible dark text colour on hero — verify contrast per Rule 34"
else
  pass "Hero text colour appears light/white"
fi

# ─── GOOGLE LOGO IN HERO (Rule 35) ───
echo ""
echo "--- Google Logo in Hero (Rule 35) ---"

if grep -qi 'hero-rating\|hero.*google\|google.*hero' "$HTML" 2>/dev/null; then
  if grep -q '4285F4' "$HTML" 2>/dev/null && grep -q 'EA4335' "$HTML" 2>/dev/null; then
    pass "Google brand colours found — logo likely present"
  else
    fail "Google reviews mentioned in hero but Google brand colours not found — Google logo missing per Rule 35"
  fi
else
  pass "No hero Google rating badge found (may be intentional if no reviews)"
fi

# ─── IMAGE PATH VERIFICATION (Rule 36) ───
echo ""
echo "--- Image Path Verification (Rule 36) ---"

MISSING_RULE36=0
for img_src in $(grep -oE 'src="[^"]+\.(jpg|jpeg|png|webp|svg)"' "$HTML" | sed 's/src="//;s/"$//' | grep -v '^http' | grep -v '^data:'); do
  if [ ! -f "$HTML_DIR/$img_src" ]; then
    fail "Missing image: $img_src — fix path before deploying (Rule 36)"
    MISSING_RULE36=$((MISSING_RULE36 + 1))
  fi
done
if [ "$MISSING_RULE36" -eq 0 ]; then
  pass "All image paths resolve to existing files"
fi

# ─── HERO IMAGE QUALITY ───
echo ""
echo "--- Hero Image Quality ---"

HERO_SIZE=$(wc -c < "$HTML_DIR/hero.jpg" 2>/dev/null || echo "0")
if [ "$HERO_SIZE" -lt 100000 ]; then
  fail "Hero image too small (${HERO_SIZE} bytes) — likely a thumbnail, not a full image. Must be >100KB. Regenerate via Gemini."
else
  pass "Hero image size OK (${HERO_SIZE} bytes)"
fi

# ─── BRAND IDENTITY CHECK ───
echo ""
echo "--- Brand Identity Check ---"

if python3 -c "import json,sys; d=json.load(open('$CONFIG')); sys.exit(0 if 'brand_identity' in d else 1)" 2>/dev/null; then
  pass "brand_identity field present in config"
else
  warn "No brand_identity field in config — brand signals may have been missed. Run brand identity extraction before deploying."
fi

# ─── GOOGLE WORDMARK IN HERO (Rule 35 reinforcement) ───
echo ""
echo "--- Google Wordmark in Hero (Rule 35) ---"

if grep -qi 'hero-rating' "$HTML" 2>/dev/null; then
  if grep -qi '272 92\|0 0 272' "$HTML" 2>/dev/null; then
    pass "Hero rating badge has Google wordmark SVG (272x92)"
  else
    fail "Hero rating badge exists but Google wordmark SVG (272x92) not found — Rule 35 violated"
  fi
fi

# ─── HERO TEXT CONTRAST CHECK ───
echo ""
echo "--- Contrast Check ---"

if grep -qiE 'hero.*color.*#[0-2][0-9a-f]{5}|\.hero h1.*color.*#1|\.hero h1.*color.*rgb\(1[0-9]' "$HTML" 2>/dev/null; then
  warn "Possible dark text colour on hero — verify contrast per Rule 34. Hero text must be #ffffff"
fi

# ─── RESULT ───
echo ""
echo "==========================================="
if [ "$ERRORS" -gt 0 ]; then
  echo "  RESULT: FAILED — $ERRORS errors, $WARNINGS warnings"
  echo "  DO NOT DEPLOY. Fix all errors first."
  exit 1
else
  echo "  RESULT: PASSED — 0 errors, $WARNINGS warnings"
  echo "  Ready to deploy."
  exit 0
fi
