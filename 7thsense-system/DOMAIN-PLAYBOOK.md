# DOMAIN PLAYBOOK — 7thsense Agency

**Owner:** Max Hurrell (maxhurrellsa@gmail.com)
**Purpose:** End-to-end domain resolution for every client transition from demo to production.
**Referenced by:** DEPLOYMENT-PROCESS.md, GO-LIVE-CHECKLIST.md

---

## TABLE OF CONTENTS

1. [Scenario Resolution Playbook](#output-1--scenario-resolution-playbook) — 8 scenarios with steps, owners, timelines, risks, and exact client language
2. [Domain Discovery Checklist](#output-2--domain-discovery-checklist) — Questions to ask every prospect before signing
3. [Client Communication Templates](#output-3--client-communication-templates) — Copy-paste messages for every scenario
4. [Pricing Logic](#output-4--pricing-logic) — What is included, what incurs a fee, pre-sale rules
5. [Technical Reference](#output-5--technical-reference) — DNS records, TTL management, email protection, propagation commands

---

## OUTPUT 1 — SCENARIO RESOLUTION PLAYBOOK

---

### SCENARIO 1 — CLIENT OWNS DOMAIN, HAS REGISTRAR ACCESS

**Situation:** Client has an active account at Namecheap, GoDaddy, Domains.co.za, or similar registrar and can log in.

**Risk Level:** LOW

**Time Estimate:** 1–2 hours

| Step | Action | Owner |
|------|--------|-------|
| 1 | Client shares registrar login securely (via password manager share or 1Password link), OR adds Max as a collaborator/reseller user | Client |
| 2 | Max logs in, navigates to DNS management for the domain | Max |
| 3 | Max screenshots all existing DNS records before touching anything | Max |
| 4 | Max reduces TTL on A record and www CNAME to 300 seconds | Max |
| 5 | Max waits 24–48 hours if old TTL was high (e.g. 86400). Skips wait if TTL was already 300–600. | Max |
| 6 | Max updates A record to 76.76.21.21 and www CNAME to cname.vercel-dns.com | Max |
| 7 | Max verifies propagation using dig and curl commands (see Output 5) | Max |
| 8 | Max adds domain in Vercel project settings → confirms SSL certificate issued | Max |
| 9 | Max confirms live URL returns HTTP 200 and loads the correct site | Max |
| 10 | Max notifies client site is live, TTL restored to 3600 | Max |

**Fallback:** If client cannot share access or add Max as collaborator, Max provides a step-by-step screen recording or video call walkthrough for the client to execute DNS changes themselves.

**Client-facing language:**
"I just need access to where your domain is managed — I'll handle everything from there. I'll only touch the DNS settings, nothing else. You'll want to share your [Registrar] login with me securely — I can send you a 1Password link or you can add me as a user at maxhurrellsa@gmail.com."

---

### SCENARIO 2 — CLIENT OWNS DOMAIN, LOST ACCESS

**Situation:** Client registered the domain themselves but forgot the password, lost access to the email on the account, or has no record of the registrar.

**Risk Level:** MEDIUM

**Time Estimate:** 1–5 business days (depends on registrar responsiveness and whether recovery email is accessible)

| Step | Action | Owner |
|------|--------|-------|
| 1 | Max runs `whois clientdomain.com` to identify the registrar | Max |
| 2 | Max sends client the registrar login URL and asks them to attempt password reset | Client |
| 3 | If recovery email still works: client resets password, shares access with Max → proceed to Scenario 1 | Client |
| 4 | If recovery email is lost: client contacts registrar support via phone or ticket, requests account recovery with ID verification | Client |
| 5 | Max monitors progress, follows up with client every 24 hours | Max |
| 6 | If registrar is unresponsive after 5 business days: Max advises client to file a support escalation ticket referencing ICANN's domain recovery guidelines | Max |
| 7 | Once access is recovered, proceed to Scenario 1 | Max |

**Recovery paths in priority order:**
1. Password reset to a working email address
2. Registrar support ticket with government-issued ID and business proof
3. ICANN complaint if registrar is unresponsive (gTLDs: .com, .net, .org)
4. ZADNA complaint if .co.za domain
5. If truly unrecoverable after 14 calendar days — register a new domain

**Fallback:** If domain cannot be recovered after 14 days, register a new domain (e.g. drsmithdentalct.co.za instead of drsmith.co.za) and proceed with Scenario 5.

**Client-facing language:**
"We need to recover your domain login. I'll walk you through it — usually takes a few days. I've identified that your domain is registered at [REGISTRAR]. The first step is trying a password reset. I'll send you the exact link and steps. If that doesn't work, we go to their support team — it usually only takes a few business days."

---

### SCENARIO 3 — OLD AGENCY OWNS THE DOMAIN

**Situation:** A previous web agency registered the domain in their own name, not the client's. Client has no direct access. This is the highest-risk scenario.

**Risk Level:** HIGH

**Time Estimate:** 3–30 days (entirely dependent on old agency cooperation)

| Step | Action | Owner |
|------|--------|-------|
| 1 | Max runs `whois clientdomain.com` to identify registrant name and confirm it is the agency, not the client | Max |
| 2 | Max documents findings and explains the situation to client clearly | Max |
| 3 | Client sends a written transfer request to old agency via email. Max drafts the email (see Template 3). | Client / Max |
| 4 | If agency responds and cooperates: agency unlocks domain, provides EPP/auth code, initiates transfer → proceed to transfer checklist in Output 5 | Third party / Max |
| 5 | If no response after 7 calendar days: client sends a formal written demand, CC'ing Max. Max advises on wording. | Client / Max |
| 6 | If uncooperative after 14 days: Max files an ICANN complaint (for .com/.net) or ZADNA ADR complaint (for .co.za) on client's behalf | Max |
| 7 | If ICANN/ZADNA process is active but slow: discuss registering a new domain as parallel path to avoid stalling the project | Max / Client |
| 8 | As absolute last resort: client engages attorney to issue demand letter. Max provides documentation of all prior communications. | Client (attorney) |

**Legal context (South Africa):**
Under South African common law, a business owner has superior rights to a domain name that incorporates their registered trading name or business name. For .co.za domains, ZADNA's Alternative Dispute Resolution (ADR) process can compel transfer without court proceedings if bad faith is demonstrated. Attorney engagement is rarely needed if ZADNA ADR is pursued.

**Escalation path:**
Written request → Formal demand → ICANN/ZADNA complaint → Legal letter → New domain as fallback

**Fallback:** Register a new domain for the client (e.g. drsmithdental.co.za instead of drsmith.co.za). This unblocks the project immediately while domain recovery continues in the background. Once recovered, redirect old domain to new domain permanently.

**Client-facing language:**
"Your old agency registered the domain in their name. Let me help you get it transferred — I'll guide you through each step. If they cooperate, it takes about a week. If not, we have escalation options including a formal complaint process that usually gets results without going to court. I'll also register you a backup domain so your project doesn't stall while we sort this out."

---

### SCENARIO 4 — DOMAIN ABOUT TO EXPIRE

**Situation:** Domain expiry date is within 30 days, or the domain has already expired and is in a grace or redemption period.

**Risk Level:** HIGH — every day counts

**Time Estimate:** Same day if access exists; 1–5 days if access recovery is needed first

| Step | Action | Owner |
|------|--------|-------|
| 1 | Max identifies registrar via whois and checks exact expiry date | Max |
| 2 | Max alerts client immediately with the expiry date and urgency | Max |
| 3 | Gain registrar access via Scenario 1 or 2 steps — prioritise speed over process | Max / Client |
| 4 | Renew the domain immediately once access is secured. Renew for minimum 2 years. | Max / Client |
| 5 | Confirm renewal receipt is emailed to a valid client email address | Client |
| 6 | Proceed with DNS configuration (Scenario 1 steps) | Max |

**Grace and redemption periods:**
- **Standard expiry grace period:** 30 days — domain is suspended but can be renewed at normal cost
- **Redemption period:** Days 31–60 post-expiry — domain can be recovered but registrar charges a redemption fee (typically R1,000–R2,500 / USD $80–150)
- **Pending delete:** Days 61–75 — domain queued for release to public. Cannot be recovered. Must register as new domain once released.
- **.co.za grace periods may differ** — verify with ZADNA-accredited registrar

**Fallback:** If domain enters pending delete or is purchased by a third party, register the closest available alternative immediately.

**Client-facing language:**
"Your domain expires on [DATE] — this is urgent. If it expires, someone else could register your web address and you'd lose it permanently. We need to renew it this week, ideally today. Can you confirm you have login access to [REGISTRAR]? If not, tell me and I'll start the recovery process right now."

---

### SCENARIO 5 — BRAND NEW DOMAIN

**Situation:** Client has no existing website or domain. A new domain needs to be registered from scratch.

**Risk Level:** LOW

**Time Estimate:** 30 minutes

| Step | Action | Owner |
|------|--------|-------|
| 1 | Max checks availability of preferred domain at namecheap.com or domains.co.za | Max |
| 2 | Max and client agree on domain name (see selection advice below) | Max / Client |
| 3 | Max registers domain in client's name, using client's contact details as registrant | Max |
| 4 | Client is set as registrant owner; Max is set as technical contact | Max |
| 5 | Max configures DNS for Vercel (A record + www CNAME) | Max |
| 6 | Max deploys Vercel project and adds custom domain | Max |
| 7 | Max verifies SSL and live URL | Max |
| 8 | Max transfers registrar login credentials to client and confirms they have saved them | Max / Client |

**Domain selection advice:**
- businessname.co.za — preferred for SA-focused businesses
- businessname.com — preferred if client has or wants an international audience
- Keep it short: under 20 characters including extension
- No hyphens — they look untrustworthy and are harder to say aloud
- No numbers unless they are part of the brand name
- If .co.za and .com are both available: register both and redirect .com to .co.za (or vice versa based on target market)
- Avoid: initials-only domains, misspellings, or domains that could be confused with a competitor

**Fallback:** If the preferred domain is taken, Max presents 3 alternatives with reasoning.

**Client-facing language:**
"I'll register [DOMAIN] for you — it's included in your package. You'll own it from day one. I'll keep it in your name and send you the login details once it's set up. If [DOMAIN] is already taken, I'll find you the next best option."

---

### SCENARIO 6 — ZERO-DOWNTIME CUTOVER

**Situation:** Client has an existing live website that must stay online for visitors until the exact moment the new site is ready. Any downtime is unacceptable.

**Risk Level:** LOW (if TTL reduction is done in advance) — MEDIUM (if TTL reduction is skipped)

**Time Estimate:** 2–3 days total (1–2 days TTL reduction period + cutover in minutes)

| Step | Action | Owner | Timing |
|------|--------|-------|--------|
| 1 | Deploy new site on Vercel with a temporary vercel.app URL | Max | Day 1 |
| 2 | QA the new site fully on the vercel.app URL — mobile, desktop, forms, links | Max / Client | Day 1 |
| 3 | Client approves the new site for go-live | Client | Day 1 |
| 4 | Max reduces TTL on the A record and www CNAME to 300 seconds (5 minutes) | Max | Day 1 |
| 5 | Wait 24–48 hours for the old TTL to expire from DNS caches worldwide | — | Day 2 |
| 6 | At agreed cutover time: Max updates the A record and www CNAME values to point to Vercel | Max | Day 3 |
| 7 | Propagation completes in approximately 5–10 minutes due to the low TTL set in step 4 | — | Day 3 |
| 8 | Max verifies propagation with dig and curl commands from multiple DNS servers | Max | Day 3 |
| 9 | Max confirms live URL shows the new site | Max | Day 3 |
| 10 | Max notifies client: site is live | Max | Day 3 |
| 11 | Max restores TTL to 3600 | Max | Day 3 |

**Why TTL reduction matters:**
TTL (Time To Live) tells DNS resolvers how long to cache a DNS record before checking for updates. If the old TTL is 86400 (24 hours), and you change the DNS value, visitors whose DNS was recently cached will still reach the old site for up to 24 hours. Reducing TTL to 300 seconds 24–48 hours before the cutover means old caches expire quickly, and the new value propagates within minutes of the DNS update.

**Preferred cutover time:** Off-peak hours for the client's business (e.g. 10pm–6am). Lower visitor volume means fewer people experience any edge-case delay.

**Client-facing language:**
"Your current site stays live until the exact moment we switch. I'll prepare everything behind the scenes — deploy the new site, do full testing, and pre-configure the DNS timing. When we flip the switch at [TIME], visitors see the new site within minutes. I'll confirm the moment everything is live."

---

### SCENARIO 7 — CLIENT HAS EMAIL ON THEIR DOMAIN

**Situation:** The client uses professional email addresses on their domain (e.g. info@drsmith.co.za, dr.smith@drsmith.co.za). Breaking email is operationally catastrophic — worse than a website being down.

**Risk Level:** HIGH if email protection protocol is not followed — LOW if it is followed correctly

**Time Estimate:** Same as normal deployment plus 15 minutes for email verification

**MANDATORY: Run these steps BEFORE any DNS change is made:**

| Step | Action | Owner |
|------|--------|-------|
| 1 | Ask client: "Do you use email addresses on this domain?" (if not established during discovery) | Max |
| 2 | Run `dig MX clientdomain.com +short` and document all MX records | Max |
| 3 | Run `dig TXT clientdomain.com +short` and save all TXT records (SPF, DKIM, DMARC) | Max |
| 4 | Screenshot the full DNS record view in the registrar before making any changes | Max |
| 5 | Identify the email provider from the MX records (see reference table in Output 5) | Max |
| 6 | Make ONLY the following DNS changes: update A record, update www CNAME | Max |
| 7 | Do NOT delete, modify, or touch any MX records | Max |
| 8 | Do NOT delete, modify, or touch any TXT records containing SPF, DKIM, DMARC, or provider verification strings | Max |
| 9 | After propagation: run `dig MX clientdomain.com +short` again — verify output matches what was saved in step 2 | Max |
| 10 | Send a test email to the client's domain email address. Ask client to confirm receipt within 1 hour. | Max / Client |

**If email breaks after DNS change:**
Immediately restore the MX and TXT records to the values saved in step 2–3. The records take effect within 1 TTL period (5–300 minutes depending on current TTL). Do not attempt any further DNS changes until email is confirmed working again.

**Client-facing language:**
"Before I touch anything, I'll check your email setup. Your email will keep working throughout the transition — I'll document every email-related record before I change a single thing, and I'll verify it personally after the switch. I'll send a test email to your inbox and ask you to confirm it arrived."

---

### SCENARIO 8 — DOMAIN LOCKED IN WEBSITE BUILDER

**Situation:** Client's domain was registered through a website builder platform (Wix, Squarespace, Weebly, WordPress.com, etc.) and is managed inside that platform's interface.

**Risk Level:** MEDIUM — builders sometimes make the transfer process intentionally confusing or place it behind paid plans

**Time Estimate:** 5–10 business days for domain transfer

**Platform-specific unlock steps:**

**Wix:**
1. Log into Wix account
2. Go to Account Settings → Domains
3. Select the domain → click Transfer Away from Wix
4. Unlock the domain
5. Copy the EPP/auth code
6. Initiate transfer at Namecheap → enter auth code
7. Approve transfer via email from Wix
8. Wait 5–7 business days

**Squarespace:**
1. Log into Squarespace account
2. Go to Settings → Domains
3. Select the domain → click Transfer
4. Toggle domain lock OFF (Unlock Domain)
5. Copy the auth code
6. Initiate transfer at Namecheap → enter auth code
7. Approve via email
8. Wait 5–7 business days

**Weebly (now Square Online):**
1. Log into Weebly/Square Online
2. Go to Account → Domains
3. Select domain → click Transfer Domain
4. Unlock domain
5. Copy auth code
6. Initiate transfer at Namecheap → enter auth code
7. Wait 5–7 business days

**WordPress.com:**
1. Log into WordPress.com
2. Go to Upgrades → Domains
3. Select the domain → click Transfer Domain
4. Unlock domain
5. Copy auth code
6. Initiate transfer at Namecheap → enter auth code
7. Approve via email from WordPress.com
8. Wait 5–7 business days

**GoDaddy (used as website builder):**
The domain is typically already registered at GoDaddy as a registrar, not embedded in the builder. Log into GoDaddy directly, navigate to My Products → Domains, and update DNS directly. No transfer needed. Proceed to Scenario 1.

**Alternative approach (DNS-only, no transfer):**
If the client wants to keep their builder account active for some reason, most paid builder plans allow DNS to be pointed externally via custom DNS settings within the platform. This is less clean — the domain remains locked inside the builder — but it avoids the 5–7 day transfer wait. Not recommended as a permanent solution.

**Recommended approach:** Always transfer the domain OUT of the builder to Namecheap. Clean break. Client owns the domain independently of any platform.

**Fallback:** If the builder platform refuses to release the domain or makes it technically impossible, file a complaint with ICANN (for gTLDs) or ZADNA (for .co.za). Document all attempts. This is rare but has occurred with some smaller or grey-market builders.

**Client-facing language:**
"Your domain is connected to [WIX/SQUARESPACE]. We need to move it out so you're not locked into their system — this is standard practice when switching to a professionally hosted site. I'll send you the exact steps for your platform; it only takes a few minutes on your end and then about a week to fully transfer. I'll handle everything once I receive the auth code."

---

## OUTPUT 2 — DOMAIN DISCOVERY CHECKLIST

Ask these questions at the start of every sales or onboarding conversation. This is non-negotiable. Domain complexity identified after signing creates timeline and fee surprises that damage client trust.

---

### DOMAIN DISCOVERY — Ask Before Signing

**Question 1: Do you currently have a website?**
If no → skip to question 7 (Scenario 5). If yes → continue.

**Question 2: What is your domain name?**
Record exactly as stated (e.g. drsmith.co.za, not "doctor smith dot co dot za"). Verify spelling. Run a quick whois lookup while on the call.

**Question 3: Do you have login access to where your domain is registered?**
Common registrars: Namecheap, GoDaddy, Domains.co.za, Afrihost, xneelo, 1-grid, Hetzner.
If client says "I don't know who registered it" or "my old web person set it up" → flag as potential Scenario 2 or 3.

**Question 4: Who registered the domain — you personally, or a web agency?**
If agency → flag as potential Scenario 3.
Follow-up: "Is the domain registered in your name, or in their company name?" Whois lookup can confirm.

**Question 5: Do you use email addresses on this domain?**
Example: info@drsmith.co.za or firstname@drsmith.co.za.
If yes → flag as Scenario 7. Email protection protocol is mandatory. Never proceed with DNS changes before documenting email records.

**Question 6: Is your current site built on Wix, Squarespace, WordPress.com, or another website builder?**
If yes → flag as Scenario 8. Add 5–10 business days to timeline.

**Question 7: If you need a new domain, do you have a preference?**
E.g. "drsmithdental.co.za". Max can check availability in real time during the conversation.

---

### Quick Risk Assessment After Discovery

| Result | Risk Level | Action |
|--------|-----------|--------|
| Client has direct access to registrar, no email concerns, not on a builder | GREEN | Scenario 1 or 5. Standard timeline. |
| Client unsure about access, mentions old web agency, or is on a builder | YELLOW | Scenario 2, 3, or 8. Add 1–2 weeks to project timeline. |
| Client has email on domain AND agency owns domain | RED | Scenario 3 + 7 combined. Add 2–4 weeks. May require additional R1,500 domain recovery fee. Quote this upfront before signing. |

**Rule:** Never begin building the demo until the domain discovery is complete and risk level is documented. This protects Max and sets correct client expectations from day one.

---

## OUTPUT 3 — CLIENT COMMUNICATION TEMPLATES

Use these verbatim or adapt minimally. Consistent language builds trust and sets expectations clearly.

---

### Template 1: Requesting Domain Access (Scenario 1)

Subject: Domain access for [DOMAIN] — quick request

"Hi [NAME],

To connect your new website to your domain [DOMAIN], I'll need access to your domain registrar — that's where your domain name is managed (usually Namecheap, GoDaddy, or similar).

You can either share the login details with me securely, or add me as a collaborator. My email is maxhurrellsa@gmail.com.

I'll only touch the DNS settings — nothing else on your account changes. Once I'm in, it takes about an hour to get everything connected.

Let me know how you'd prefer to handle it and I'll take it from there."

---

### Template 2: Domain Recovery — Password Reset Path (Scenario 2)

Subject: Recovering your domain [DOMAIN]

"Hi [NAME],

I checked your domain [DOMAIN] and it's registered at [REGISTRAR]. To connect your new site, we need to recover access to that account. Here's what to do:

1. Go to [REGISTRAR LOGIN URL]
2. Click 'Forgot Password'
3. Check which email address it sends the reset link to — it might be an old address

If the recovery email still works: reset the password, then share access with me and I'll take it from there.

If the recovery email no longer works: let me know and I'll contact [REGISTRAR]'s support team directly to walk through account recovery with them. They'll usually need to verify your identity with an ID document. This typically takes 2–3 business days.

Let me know which situation you're in and I'll guide the next step."

---

### Template 3: Dealing with Old Agency — Domain in Their Name (Scenario 3)

Subject: Your domain [DOMAIN] — important information

"Hi [NAME],

I looked into your domain [DOMAIN] and it's currently registered under [AGENCY NAME]'s account. This is fairly common — many agencies register client domains in their own name. The good news is you have a clear right to get it transferred.

Here's what we need to do:

1. Contact [AGENCY NAME] and request a domain transfer. Here's a message you can send them:

'Hi, I'd like to transfer my domain [DOMAIN] to a new registrar. Please unlock the domain and send me the transfer authorisation (EPP) code at your earliest convenience.'

2. If they cooperate, the transfer takes about 5–7 business days.

3. If they don't respond within 7 days, I have escalation options available through the domain authority that typically get results without needing a lawyer.

Would you like me to draft that email for you, or send it on your behalf? Let me know how you'd like to proceed."

---

### Template 4: Email Protection Notice (Scenario 7)

Subject: Protecting your email during the transition — [DOMAIN]

"Hi [NAME],

Before I make any changes to your domain, I want to confirm one thing: do you use email addresses like info@[DOMAIN] or [name]@[DOMAIN]?

If so, I need to document your email settings before touching anything to make sure your inbox keeps working throughout the transition. Breaking email is the one thing I absolutely will not do.

I'll verify your email records before and after the switch, and I'll send a test email to confirm everything is working. You'll barely notice the changeover happened.

Just confirm whether you use domain email and I'll handle the rest."

---

### Template 5: Website Builder Domain Unlock (Scenario 8)

Subject: Moving your domain from [WIX/SQUARESPACE] — what I need from you

"Hi [NAME],

Your domain is currently managed inside [WIX/SQUARESPACE]. To connect it to your new site, we need to transfer it out. This is a standard process and means you'll own your domain independently going forward — not locked to any platform.

Here's what I need you to do:

1. Log into your [PLATFORM] account
2. Go to [SPECIFIC NAVIGATION PATH — e.g. Account Settings → Domains]
3. Click 'Transfer Away' or 'Unlock Domain'
4. Copy the authorisation code it gives you
5. Send that code to me

I'll handle everything from there. The transfer itself takes about 5–7 business days, during which your current site stays live.

If you run into any confusion in the [PLATFORM] settings, just screenshot where you're stuck and I'll guide you through it."

---

### Template 6: Urgent Domain Expiry (Scenario 4)

Subject: URGENT — Your domain [DOMAIN] expires [DATE]

"Hi [NAME],

I need to flag something urgently: your domain [DOMAIN] expires on [DATE].

If it expires and isn't renewed, your web address becomes available for anyone to register — including competitors. This needs to be addressed this week.

Can you check whether you have login access to [REGISTRAR]? If you do, log in and renew the domain immediately. Renew for at least 2 years.

If you don't have access, let me know right now and I'll start the recovery process immediately — we may not have time for a slow recovery, so speed matters here.

This is the most important thing to do today."

---

### Template 7: DNS Propagation Update (All Scenarios)

Subject: Your new site is live — [DOMAIN]

"Hi [NAME],

I've connected your domain to the new site. It's propagating now — meaning the internet is updating its records to point to your new site. This usually takes 30 minutes to 2 hours, sometimes up to 24 hours in rare cases.

During this window, some visitors might still see the old site depending on their internet provider's DNS cache. This is completely normal.

I'll confirm the moment everything is fully live and verified. Once confirmed, I'll send you the final URL and any handover notes."

---

## OUTPUT 4 — PRICING LOGIC

---

### Included in Standard Package (All Tiers)

The following domain scenarios are handled as part of standard project delivery. No additional fee. The effort is absorbed into the project.

| Scenario | What is included |
|----------|-----------------|
| Scenario 1 — Client has domain access | Max configures DNS, adds domain in Vercel, verifies SSL and propagation. Fully included. |
| Scenario 5 — New domain registration | Max registers the domain in the client's name. Registrar cost (~R100–150/year for .co.za, ~USD $10–12/year for .com) absorbed by Max for the first year. Renewal is the client's responsibility from year 2. |
| Scenario 6 — Zero-downtime cutover | TTL management, staged cutover, propagation verification. Standard deployment practice. Fully included. |
| Scenario 7 — Email protection during DNS change | MX record documentation, post-change verification, test email confirmation. Standard protocol. Fully included. |

---

### Included but May Extend Timeline (No Additional Fee — Set Expectations Upfront)

These scenarios require client-side effort and waiting periods. Max assists throughout. No fee is charged, but the timeline impact must be communicated at the point of discovery — not after signing.

| Scenario | Timeline impact | Max's role |
|----------|----------------|-----------|
| Scenario 2 — Client lost domain access | Adds 1–5 business days | Identifies registrar, guides client through recovery steps, follows up daily |
| Scenario 8 — Builder domain unlock/transfer | Adds 5–10 business days | Provides platform-specific instructions, receives auth code, completes transfer |

---

### Additional Fee — R1,500 Domain Recovery and Transfer Service

The following scenarios require significant active effort from Max and are charged as a separate line item. This fee must be quoted and agreed in writing BEFORE the client signs the main contract.

**Scenario 3 — Old agency owns domain:**
Max handles all written communications with old agency, drafts formal demand letters, files ICANN or ZADNA ADR complaint if required, manages the transfer process end-to-end. Covers up to 3 rounds of communication with the old agency and one formal complaint filing.

**Scenario 4 — Urgent expiry with access recovery needed:**
Fast-track recovery attempt where time is critical. Includes same-day registrar contact and escalation. If the domain is already in its redemption period, the client pays the redemption fee (typically R1,000–R2,500) directly to the registrar in addition to the R1,500 service fee.

**Any scenario requiring legal intervention:**
Max can draft a demand letter template that the client's attorney can adapt and send on legal letterhead. Attorney fees are entirely the client's responsibility. Max does not provide legal advice.

---

### Pre-Sale Rule

Domain complexity must be identified during discovery (Output 2). If Scenario 3 or Scenario 4 is identified at any point — including during whois lookup after signing — the R1,500 fee is added to the project invoice and discussed with the client before any recovery work begins.

Never surprise a client with domain fees after the fact. If the situation is unclear at signing, note it as "domain status TBC — additional fee may apply" in the contract.

---

## OUTPUT 5 — TECHNICAL REFERENCE

---

### DNS Records for Vercel

| Type | Host | Value | TTL (pre-cutover) | TTL (normal) |
|------|------|-------|-------------------|-------------|
| A | @ | 76.76.21.21 | 300 | 3600 |
| CNAME | www | cname.vercel-dns.com | 300 | 3600 |

Note: Some registrars use `@` to represent the root domain. Others require you to leave the Host field blank. Both achieve the same result.

Note: For .co.za domains managed through some SA registrars (e.g. xneelo, Afrihost), the DNS interface may use "subdomain" and "destination" terminology rather than "Host" and "Value". The values are the same.

---

### TTL Management Protocol

**Why this matters:**
TTL (Time To Live) is the number of seconds DNS resolvers cache a record before re-checking. If TTL is 86400 (24 hours) and you update the A record, visitors whose DNS was cached recently will still hit the old server for up to 24 hours. Reducing TTL to 300 (5 minutes) 24–48 hours before cutover means caches refresh quickly and the DNS change takes effect in minutes.

**Pre-cutover (24–48 hours before going live):**
1. Log into the registrar's DNS management panel
2. Change TTL on the A record (@ pointing to old host) to 300 seconds
3. Change TTL on the www CNAME to 300 seconds
4. Save. No other changes.
5. Wait 24–48 hours. This allows all global DNS resolvers to refresh their caches with the new TTL value.

**At cutover:**
1. Update A record value to 76.76.21.21
2. Update www CNAME value to cname.vercel-dns.com
3. Save. Propagation will complete in approximately 5–10 minutes.
4. Verify using commands below.

**After cutover (once site is confirmed live):**
1. Change TTL on A record back to 3600
2. Change TTL on www CNAME back to 3600
3. This reduces unnecessary DNS query load. Not urgent — can be done same day or next day.

---

### Email Protection — MX Record Preservation

**MANDATORY: Run these commands BEFORE making any DNS change when the client has domain email.**

```bash
# Step 1: Document current MX records
dig MX clientdomain.co.za +short

# Step 2: Document current TXT records (SPF, DKIM, DMARC, provider verification)
dig TXT clientdomain.co.za +short

# Step 3: Save to a file before touching anything
dig MX clientdomain.co.za +short > /tmp/client-email-records.txt
dig TXT clientdomain.co.za +short >> /tmp/client-email-records.txt
echo "Saved: $(date)" >> /tmp/client-email-records.txt

# Step 4: After DNS change — verify MX records are unchanged
dig MX clientdomain.co.za +short
# Output must match what was saved above. If it doesn't, restore immediately.

# Step 5: Verify SPF is still present
dig TXT clientdomain.co.za +short | grep -i spf
# Must return a result. If empty, SPF record was accidentally deleted — restore it.
```

**Common MX records by provider:**

| Email Provider | MX Record Pattern |
|----------------|------------------|
| Google Workspace | ASPMX.L.GOOGLE.COM, ALT1.ASPMX.L.GOOGLE.COM (and up to 4 alt servers) |
| Microsoft 365 | [tenant].mail.protection.outlook.com |
| Zoho Mail | mx.zoho.com, mx2.zoho.com, mx3.zoho.com |
| cPanel/Web hosting | Usually the hosting server hostname (e.g. mail.clientdomain.co.za) |
| Afrihost | mail.afrihost.co.za |
| xneelo / Hetzner | Varies — check registrar dashboard |
| Titan Mail | mx1.titan.email, mx2.titan.email |

**Non-negotiable rules:**
- NEVER delete MX records when updating A or CNAME records
- NEVER delete TXT records containing v=spf1, k=rsa (DKIM), or v=DMARC1
- If the registrar shows all DNS records in one view, screenshot the full list before making any changes
- After every DNS change where email is present: send a test email TO the client's domain address and ask for confirmation within 1 hour
- If email stops working: restore the MX and TXT records immediately from the saved file. Do not investigate further until email is confirmed working again.

---

### Propagation Verification Commands

```bash
# Verify A record has propagated to Vercel
dig clientdomain.co.za +short
# Expected output: 76.76.21.21

# Verify www CNAME has propagated
dig www.clientdomain.co.za +short
# Expected: cname.vercel-dns.com (may also show 76.76.21.21 on next line)

# Verify from Google DNS
dig @8.8.8.8 clientdomain.co.za +short

# Verify from Cloudflare DNS
dig @1.1.1.1 clientdomain.co.za +short

# Verify from OpenDNS
dig @208.67.222.222 clientdomain.co.za +short

# Check SSL certificate and HTTP response
curl -sI https://clientdomain.co.za | grep -i "HTTP\|strict-transport\|location"
# Expected: HTTP/2 200 (or 301 redirect from http to https)
# Must include: strict-transport-security header once Vercel provisions SSL

# Check MX records are still intact after DNS change
dig MX clientdomain.co.za +short

# Check SPF record is still present
dig TXT clientdomain.co.za +short | grep -i spf

# Full DNS health check in a single command
echo "=== A RECORD ===" && dig @8.8.8.8 clientdomain.co.za +short && \
echo "=== WWW ===" && dig @8.8.8.8 www.clientdomain.co.za +short && \
echo "=== MX ===" && dig MX clientdomain.co.za +short && \
echo "=== SPF ===" && dig TXT clientdomain.co.za +short | grep -i spf && \
echo "=== HTTP ===" && curl -sI https://clientdomain.co.za | head -5
```

Replace `clientdomain.co.za` with the actual domain in every command.

---

### WHOIS Lookup — Identify Registrar and Expiry

```bash
# For .com, .net, .org (gTLDs)
whois clientdomain.com | grep -iE "registrar:|expiry date:|expiration date:|name server:"

# For .co.za
whois clientdomain.co.za | grep -iE "registrar|expiry|name server|registrant"

# Quick expiry check only
whois clientdomain.com | grep -i "expir"
```

**Reading the output:**
- `Registrar:` — tells you where the domain is registered (e.g. GoDaddy, Namecheap)
- `Registrar Registration Expiration Date:` — tells you when the domain expires
- `Name Server:` — tells you which DNS provider is being used (may differ from registrar)
- `Registrant Name:` or `Registrant Organization:` — tells you who owns the domain (key for Scenario 3)

---

### Domain Transfer Checklist (Transferring to Namecheap)

Use this checklist whenever a domain transfer is needed (Scenarios 3 and 8 most commonly).

| Step | Action | Owner | Notes |
|------|--------|-------|-------|
| 1 | Confirm domain is unlocked at current registrar | Client / Max | Some registrars call this "transfer lock" — it must be OFF |
| 2 | Request EPP/auth code from current registrar | Client / Max | Also called "transfer authorisation code" — emailed to registrant email on file |
| 3 | Go to namecheap.com → Domains → Transfer | Max | Enter domain name, then auth code when prompted |
| 4 | Pay transfer fee | Max (reimbursed) | ~$8–12 USD for .com (includes 1-year renewal). ~R80–120 for .co.za |
| 5 | Approve the transfer via email | Client | Sent to the registrant's WHOIS email address. Must click approve within 5 days. |
| 6 | Wait for transfer to complete | — | 5–7 business days for most gTLDs. .co.za can be faster (2–3 days). |
| 7 | Confirm domain now shows in Namecheap account | Max | |
| 8 | Configure DNS for Vercel — A record and www CNAME | Max | Proceed with Scenario 1 steps from here |
| 9 | Add domain in Vercel project settings | Max | |
| 10 | Verify SSL certificate issued and site loads correctly | Max | |

**Common failure points:**
- Client does not receive the approval email → check spam folder; request re-send from Namecheap transfer dashboard
- Auth code rejected → domain may still be locked, or code has expired (request a new one)
- Transfer blocked due to recent domain changes → ICANN requires 60-day lock after registration or owner details change; cannot transfer during this period

---

### SA-Specific Domain Notes

**.co.za domains:**
- Managed by ZADNA (ZA Domain Name Authority) — zadna.org.za
- Registered through ZADNA-accredited registrars: Afrihost, xneelo (formerly Hetzner SA), 1-grid, Web4Africa, Domains.co.za
- ADR (Alternative Dispute Resolution) process available for .co.za domain disputes at zadna.org.za/adrs
- Transfer process is similar to gTLDs but may be faster (2–3 days vs 5–7 days)
- Redemption period and pending delete timelines may differ from .com — verify with the specific registrar

**Registrar recommendations for SA clients:**
- Domains.co.za — clean interface, responsive support, good for SA-based clients
- Namecheap — preferred for international domains (.com), good pricing, strong control panel
- Avoid registering domains at GoDaddy for new clients — interface is cluttered with upsells and DNS propagation can be slower

---

*This playbook is referenced by DEPLOYMENT-PROCESS.md. For the tactical go-live steps post domain resolution, see GO-LIVE-CHECKLIST.md.*
*Last updated: March 2026*
