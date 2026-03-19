#!/bin/bash
# 7thsense — Check Instagram presence and whether bio has a website link
# Usage: bash check-instagram.sh [business name]
# Attempts to find Instagram handle and check for website in bio
set -uo pipefail

BUSINESS="${1:-}"
if [ -z "$BUSINESS" ]; then echo "Usage: bash check-instagram.sh \"Business Name\""; exit 1; fi

# Generate likely handles: lowercase, remove spaces, common patterns
CLEAN=$(echo "$BUSINESS" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]//g')
CLEAN_DOT=$(echo "$BUSINESS" | tr '[:upper:]' '[:lower:]' | sed 's/ /./g;s/[^a-z0-9.]//g')
CLEAN_UNDER=$(echo "$BUSINESS" | tr '[:upper:]' '[:lower:]' | sed 's/ /_/g;s/[^a-z0-9_]//g')

FOUND=""
HANDLE=""

for ATTEMPT in "$CLEAN" "$CLEAN_DOT" "$CLEAN_UNDER"; do
  RESP=$(curl -s --max-time 8 -o /dev/null -w "%{http_code}" "https://www.instagram.com/${ATTEMPT}/" 2>/dev/null)
  if [ "$RESP" = "200" ]; then
    FOUND="YES"
    HANDLE="$ATTEMPT"
    break
  fi
  sleep 1
done

if [ "$FOUND" = "YES" ]; then
  echo "INSTAGRAM=YES"
  echo "HANDLE=@${HANDLE}"
  echo "URL=https://www.instagram.com/${HANDLE}/"

  # Try to fetch page and check for external link
  PAGE=$(curl -sL --max-time 8 "https://www.instagram.com/${HANDLE}/" 2>/dev/null)
  if echo "$PAGE" | grep -qiE 'external_url|linktr\.ee|linkin\.bio|linkbio'; then
    echo "HAS_WEBSITE_LINK=LIKELY"
  else
    echo "HAS_WEBSITE_LINK=UNKNOWN"
  fi
else
  echo "INSTAGRAM=NOT_FOUND"
  echo "HANDLE=none"
  echo "SEARCH=https://www.instagram.com/${CLEAN}/"
fi
