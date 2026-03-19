#!/bin/bash
# 7thsense — Check domain age and last update
# Usage: bash check-domain-age.sh [domain]
# New domains (<2yr) = new business. Old stale domains = needs upgrade.
set -uo pipefail

DOMAIN="${1:-}"
if [ -z "$DOMAIN" ]; then echo "Usage: bash check-domain-age.sh [domain]"; exit 1; fi
DOMAIN=$(echo "$DOMAIN" | sed 's|https\?://||;s|/.*||')

WHOIS=$(whois "$DOMAIN" 2>/dev/null)

# Extract creation date
CREATED=$(echo "$WHOIS" | grep -iE "creation date|created|registration date|registered on" | head -1 | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}|[0-9]{4}/[0-9]{2}/[0-9]{2}|[0-9]{2}-[a-zA-Z]+-[0-9]{4}' | head -1)

# Extract expiry date
EXPIRY=$(echo "$WHOIS" | grep -iE "expir|renewal" | head -1 | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}|[0-9]{4}/[0-9]{2}/[0-9]{2}' | head -1)

# Extract last updated
UPDATED=$(echo "$WHOIS" | grep -iE "updated date|last modified|last updated" | head -1 | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}|[0-9]{4}/[0-9]{2}/[0-9]{2}' | head -1)

# Calculate age if we have creation date
if [ -n "$CREATED" ]; then
  CREATED_UNIX=$(date -j -f "%Y-%m-%d" "$CREATED" "+%s" 2>/dev/null || date -j -f "%Y/%m/%d" "$CREATED" "+%s" 2>/dev/null || echo "")
  if [ -n "$CREATED_UNIX" ]; then
    NOW=$(date "+%s")
    AGE_DAYS=$(( (NOW - CREATED_UNIX) / 86400 ))
    AGE_YEARS=$(( AGE_DAYS / 365 ))
    echo "DOMAIN_AGE_YEARS=$AGE_YEARS"
    echo "DOMAIN_AGE_DAYS=$AGE_DAYS"
    echo "CREATED=$CREATED"

    if [ $AGE_YEARS -lt 2 ]; then
      echo "AGE_SIGNAL=NEW_BUSINESS"
    elif [ $AGE_YEARS -gt 5 ]; then
      echo "AGE_SIGNAL=ESTABLISHED"
    else
      echo "AGE_SIGNAL=GROWING"
    fi
  else
    echo "DOMAIN_AGE_YEARS=UNKNOWN"
    echo "CREATED=$CREATED"
    echo "AGE_SIGNAL=UNKNOWN"
  fi
else
  echo "DOMAIN_AGE_YEARS=UNKNOWN"
  echo "CREATED=not_found"
  echo "AGE_SIGNAL=UNKNOWN"
fi

echo "EXPIRY=${EXPIRY:-not_found}"
echo "LAST_UPDATED=${UPDATED:-not_found}"

# Check expiry urgency
if [ -n "$EXPIRY" ]; then
  EXP_UNIX=$(date -j -f "%Y-%m-%d" "$EXPIRY" "+%s" 2>/dev/null || echo "")
  if [ -n "$EXP_UNIX" ]; then
    NOW=$(date "+%s")
    DAYS_LEFT=$(( (EXP_UNIX - NOW) / 86400 ))
    echo "DAYS_UNTIL_EXPIRY=$DAYS_LEFT"
    if [ $DAYS_LEFT -lt 30 ]; then
      echo "EXPIRY_URGENCY=CRITICAL"
    elif [ $DAYS_LEFT -lt 90 ]; then
      echo "EXPIRY_URGENCY=WARNING"
    else
      echo "EXPIRY_URGENCY=OK"
    fi
  fi
fi
