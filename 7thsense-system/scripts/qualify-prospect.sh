#!/bin/bash
# ═══════════════════════════════════════
# 7thsense Prospect Pre-Qualification Script
# Usage: bash qualify-prospect.sh DOMAIN "Business Name"
# Example: bash qualify-prospect.sh bellvilledentist.co.za "Werner Joubert Dental"
# ═══════════════════════════════════════

set -uo pipefail

DOMAIN="${1:-}"
BUSINESS="${2:-}"
SCORE=0
FLAGS=""
DATE=$(date +"%Y-%m-%d %H:%M")

if [ -z "$DOMAIN" ] || [ -z "$BUSINESS" ]; then
  echo "Usage: bash qualify-prospect.sh DOMAIN \"Business Name\""
  echo "Example: bash qualify-prospect.sh bellvilledentist.co.za \"Werner Joubert Dental\""
  exit 1
fi

# Strip protocol if provided
DOMAIN=$(echo "$DOMAIN" | sed 's|https\?://||' | sed 's|/.*||')

echo ""
echo "═══════════════════════════════════════"
echo "PROSPECT QUALIFICATION REPORT"
echo "═══════════════════════════════════════"
echo "Business: $BUSINESS"
echo "Domain:   $DOMAIN"
echo "Date:     $DATE"
echo ""

# ─── DOMAIN INTELLIGENCE ───
echo "DOMAIN INTELLIGENCE"
echo "─────────────────────────────────────"

# Registrar and registrant
WHOIS_DATA=$(whois "$DOMAIN" 2>/dev/null || echo "WHOIS_FAILED")
if [ "$WHOIS_DATA" = "WHOIS_FAILED" ]; then
  echo "  Registrar:   LOOKUP FAILED"
  echo "  Registrant:  UNKNOWN"
  SCORE=$((SCORE + 1))
  FLAGS="$FLAGS\n  - WHOIS lookup failed — manual check needed"
else
  REGISTRAR=$(echo "$WHOIS_DATA" | grep -iE "^registrar:" | head -1 | sed 's/^[^:]*: *//' || echo "Unknown")
  REGISTRANT=$(echo "$WHOIS_DATA" | grep -iE "^registrant" | head -1 | sed 's/^[^:]*: *//' || echo "Private/Unknown")
  EXPIRY=$(echo "$WHOIS_DATA" | grep -iE "expir|expiry|renewal" | head -1 | sed 's/^[^:]*: *//' || echo "Unknown")
  STATUS=$(echo "$WHOIS_DATA" | grep -iE "^(domain )?status:" | head -1 | sed 's/^[^:]*: *//' || echo "Unknown")

  [ -z "$REGISTRAR" ] && REGISTRAR="Unknown"
  [ -z "$REGISTRANT" ] && REGISTRANT="Private/Unknown"
  [ -z "$EXPIRY" ] && EXPIRY="Unknown"

  echo "  Registrar:   $REGISTRAR"
  echo "  Registrant:  $REGISTRANT"
  echo "  Expiry:      $EXPIRY"
  echo "  Status:      $STATUS"

  # Check registrant match
  BUSINESS_LOWER=$(echo "$BUSINESS" | tr '[:upper:]' '[:lower:]')
  REGISTRANT_LOWER=$(echo "$REGISTRANT" | tr '[:upper:]' '[:lower:]')
  if echo "$REGISTRANT_LOWER" | grep -qi "private\|unknown\|redacted\|not disclosed"; then
    echo "  Ownership:   PRIVATE REGISTRATION — verify with client"
    SCORE=$((SCORE + 1))
  elif echo "$REGISTRANT_LOWER" | grep -qi "$(echo "$BUSINESS_LOWER" | cut -d' ' -f1)"; then
    echo "  Ownership:   MATCH — registrant appears to be the business"
  else
    echo "  Ownership:   MISMATCH — registrant does not match business name"
    SCORE=$((SCORE + 2))
    FLAGS="$FLAGS\n  - Domain registrant does not match business name — possible agency ownership (DOMAIN-PLAYBOOK Scenario 3)"
  fi
fi

# DNS records
echo ""
A_RECORD=$(dig "$DOMAIN" +short 2>/dev/null | head -1 || echo "FAILED")
WWW_RECORD=$(dig "www.$DOMAIN" +short 2>/dev/null | head -1 || echo "FAILED")
MX_RECORD=$(dig MX "$DOMAIN" +short 2>/dev/null | head -3 || echo "NONE")

echo "  A Record:    $A_RECORD"
echo "  WWW:         $WWW_RECORD"

if [ -n "$MX_RECORD" ] && [ "$MX_RECORD" != "NONE" ]; then
  echo "  MX Records:  $(echo "$MX_RECORD" | tr '\n' ', ' | sed 's/,$//')"
  # Identify email provider
  if echo "$MX_RECORD" | grep -qi "google\|gmail\|aspmx"; then
    echo "  Email:       Google Workspace — PRESERVE MX during transition"
  elif echo "$MX_RECORD" | grep -qi "outlook\|microsoft"; then
    echo "  Email:       Microsoft 365 — PRESERVE MX during transition"
  elif echo "$MX_RECORD" | grep -qi "zoho"; then
    echo "  Email:       Zoho Mail — PRESERVE MX during transition"
  else
    echo "  Email:       Custom/other provider — PRESERVE MX during transition"
  fi
  SCORE=$((SCORE + 1))
  FLAGS="$FLAGS\n  - Domain has email (MX records) — email protection protocol MANDATORY during DNS change"
else
  echo "  MX Records:  None found"
  echo "  Email:       No domain email detected"
fi

# Platform detection
echo ""
SITE_HTML=$(curl -s -L --max-time 10 "https://$DOMAIN" 2>/dev/null || curl -s -L --max-time 10 "http://$DOMAIN" 2>/dev/null || echo "SITE_UNREACHABLE")
HEADERS=$(curl -sI -L --max-time 10 "https://$DOMAIN" 2>/dev/null || echo "")

if [ "$SITE_HTML" = "SITE_UNREACHABLE" ]; then
  echo "  Platform:    SITE UNREACHABLE — may be down or no website exists"
  PLATFORM="none"
else
  if echo "$SITE_HTML" | grep -qi "wix\.com\|wixstatic"; then
    PLATFORM="Wix"
    SCORE=$((SCORE + 1))
    FLAGS="$FLAGS\n  - Site is on Wix — domain may be locked in platform (DOMAIN-PLAYBOOK Scenario 8)"
  elif echo "$SITE_HTML" | grep -qi "squarespace"; then
    PLATFORM="Squarespace"
    SCORE=$((SCORE + 1))
    FLAGS="$FLAGS\n  - Site is on Squarespace — domain may be locked in platform (DOMAIN-PLAYBOOK Scenario 8)"
  elif echo "$SITE_HTML" | grep -qi "wordpress\|wp-content\|wp-includes"; then
    if echo "$WWW_RECORD" | grep -qi "wordpress\.com"; then
      PLATFORM="WordPress.com (hosted)"
      SCORE=$((SCORE + 1))
    else
      PLATFORM="WordPress (self-hosted)"
    fi
  elif echo "$SITE_HTML" | grep -qi "shopify"; then
    PLATFORM="Shopify"
    SCORE=$((SCORE + 1))
  elif echo "$SITE_HTML" | grep -qi "site123\|f-static"; then
    PLATFORM="Site123"
    SCORE=$((SCORE + 1))
  elif echo "$SITE_HTML" | grep -qi "wsimg\.com\|godaddy"; then
    PLATFORM="GoDaddy Builder"
  elif echo "$SITE_HTML" | grep -qi "weebly"; then
    PLATFORM="Weebly"
    SCORE=$((SCORE + 1))
  else
    PLATFORM="Custom/Static HTML"
  fi
  echo "  Platform:    $PLATFORM"
fi

# ─── GBP INTELLIGENCE ───
echo ""
echo "GBP INTELLIGENCE"
echo "─────────────────────────────────────"

GBP_SCORE=0
BUSINESS_ENCODED=$(echo "$BUSINESS" | sed 's/ /+/g')

if [ -n "${GOOGLE_MAPS_API_KEY:-}" ]; then
  GBP_DATA=$(curl -s "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=${BUSINESS_ENCODED}&inputtype=textquery&fields=place_id,name,formatted_address,rating,user_ratings_total,business_status,website&key=$GOOGLE_MAPS_API_KEY" 2>/dev/null)

  GBP_STATUS=$(echo "$GBP_DATA" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('status','FAILED'))" 2>/dev/null || echo "FAILED")

  if [ "$GBP_STATUS" = "OK" ]; then
    PLACE_ID=$(echo "$GBP_DATA" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d['candidates'][0].get('place_id',''))" 2>/dev/null || echo "")
    GBP_NAME=$(echo "$GBP_DATA" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d['candidates'][0].get('name',''))" 2>/dev/null || echo "")
    GBP_RATING=$(echo "$GBP_DATA" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d['candidates'][0].get('rating','N/A'))" 2>/dev/null || echo "N/A")
    GBP_REVIEWS=$(echo "$GBP_DATA" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d['candidates'][0].get('user_ratings_total','0'))" 2>/dev/null || echo "0")
    GBP_WEBSITE=$(echo "$GBP_DATA" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d['candidates'][0].get('website','None'))" 2>/dev/null || echo "None")
    GBP_BIZ_STATUS=$(echo "$GBP_DATA" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d['candidates'][0].get('business_status','UNKNOWN'))" 2>/dev/null || echo "UNKNOWN")

    echo "  Place ID:    $PLACE_ID"
    echo "  Name:        $GBP_NAME"
    echo "  Rating:      $GBP_RATING from $GBP_REVIEWS reviews"
    echo "  Website:     $GBP_WEBSITE"
    echo "  Status:      $GBP_BIZ_STATUS"

    # Score GBP completeness
    [ -n "$PLACE_ID" ] && GBP_SCORE=$((GBP_SCORE + 2))

    if [ "$GBP_RATING" != "N/A" ]; then
      RATING_CHECK=$(echo "$GBP_RATING" | python3 -c "import sys; r=float(sys.stdin.read().strip()); print('yes' if r >= 4.0 else 'no')" 2>/dev/null || echo "no")
      [ "$RATING_CHECK" = "yes" ] && GBP_SCORE=$((GBP_SCORE + 1))
    fi

    [ "$GBP_REVIEWS" -ge 10 ] 2>/dev/null && GBP_SCORE=$((GBP_SCORE + 1))
    [ "$GBP_WEBSITE" != "None" ] && GBP_SCORE=$((GBP_SCORE + 1))

    # Check if GBP website matches domain
    if [ "$GBP_WEBSITE" != "None" ] && echo "$GBP_WEBSITE" | grep -qi "$DOMAIN"; then
      echo "  URL Match:   YES — GBP website matches domain"
      GBP_SCORE=$((GBP_SCORE + 1))
    elif [ "$GBP_WEBSITE" != "None" ]; then
      echo "  URL Match:   NO — GBP website ($GBP_WEBSITE) does not match $DOMAIN"
    fi

    # Reviews URL
    if [ -n "$PLACE_ID" ]; then
      echo "  Reviews URL: https://search.google.com/local/reviews?placeid=$PLACE_ID"
    fi
  else
    echo "  GBP:         NOT FOUND or API error ($GBP_STATUS)"
    SCORE=$((SCORE + 1))
    FLAGS="$FLAGS\n  - GBP not found via API — check manually on Google Maps"
  fi
else
  echo "  GBP:         GOOGLE_MAPS_API_KEY not set — manual check required"
  echo "  Manual:      Search Google Maps for \"$BUSINESS\" and verify listing"
  GBP_SCORE=-1
fi

if [ "$GBP_SCORE" -ge 0 ]; then
  echo "  Completeness: $GBP_SCORE/10 (partial — photos, hours, posts need manual check)"
fi

# ─── SEO HEALTH ───
echo ""
echo "SEO HEALTH"
echo "─────────────────────────────────────"

if [ "$SITE_HTML" != "SITE_UNREACHABLE" ]; then
  # Sitemap check
  SITEMAP_STATUS=$(curl -sI -L --max-time 5 "https://$DOMAIN/sitemap.xml" 2>/dev/null | head -1 | grep -oE "[0-9]{3}" || echo "000")
  if [ "$SITEMAP_STATUS" = "200" ]; then
    echo "  Sitemap:     YES (200)"
  else
    echo "  Sitemap:     NO (returned $SITEMAP_STATUS)"
  fi

  # Robots.txt
  ROBOTS_STATUS=$(curl -sI -L --max-time 5 "https://$DOMAIN/robots.txt" 2>/dev/null | head -1 | grep -oE "[0-9]{3}" || echo "000")
  echo "  Robots.txt:  $([ "$ROBOTS_STATUS" = "200" ] && echo "YES" || echo "NO")"

  # Mobile viewport
  if echo "$SITE_HTML" | grep -qi "viewport"; then
    echo "  Mobile:      YES (viewport meta found)"
  else
    echo "  Mobile:      NO (no viewport meta — not mobile-friendly)"
    FLAGS="$FLAGS\n  - Site is not mobile-friendly — strong outreach angle"
  fi

  # Meta title
  META_TITLE=$(echo "$SITE_HTML" | grep -ioE '<title>[^<]{1,200}</title>' | head -1 | sed 's/<[^>]*>//g')
  if [ -n "$META_TITLE" ]; then
    echo "  Title:       $META_TITLE"
  else
    echo "  Title:       MISSING"
  fi

  # Meta description
  META_DESC=$(echo "$SITE_HTML" | grep -ioE 'meta name="description" content="[^"]{1,200}"' | head -1 | sed 's/.*content="//;s/"$//')
  if [ -n "$META_DESC" ]; then
    echo "  Description: $(echo "$META_DESC" | cut -c1-80)..."
  else
    echo "  Description: MISSING"
  fi

  # Page speed (TTFB)
  TTFB=$(curl -s -o /dev/null -w "%{time_starttransfer}" --max-time 10 "https://$DOMAIN" 2>/dev/null || echo "TIMEOUT")
  TOTAL=$(curl -s -o /dev/null -w "%{time_total}" --max-time 10 "https://$DOMAIN" 2>/dev/null || echo "TIMEOUT")
  echo "  TTFB:        ${TTFB}s"
  echo "  Total load:  ${TOTAL}s"

  # SSL check
  SSL_CHECK=$(curl -sI --max-time 5 "https://$DOMAIN" 2>/dev/null | head -1 || echo "FAILED")
  if echo "$SSL_CHECK" | grep -q "200\|301\|302"; then
    echo "  SSL:         YES (HTTPS working)"
  else
    echo "  SSL:         NO or ISSUE"
    FLAGS="$FLAGS\n  - No valid SSL — security issue, outreach angle"
  fi
else
  echo "  Site is unreachable — no SEO data available"
  echo "  This could mean: no website exists, domain expired, or site is down"
fi

# ─── TRANSITION COMPLEXITY ───
echo ""
echo "TRANSITION COMPLEXITY"
echo "─────────────────────────────────────"
echo "  Raw score:   $SCORE / 14"

if [ "$SCORE" -le 3 ]; then
  COMPLEXITY="GREEN"
  TIMELINE="1-2 days"
  ROUTING="Standard package — proceed with outreach"
  FEE="No additional fees"
elif [ "$SCORE" -le 7 ]; then
  COMPLEXITY="AMBER"
  TIMELINE="3-7 days"
  ROUTING="Run domain discovery checklist before signing"
  FEE="No additional fees — set timeline expectations"
else
  COMPLEXITY="RED"
  TIMELINE="1-4 weeks"
  ROUTING="R1,500 domain recovery fee — quote upfront"
  FEE="R1,500 Domain Recovery Service"
fi

echo "  Rating:      $COMPLEXITY"
echo "  Est. go-live: $TIMELINE"
echo "  Routing:     $ROUTING"
echo "  Additional:  $FEE"

# ─── OUTREACH ANGLE ───
echo ""
echo "SUGGESTED OUTREACH ANGLE"
echo "─────────────────────────────────────"

if [ "$SITE_HTML" = "SITE_UNREACHABLE" ]; then
  echo "  \"Your patients are searching for you online and finding nothing.\""
  echo "  \"I built what they should see — have a look.\""
elif [ "$PLATFORM" = "Wix" ] || [ "$PLATFORM" = "Squarespace" ] || [ "$PLATFORM" = "Site123" ]; then
  echo "  \"Your current site is on $PLATFORM — it's holding back your practice.\""
  echo "  \"I built a premium alternative that converts visitors into patients.\""
elif echo "$TTFB" | grep -qE "^[3-9]\.|^[0-9]{2}"; then
  echo "  \"Your site takes ${TTFB}s to load — patients leave after 3 seconds.\""
  echo "  \"I built a version that loads in under 1 second.\""
else
  echo "  \"Your online presence doesn't match the quality of your practice.\""
  echo "  \"I built what it should look like — have a look.\""
fi

# ─── FLAGS ───
echo ""
echo "FLAGS & RISKS"
echo "─────────────────────────────────────"
if [ -n "$FLAGS" ]; then
  echo -e "$FLAGS"
else
  echo "  None — clean prospect"
fi

echo ""
echo "═══════════════════════════════════════"
echo "END OF REPORT"
echo "═══════════════════════════════════════"
