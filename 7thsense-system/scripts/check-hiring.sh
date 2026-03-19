#!/bin/bash
# 7thsense — Check if a business is hiring (budget + growth signal)
# Usage: bash check-hiring.sh [business name] [niche] [location]
# Searches Indeed.co.za for hiring signals
set -uo pipefail

BUSINESS="${1:-}"
NICHE="${2:-dental}"
LOCATION="${3:-cape town}"

if [ -z "$BUSINESS" ]; then echo "Usage: bash check-hiring.sh \"Business Name\" [niche] [location]"; exit 1; fi

ENCODED_BIZ=$(echo "$BUSINESS" | sed 's/ /+/g')
ENCODED_NICHE=$(echo "$NICHE" | sed 's/ /+/g')
ENCODED_LOC=$(echo "$LOCATION" | sed 's/ /+/g')

# Check Indeed.co.za for the business name
INDEED_URL="https://za.indeed.com/jobs?q=${ENCODED_BIZ}&l=${ENCODED_LOC}"
INDEED_RESP=$(curl -sL --max-time 10 "$INDEED_URL" 2>/dev/null)

JOBS_FOUND="NO"
JOB_TITLES=""

if echo "$INDEED_RESP" | grep -qi "$BUSINESS"; then
  JOBS_FOUND="YES"
  JOB_TITLES=$(echo "$INDEED_RESP" | grep -oiE '<h2[^>]*class="jobTitle[^"]*"[^>]*>[^<]*<[^>]*>[^<]*<' | sed 's/<[^>]*>//g' | head -3 | tr '\n' '; ')
fi

# Also check for niche + location (catches receptionist roles etc)
NICHE_URL="https://za.indeed.com/jobs?q=${ENCODED_NICHE}+receptionist&l=${ENCODED_LOC}"
NICHE_RESP=$(curl -sL --max-time 10 "$NICHE_URL" 2>/dev/null)

NICHE_HIRING="NO"
if echo "$NICHE_RESP" | grep -qiE "receptionist|dental assistant|practice manager|office manager|hygienist"; then
  NICHE_HIRING="YES"
fi

echo "HIRING_DIRECT=$JOBS_FOUND"
echo "HIRING_NICHE=$NICHE_HIRING"
echo "JOB_TITLES=${JOB_TITLES:-none}"
echo "INDEED_URL=$INDEED_URL"

if [ "$JOBS_FOUND" = "YES" ]; then
  echo "BUDGET_SIGNAL=HIGH"
elif [ "$NICHE_HIRING" = "YES" ]; then
  echo "BUDGET_SIGNAL=MEDIUM"
else
  echo "BUDGET_SIGNAL=NONE"
fi
