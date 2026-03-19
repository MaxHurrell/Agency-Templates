#!/bin/bash
# 7thsense — Check social media presence and activity
# Usage: bash check-social-activity.sh [domain]
# Scans website for social links, checks if profiles exist
set -uo pipefail

DOMAIN="${1:-}"
if [ -z "$DOMAIN" ]; then echo "Usage: bash check-social-activity.sh [domain]"; exit 1; fi
DOMAIN=$(echo "$DOMAIN" | sed 's|https\?://||;s|/.*||')

SRC=$(curl -sL --max-time 10 "https://$DOMAIN" 2>/dev/null || curl -sL --max-time 10 "http://$DOMAIN" 2>/dev/null)

PLATFORMS=0

# Facebook
FB=$(echo "$SRC" | grep -oE 'facebook\.com/[a-zA-Z0-9._/]+' | grep -v "sharer\|share\|dialog\|plugins" | head -1)
if [ -n "$FB" ]; then
  echo "FACEBOOK=https://${FB}"
  PLATFORMS=$((PLATFORMS + 1))
else
  echo "FACEBOOK=NOT_FOUND"
fi

# Instagram
IG=$(echo "$SRC" | grep -oE 'instagram\.com/[a-zA-Z0-9._]+' | head -1)
if [ -n "$IG" ]; then
  echo "INSTAGRAM=https://${IG}"
  PLATFORMS=$((PLATFORMS + 1))
else
  echo "INSTAGRAM=NOT_FOUND"
fi

# LinkedIn
LI=$(echo "$SRC" | grep -oE 'linkedin\.com/[a-zA-Z0-9._/]+' | head -1)
if [ -n "$LI" ]; then
  echo "LINKEDIN=https://${LI}"
  PLATFORMS=$((PLATFORMS + 1))
else
  echo "LINKEDIN=NOT_FOUND"
fi

# Twitter/X
TW=$(echo "$SRC" | grep -oE '(twitter\.com|x\.com)/[a-zA-Z0-9._]+' | head -1)
if [ -n "$TW" ]; then
  echo "TWITTER=https://${TW}"
  PLATFORMS=$((PLATFORMS + 1))
else
  echo "TWITTER=NOT_FOUND"
fi

# YouTube
YT=$(echo "$SRC" | grep -oE 'youtube\.com/[a-zA-Z0-9._/@]+' | head -1)
if [ -n "$YT" ]; then
  echo "YOUTUBE=https://${YT}"
  PLATFORMS=$((PLATFORMS + 1))
else
  echo "YOUTUBE=NOT_FOUND"
fi

# TikTok
TT=$(echo "$SRC" | grep -oE 'tiktok\.com/@[a-zA-Z0-9._]+' | head -1)
if [ -n "$TT" ]; then
  echo "TIKTOK=https://${TT}"
  PLATFORMS=$((PLATFORMS + 1))
else
  echo "TIKTOK=NOT_FOUND"
fi

echo "PLATFORMS_FOUND=$PLATFORMS"

if [ $PLATFORMS -ge 3 ]; then
  echo "SOCIAL_SCORE=HIGH"
  echo "SIGNAL=active_social_no_good_website"
elif [ $PLATFORMS -ge 1 ]; then
  echo "SOCIAL_SCORE=MEDIUM"
  echo "SIGNAL=some_social_presence"
else
  echo "SOCIAL_SCORE=LOW"
  echo "SIGNAL=no_social_presence"
fi
