#!/bin/bash
# 7thsense — Detect Facebook/Meta Ads signals on a business website
# Usage: bash detect-meta-ads.sh [domain]
# Checks website source for Facebook Pixel, Meta conversion API signals
set -uo pipefail

DOMAIN="${1:-}"
if [ -z "$DOMAIN" ]; then echo "Usage: bash detect-meta-ads.sh [domain]"; exit 1; fi
DOMAIN=$(echo "$DOMAIN" | sed 's|https\?://||;s|/.*||')

SRC=$(curl -sL --max-time 10 "https://$DOMAIN" 2>/dev/null || curl -sL --max-time 10 "http://$DOMAIN" 2>/dev/null)
if [ -z "$SRC" ]; then echo "META_ADS=UNKNOWN"; echo "REASON=site_unreachable"; exit 0; fi

SIGNALS=0
EVIDENCE=""

# Facebook Pixel
if echo "$SRC" | grep -qiE 'fbq\(|facebook\.com/tr\?|connect\.facebook\.net/.*fbevents'; then
  SIGNALS=$((SIGNALS + 3))
  EVIDENCE="${EVIDENCE}fb_pixel "
fi

# Facebook Pixel ID
PIXEL_ID=$(echo "$SRC" | grep -oE "fbq\('init',\s*'[0-9]+'" | grep -oE '[0-9]+' | head -1)
if [ -n "$PIXEL_ID" ]; then
  EVIDENCE="${EVIDENCE}pixel_id:${PIXEL_ID} "
fi

# Meta SDK / Facebook SDK
if echo "$SRC" | grep -qiE 'connect\.facebook\.net/.*sdk\.js|fb-root'; then
  SIGNALS=$((SIGNALS + 1))
  EVIDENCE="${EVIDENCE}fb_sdk "
fi

# Facebook domain verification
if echo "$SRC" | grep -qiE 'facebook-domain-verification'; then
  SIGNALS=$((SIGNALS + 1))
  EVIDENCE="${EVIDENCE}domain_verified "
fi

# Instagram embed or link (suggests social investment)
if echo "$SRC" | grep -qiE 'instagram\.com/[a-zA-Z0-9._]+'; then
  SIGNALS=$((SIGNALS + 1))
  EVIDENCE="${EVIDENCE}instagram_linked "
fi

if [ $SIGNALS -ge 3 ]; then
  echo "META_ADS=YES"
  echo "SPEND_TIER=HIGH"
elif [ $SIGNALS -ge 1 ]; then
  echo "META_ADS=LIKELY"
  echo "SPEND_TIER=MED"
else
  echo "META_ADS=NO"
  echo "SPEND_TIER=NONE"
fi
echo "EVIDENCE=$EVIDENCE"
echo "SIGNAL_SCORE=$SIGNALS"
