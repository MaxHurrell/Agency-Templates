#!/bin/bash
# 7thsense — Detect Google Ads signals on a business website
# Usage: bash detect-google-ads.sh [domain]
# Checks website source for Google Ads conversion tracking, remarketing tags, gtag
set -uo pipefail

DOMAIN="${1:-}"
if [ -z "$DOMAIN" ]; then echo "Usage: bash detect-google-ads.sh [domain]"; exit 1; fi
DOMAIN=$(echo "$DOMAIN" | sed 's|https\?://||;s|/.*||')

SRC=$(curl -sL --max-time 10 "https://$DOMAIN" 2>/dev/null || curl -sL --max-time 10 "http://$DOMAIN" 2>/dev/null)
if [ -z "$SRC" ]; then echo "GOOGLE_ADS=UNKNOWN"; echo "REASON=site_unreachable"; exit 0; fi

SIGNALS=0
EVIDENCE=""

# Google Ads conversion tracking (AW- prefix)
if echo "$SRC" | grep -qiE 'AW-[0-9]+'; then
  SIGNALS=$((SIGNALS + 2))
  EVIDENCE="${EVIDENCE}google_ads_conversion_tag "
fi

# Google Ads remarketing
if echo "$SRC" | grep -qiE 'googleads\.g\.doubleclick|googlesyndication|adsbygoogle'; then
  SIGNALS=$((SIGNALS + 2))
  EVIDENCE="${EVIDENCE}remarketing_tag "
fi

# Google Tag Manager (often used for ads)
if echo "$SRC" | grep -qiE 'googletagmanager\.com/gtm\.js|GTM-[A-Z0-9]+'; then
  SIGNALS=$((SIGNALS + 1))
  EVIDENCE="${EVIDENCE}gtm "
fi

# gtag.js with ads config
if echo "$SRC" | grep -qiE "gtag\('config',\s*'AW-"; then
  SIGNALS=$((SIGNALS + 2))
  EVIDENCE="${EVIDENCE}gtag_ads_config "
fi

# Google Analytics (not ads but indicates digital maturity)
if echo "$SRC" | grep -qiE 'G-[A-Z0-9]+|UA-[0-9]+|google-analytics\.com|gtag'; then
  SIGNALS=$((SIGNALS + 1))
  EVIDENCE="${EVIDENCE}analytics "
fi

if [ $SIGNALS -ge 4 ]; then
  echo "GOOGLE_ADS=YES"
  echo "SPEND_TIER=HIGH"
elif [ $SIGNALS -ge 2 ]; then
  echo "GOOGLE_ADS=LIKELY"
  echo "SPEND_TIER=MED"
elif [ $SIGNALS -ge 1 ]; then
  echo "GOOGLE_ADS=POSSIBLE"
  echo "SPEND_TIER=LOW"
else
  echo "GOOGLE_ADS=NO"
  echo "SPEND_TIER=NONE"
fi
echo "EVIDENCE=$EVIDENCE"
echo "SIGNAL_SCORE=$SIGNALS"
