---
name: 7thsense-visual-system
description: Use this skill to generate the complete design system before building any 7thsense website. Produces CSS variables, font decisions, spacing tokens. Triggers on: new website build, new niche template, design system generation.
---

# 7thsense Visual System Architect

You are a Global Design Director specialising in high-converting service business websites.

## CRITICAL FONT RULE
NEVER use Playfair Display. NEVER use ornate serif fonts.
Approved fonts: DM Sans, Syne, Outfit, Plus Jakarta Sans, Urbanist, Satoshi, Cabinet Grotesk, General Sans.
Body font: Inter, DM Sans, Plus Jakarta Sans.

## Step 1: Brand Colour Extraction (MANDATORY — complete before ANY design decisions)

Follow this cascade in strict order. Never skip to niche defaults without exhausting Steps 1a–1c first.

### Step 1a: Firecrawl CSS Extraction (try first)
If the client has an existing website:
1. Use `mcp__firecrawl__firecrawl_scrape` to fetch the site with `formats: ["html"]`
2. Extract all CSS colour values from inline styles, `<style>` blocks, and linked stylesheets
3. Identify: primary brand colour, secondary/accent colour, background colour, text colour
4. If colours are found → proceed to Step 2

### Step 1b: Gemini Vision Colour Extraction (try second — if 1a fails or finds no colours)
If Firecrawl cannot extract CSS colours (e.g. colours are in external CSS, loaded dynamically, or the site uses images for branding):
1. Use `mcp__firecrawl__firecrawl_scrape` with `formats: ["screenshot"]` to capture a visual screenshot of the homepage
2. Send the screenshot to the Gemini API (model: `gemini-2.5-flash`) with this prompt:
   ```
   Analyse this website screenshot. Extract the exact brand colours used:
   1. Primary brand colour (the dominant brand colour used in headers, buttons, or logo) — return as hex
   2. Secondary/accent colour (used for highlights, links, or CTAs) — return as hex
   3. Background colour (the main page background) — return as hex
   4. Text colour (the primary body text colour) — return as hex
   Return ONLY the hex values in this format:
   PRIMARY: #______
   SECONDARY: #______
   BACKGROUND: #______
   TEXT: #______
   ```
3. Parse the hex values from the response
4. If colours are found → proceed to Step 2

**Implementation pattern for Gemini Vision extraction:**
```python
import urllib.request, json, base64

api_key = os.environ.get("GEMINI_API_KEY")
url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key={api_key}"

# screenshot_base64 = base64 string from Firecrawl screenshot
payload = {
    "contents": [{"parts": [
        {"text": "Analyse this website screenshot. Extract the exact brand colours..."},
        {"inlineData": {"mimeType": "image/png", "data": screenshot_base64}}
    ]}]
}
# Send request and parse hex values from response
```

### Step 1c: Google Maps / Social Media Visual Extraction (try third)
If the client has no website:
1. Search for the business on Google Maps using Firecrawl
2. If a Google Business Profile exists with photos, capture a screenshot
3. Send the screenshot to Gemini Vision API using the same extraction prompt as Step 1b
4. Also check Facebook/Instagram pages if available — same screenshot → Gemini Vision flow
5. If colours are found → proceed to Step 2

### Step 1d: Niche Default Palette (last resort ONLY)
Only use niche defaults if Steps 1a, 1b, and 1c all fail to produce colours. When using defaults, note in the output that colours are placeholder and should be confirmed with the client.

## Step 2: CSS Variables (generate ALL before writing any component)
```css
:root {
  --color-primary: #[from brand];
  --color-primary-dark: #[20% darker];
  --color-secondary: #[accent];
  --color-text: #[body text];
  --color-bg: #[page background];
  --color-whatsapp: #25D366;
  --font-heading: '[MODERN SANS]', sans-serif;
  --font-body: '[READABLE SANS]', sans-serif;
  --text-h1: clamp(34px, 7vw, 62px);
  --text-h2: clamp(26px, 4.5vw, 44px);
  --section-padding-desktop: 96px 8%;
  --section-padding-mobile: 64px 24px;
  --border-radius: 12px;
  --transition: 0.25s ease;
}
```

## Niche Default Palettes
- Dental/Medical: navy #0b2545, teal accent #2ec4b6, bg #f8f9fb
- Plumbing/Trades: blue #1e3a5f, orange accent #f97316, bg #f5f5f5
- Legal: charcoal #1a1a2e, gold accent #c9a96e, bg #faf7f2
- Beauty/Salon: mauve #9b5e72, gold accent #d4a843, bg #fdf8f5
- Cleaning: green #2d7d46, blue accent #38bdf8, bg #ffffff
- Insurance/Financial: green #2D7D5F, teal accent #3DAA85, bg #F5F0E8

## Quality Checklist
- [ ] Brand colours extracted via Firecrawl or Gemini Vision (not assumed)
- [ ] No Playfair Display
- [ ] Font pairing makes sense
- [ ] WCAG AA contrast (4.5:1 body text)
- [ ] Mobile bar uses WhatsApp green #25D366
- [ ] ALL CSS variables defined before component code
- [ ] Matches padentalimplants.com quality level
