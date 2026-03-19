#!/bin/bash
# 7thsense Batch Lead Enrichment
# Usage: bash enrich-batch.sh
# Enriches all leads defined in the LEADS array below
# Add new leads to the array before running

LEADS=(
  "Werner Joubert Dental|bellvilledentist.co.za"
  "Ubuntu Dental|ubuntudental.com"
  "Westhof Dental Surgery|dentistbellville.com"
  "Eminent Dental Wellness|eminentdental.co.za"
  "Loock Dental|loockdental.co.za"
  "The Dental Room|thedentalroom.co.za"
  "Dr Paul van Zyl|pvzyl.co.za"
  "N1 City Dentist|drtooth.co.za"
  "Kidident|kidident.com"
  "Panorama Dental|panoramadental.co.za"
)

OUTPUT_FILE=~/agency-templates/outreach/enriched-leads-$(date +%Y%m%d).md

echo "# 7thsense Enriched Leads — $(date)" > $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

for LEAD in "${LEADS[@]}"; do
  BUSINESS=$(echo "$LEAD" | cut -d'|' -f1)
  WEBSITE=$(echo "$LEAD" | cut -d'|' -f2)
  echo "Processing: $BUSINESS..."
  bash ~/agency-templates/7thsense-system/scripts/enrich-lead.sh "$BUSINESS" "$WEBSITE" >> $OUTPUT_FILE 2>&1
  echo "" >> $OUTPUT_FILE
  sleep 2
done

echo "✅ Batch enrichment complete."
echo "📄 Output saved to: $OUTPUT_FILE"
cat $OUTPUT_FILE
