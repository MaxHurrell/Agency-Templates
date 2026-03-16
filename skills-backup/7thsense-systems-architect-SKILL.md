---
name: 7thsense-systems-architect
description: Use this skill before building ANY new website for 7thsense agency. Run this first to produce a structured technical blueprint before writing any code. Triggers on: new niche template, new client demo, new website build.
---

# 7thsense Systems Architect

You are a Senior Platform Architect at a world-class web agency specialising in conversion-focused service business websites.

Before writing any code, produce a complete technical blueprint.

## Blueprint Output

### 1. Information Architecture
- Complete page list with purpose
- Navigation structure desktop + mobile
- URL structure

### 2. User Journey Mapping
- Path 1: Emergency visitor → booking
- Path 2: Research visitor → booking  
- Path 3: Referral visitor → contact

### 3. Performance Targets
- Load time: under 2 seconds mobile
- LCP < 2.5s, CLS < 0.1, INP < 200ms
- Lazy loading on all images
- Max 2 Google Fonts with display=swap

### 4. Design Token Decisions (lock BEFORE coding)
- --font-heading: modern clean sans-serif — NO Playfair Display, NO ornate serifs
- --font-body: readable professional sans-serif
- All colours as CSS variables from client brand
- Spacing on 8px grid

### 5. Mobile-First Priorities
- Floating bar: max 2 buttons (Call + WhatsApp)
- Hamburger: minimal clean overlay menu
- Hero: full viewport, image background with gradient overlay
- CTAs: minimum 48px tap targets

## Brand Identity Extraction Phase

Run this phase BEFORE writing any code. After Firecrawl returns the site markdown:

### Step 1 — Scan for faith/religious identity
Search scraped content for: "God", "Christ", "Jesus", "Bible", "Romans", "prayer", "faith", "ministry", "Christian", "church", scripture references (pattern: Book Chapter:Verse)
If found: record in brand_identity.faith_identity
Apply as: top announcement bar + hero verse (gold, bold, accent colour) + bio sentence + trust badge

### Step 2 — Scan for founding story
Search for: "founded", "since [year]", "established", "built from", "started in", "our story"
If found: record in brand_identity.founding_story
Apply as: about section opening paragraph

### Step 3 — Scan for signature taglines
Check: `<title>`, `<h1>`, og:description, footer, repeated phrases
Look for: (R), (TM), ® symbols near phrases
If found: record in brand_identity.signature_tagline
Apply as: hero subtitle or below headline

### Step 4 — Scan for notable clients
Search for: proper nouns near "represented", "cases against", "worked with", "clients include"
Search web: "[business name] notable clients" if not found on site
If found: record in brand_identity.notable_clients
Apply as: about section, or trust strip if high-profile enough

### Step 5 — Scan for personal philosophy
Search for: "our philosophy", "our approach", "we believe", "our mission", "less is more"
If found: record in brand_identity.personal_philosophy
Apply as: hero subtitle, about section opening

### Step 6 — Populate config
Fill brand_identity field in config before proceeding to build.
Any field not found: set detected:false, leave null.
Zero tolerance: never invent brand identity. Only record what exists on the real site.

### Step 7 — Apply to build
After populating config, the build must reference brand_identity and apply every detected:true signal.
If brand_identity is empty or all fields are detected:false — the demo will feel generic. Re-run extraction.

## Quality Benchmark
Always reference padentalimplants.com. Ask: does this match or exceed that quality?
