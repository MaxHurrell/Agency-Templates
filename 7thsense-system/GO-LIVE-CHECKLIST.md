# Go-Live Checklist — Demo to Production

## When to Use
Run this checklist after a client has paid in full (or 50% balance received). This takes the demo from a sales tool to a live production website on the client's own domain.

---

## 1. PRE-GO-LIVE CONFIRMATION

- [ ] 50% balance payment confirmed received (total = full package price)
- [ ] Client email address confirmed for Tally form notifications: `_______________`
- [ ] Client has approved the demo (any final revision requests completed)
- [ ] All revisions within package allowance completed (Starter: 1 round, Growth: 2, Full System: 3)

---

## 2. DOMAIN

### Option A: Client Purchases Domain
- [ ] Recommend Domains.co.za for .co.za domains (~R150-200/year)
- [ ] Explain: "Buy [businessname].co.za — I'll handle connecting it to your site"
- [ ] Client confirms domain purchase and shares login credentials or adds Max as DNS manager

### Option B: Max Purchases and Invoices
- [ ] Purchase domain on Domains.co.za
- [ ] Invoice client at cost + R250 handling fee
- [ ] Confirm payment received before proceeding

### DNS Configuration (Vercel)
- [ ] Log into domain registrar DNS settings
- [ ] Add A record: `@` → `76.76.21.21`
- [ ] Add CNAME record: `www` → `cname.vercel-dns.com`
- [ ] In Vercel dashboard: add custom domain to the client's project
- [ ] Wait for DNS propagation (usually 10-30 minutes, can take up to 48 hours)
- [ ] Verify: `dig [domain] +short` returns `76.76.21.21`

---

## 3. CODE CHANGES (demo → production)

All changes are made in `~/client-sites/[client-name]/index.html`:

- [ ] Update `<link rel="canonical">` to `https://[client-domain]`
- [ ] Update all `og:url` meta tags to `https://[client-domain]`
- [ ] Update all `og:image` URLs to use `https://[client-domain]/` prefix
- [ ] Update `twitter:image` URL
- [ ] Update `og:site_name` if it references demo URL
- [ ] Update Tally form `&source=` parameter from demo slug to final client name
- [ ] Add analytics snippet (see below)
- [ ] Update meta description if placeholder or generic
- [ ] Update any hardcoded demo URLs in JavaScript (e.g. share links)

### Analytics Snippet
Add before `</head>`:

**Google Analytics (GA4):**
```html
<script async src="https://www.googletagmanager.com/gtag/js?id=G-[MEASUREMENT_ID]"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-[MEASUREMENT_ID]');
</script>
```

**OR Plausible (privacy-friendly, no cookie banner needed):**
```html
<script defer data-domain="[client-domain]" src="https://plausible.io/js/script.js"></script>
```

---

## 4. TALLY FORM HANDOFF

This is the critical handoff moment — lead notifications switch from Max to the client.

- [ ] Log into tally.so (Max's account)
- [ ] Open form settings for form ID `9qlQe4`
- [ ] Go to Notifications → Email notifications
- [ ] Remove maxhurrellsa@gmail.com
- [ ] Add client email: `[CLIENT EMAIL]`
- [ ] Save changes
- [ ] Submit a test form entry on the live site
- [ ] Confirm with client: "Did you receive a test enquiry from your website just now?"
- [ ] Once confirmed, tell the client: "Your site is live — every enquiry through the contact form now goes directly to your email."

**Important:** Do NOT switch notifications before the site is live on the real domain. The sequence is: domain live → notifications switched → test confirmed → client notified.

---

## 5. FINAL TECHNICAL CHECKS

- [ ] Run QA: `bash ~/agency-templates/7thsense-system/scripts/qa-pre-deploy.sh ./index.html ./[client]-config.json`
- [ ] Zero errors required — fix any before proceeding
- [ ] Deploy: `vercel --prod --force --token="$VERCEL_TOKEN" --scope="maxhurrellsa-9290s-projects"`
- [ ] Curl confirm 200: `curl -sI https://[client-domain] | head -1` → must return `HTTP/2 200`
- [ ] Check SSL: open `https://[client-domain]` in browser — padlock icon, no warnings
- [ ] Check www redirect: `curl -sI https://www.[client-domain] | head -1` → should 200 or 301→apex
- [ ] Submit a form on the live domain — confirm client receives notification email
- [ ] Test WhatsApp button on a real mobile phone — confirm it opens WhatsApp with correct number
- [ ] Test click-to-call on mobile — confirm it dials correct number
- [ ] Run Lighthouse mobile: must score 90+ performance
  ```bash
  npx lighthouse https://[client-domain] --only-categories=performance --output=json --chrome-flags="--headless" 2>/dev/null | python3 -c "import json,sys;d=json.load(sys.stdin);print(f'Performance: {d[\"categories\"][\"performance\"][\"score\"]*100:.0f}/100')"
  ```
- [ ] Test Open Graph: share URL in a WhatsApp chat to yourself — confirm preview image and title appear

---

## 6. CLIENT HANDOFF

- [ ] Send handoff email using template: `~/agency-templates/outreach/client-handoff.md`
- [ ] Include: live URL, how enquiries work, how to request changes, retainer info
- [ ] Do NOT give client access to Vercel, GitHub, or Tally — Max manages all technical changes
- [ ] Update `~/client-sites/client-index.md`: change URL to production domain, status to `Live — production`
- [ ] Update `~/agency-templates/MASTER_BRIEF.md` Section 2 with production URL
- [ ] If on retainer: set calendar reminder for first monthly report (30 days from go-live)

---

## 7. POST-GO-LIVE (first 48 hours)

- [ ] Check site loads correctly the morning after go-live
- [ ] Check if any form submissions have come through
- [ ] Send client a WhatsApp: "Hi [NAME] — just checking everything's working well with the new site. Any questions?"
- [ ] If on Full System package: verify Make.com automations are firing correctly

---

## Quick Reference — DNS Records for Vercel

| Type | Name | Value |
|------|------|-------|
| A | @ | 76.76.21.21 |
| CNAME | www | cname.vercel-dns.com |

Vercel handles SSL automatically once DNS propagates. No manual certificate setup needed.
