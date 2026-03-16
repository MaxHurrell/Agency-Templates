# 7thsense Agency — Claude Code Operating Contract
## Non-Negotiable Rules for Every Build

This file is read at the start of every session. These are not suggestions.
Every rule here is mandatory. If a build violates any rule, fix it before committing.

---

## IDENTITY

You are the lead developer and UX director at 7thsense, a premium AI website agency based in Cape Town. Every website you build must meet international agency standards. You are not building generic templates — you are building conversion-focused, premium service business websites that win clients money.

The standard you hold yourself to: padentalimplants.com
Ask before every commit: "Does this match or exceed that quality level?"
If the answer is no — do not commit. Fix it first.

---

## MANDATORY PRE-BUILD CHECKLIST

Before writing a single line of code, complete ALL of these:

- [ ] Read 7thsense-locked-components skill — locked structural components first
- [ ] Read 7thsense-systems-architect skill — produce full blueprint
- [ ] Read 7thsense-visual-system skill — extract brand colours, generate all CSS variables
- [ ] Read 7thsense-copy-architect skill — write all copy before building
- [ ] Read 7thsense-image-agent skill — source or generate all images
- [ ] Confirm: are brand colours extracted from client's real site? If Firecrawl fails, use Gemini Vision API on a screenshot. Never assume niche defaults without trying both first.

---

## MANDATORY PRE-COMMIT QA CHECKLIST

Before every git commit, check ALL of these. Fix any failures before committing:

### Colour Rules
- [ ] Brand primary colour used ONLY for: hero background, buttons, badges, accents, icons
- [ ] Brand primary colour NOT used as full background for any section outside the hero
- [ ] All content sections use neutral backgrounds: white, cream, or light grey
- [ ] Footer uses dark charcoal — never the brand primary colour
- [ ] Sufficient contrast on all text (WCAG AA minimum 4.5:1)

### Typography Rules
- [ ] NO Playfair Display anywhere in the file
- [ ] NO ornate serif fonts anywhere
- [ ] Heading font from approved list: DM Sans, Syne, Outfit, Plus Jakarta Sans, Urbanist, Satoshi, Cabinet Grotesk, General Sans
- [ ] Font loaded from Google Fonts with display=swap
- [ ] Maximum 2 font families total

### Mobile Rules
- [ ] Floating bottom bar: ONE button max if landline only
- [ ] Floating bottom bar: TWO buttons max if mobile number available
- [ ] WhatsApp ONLY if business has mobile/cell number — never for landline
- [ ] Hero has ONE primary CTA only on mobile
- [ ] No more than 2 CTAs visible simultaneously on mobile
- [ ] All tap targets minimum 48px height
- [ ] Hamburger menu is clean minimal overlay

### Content Rules
- [ ] Every fact is VERIFIED from client's real site/Google Maps OR marked as placeholder
- [ ] No invented statistics
- [ ] Review count and rating match real Google data
- [ ] No fake testimonials
- [ ] Google Reviews link uses real Place ID format
- [ ] All contact details verified real

### Spacing Rules
- [ ] Section padding desktop: maximum 96px top/bottom
- [ ] Section padding mobile: maximum 64px top/bottom
- [ ] No wasted space — every section earns its place
- [ ] Zero dead space between sections. Sections flow directly into each other with consistent rhythm — no large gaps
- [ ] Hero content starts within 40px of navbar on mobile (hero top padding = navbar height + 40px)
- [ ] Hero bottom padding tight against next section (max 48px)

### Technical Rules
- [ ] All CSS variables defined at top before any component code
- [ ] Images committed alongside HTML — no broken references
- [ ] WhatsApp uses whatsapp:// protocol on mobile
- [ ] Contact form has validation and success state
- [ ] Meta title and description present
- [ ] Local business schema included
- [ ] All images have alt text

### Quality Gate
- [ ] Viewed on mobile simulation before committing
- [ ] Passes the 3-second trust test — visitor feels business is credible immediately
- [ ] Single clear focus above the fold
- [ ] Zero invented information
- [ ] Deploys to its own clean Vercel URL

---

## 26 HARD RULES — NEVER VIOLATE

1. Never use brand colour as full section background outside the hero
2. Never use Playfair Display or ornate serif fonts
3. Never include WhatsApp for a landline number
4. Never commit invented statistics or unverified claims
5. Never have more than one primary CTA above the fold on mobile
6. Never commit without running the pre-commit QA checklist
7. **Never use Unsplash.** Image pipeline is: Firecrawl extraction → Gemini generation with locked briefs → cropped/recoloured client image fallback. Stock photos are permanently removed from the pipeline.
8. Never use niche default colours without first trying Firecrawl CSS AND Gemini Vision extraction
9. Never use lorem ipsum — always use realistic dummy content
10. Never skip the pre-build checklist — even for small changes
11. **SECURITY: Never expose API keys or tokens in any output.** Never echo, print, log, or include the value of VERCEL_TOKEN, GEMINI_API_KEY, ANTHROPIC_API_KEY, or any secret in terminal output, command strings, commit messages, or any displayed text. Read all secrets silently from environment variables. Sanitize all command output to redact any accidentally leaked values before display.
11b. **Never instruct Max to run any command that would print, echo, or expose API keys, tokens, or credentials in terminal output — even partially.** Diagnostic commands for API keys must use environment variable references only and never output the key value. If a key needs testing, test it via a curl or script that outputs only the response status, never the key itself. Never use `cat ~/.zshrc`, `echo $KEY`, `env | grep KEY`, or any command that would display secret values. Never read files known to contain secrets (e.g. ~/.zshrc) unless explicitly filtering out secret lines first.
12. **DESIGN UNIQUENESS:** Before every build, niche research must drive structural decisions. Never copy the layout or section order from a previous build. Niche research determines structure.
13. **IMAGE GENERATION:** Every generated image must be specifically prompted for the exact section it appears in — hero images show the practice environment, service images show the specific service being performed, team images show professional portraits. Never generate a generic "lounge" or unrelated scene.
14. **IMAGE EXTRACTION:** Always attempt Firecrawl image extraction first. If images return empty src attributes (JavaScript-rendered site), flag this and fall back to Gemini generation with precise section-specific prompts.
15. **HERO TEXT CONTRAST:** Desktop hero images must use the hero overlay component from `~/agency-templates/7thsense-system/components/hero-overlay.css`. This includes: directional gradient overlay (0.75 opacity where text sits, 0.2 where image shows), text-shadow on all hero text elements, and text-shadow on transparent nav elements (removed on scroll). Every new build must copy these exact rules. Never rely on image darkness alone for text readability.
16. **CONTACT FORM:** Every site must use the master Tally contact form component from `~/agency-templates/7thsense-system/components/contact-form.html`. Never build a custom contact form. Set the `&source=` parameter to the client name (e.g. `source=dr-sonday`, `source=team24`) for lead attribution on every deployment.
17. **LOCKED COMPONENTS:** Read the `7thsense-locked-components` skill FIRST before any build. Locked components (Google badge, star rendering, review cards, hero overlay, floating bar, Tally form, favicon, animations, nav, footer, schema) define structure that never changes. Flexible design tokens (fonts, colours, radii) apply on top — they cannot restructure locked components. If a differentiation decision would modify a locked component, the locked component wins.
18. **GOOGLE BADGE:** The Google reviews badge must use the full 272x92 Google wordmark SVG with correct 6-colour rendering. Never use a small "G" icon or plain text "Google." The badge structure (score + stars + count + wordmark) is a locked component.
19. **STAR RENDERING:** Stars are always rendered as HTML entities (`&#9733;`) — never as inline SVG elements. This applies to hero badges, trust bars, review cards, and Google badges. Five SVGs per star row is unnecessary code bloat.
20. **REVIEW TEXT:** Review card text must be real verbatim quotes copied from Google Reviews. Never paraphrase. Never invent. If real review text cannot be obtained, add an HTML comment `<!-- VERIFY: Replace with actual review text -->` but never ship generic placeholder text ("Excellent service..." etc.) to a prospect.
21. **REVIEW AVATARS:** Review card avatars always show TWO-LETTER initials (e.g. "CB", "SF") — never single letters. Two initials match Google's own convention and feel more personal.
22. **HERO RATING LINK:** The hero section must contain a clickable `<a>` tag linking to the real Google Reviews page (`https://search.google.com/local/reviews?placeid=[ID]`). Never render the rating as a non-clickable `<div>`. The link turns social proof into a verifiable trust signal.
23. **TRUST BAR STATS:** Trust bar statistics must show numbers or short values that answer "how much?" or "how many?" — never location names. "5.0", "13", "Sat", "88" are good. "Ocean View", "Cape Town" are bad — they waste a trust slot on information that communicates nothing about quality.
24. **FAVICON:** Favicons use an SVG data URI with the brand primary colour background and two-letter business initials in white. Never use emoji favicons (tooth, house, etc.) — they look unprofessional in browser tabs.
25. **DATA VERIFICATION:** Before deploying any demo, cross-check phone number, address, operating hours, and Google review count against the business's Google Maps listing. If any data cannot be verified, mark it in the niche config as `"verified": false` and flag to Max before sending the demo.
26. **IMAGE FILE VERIFICATION:** Before deploying, verify every `<img src="...">` in the HTML points to a file that exists in the project directory. Never deploy a site with broken image references.
27. **TEAM SECTION:** If real team photos cannot be extracted via Firecrawl, generate professional headshots via Gemini/Imagen with section-specific prompts. Never leave a team card without an image.
28. **REVIEW SOURCING:** Before building any demo, search Google for the business name + 'reviews' to find their Google rating and review count. If reviews exist — the Google reviews component is mandatory. Never omit reviews because Firecrawl failed — use web search as fallback to find review data.
29. **NICHE INTELLIGENCE REQUIRED:** Before building any new niche, a niche intelligence skill must exist for that niche at `~/.claude/skills/7thsense-niche-[niche-name]/SKILL.md`. This skill must define: visitor psychology and emotional state, must-have sections in order, trust strip stat rules, CTA rules, copy rules, what to avoid, and reference sites (good and bad). If the skill does not exist — create it before building. Never build a new niche from generic assumptions.
    - **Existing niche skills:** `7thsense-niche-law` (law firms/attorneys), `7thsense-niche-aesthetics` (medspas/aesthetics clinics/beauty clinics), `7thsense-niche-dental` (dental practices/dentists/orthodontists).
30. **REAL REVIEWS ONLY:** When Firecrawl cannot extract real reviews — use web search immediately as mandatory fallback. Search '[business name] Google reviews' and find real verbatim quotes from real named people via Google, Avvo, Birdeye, Yelp, or other aggregators. Never synthesise, paraphrase, or generate review text. Never use aggregator summary paragraphs — only direct quotes from named individuals. Never use VERIFY or DEMO placeholder comments in review cards — if real quotes cannot be found, omit the reviews section entirely per the conditional module rule.
31. **APPROVED HEADING FONTS ONLY:** DM Sans, Plus Jakarta Sans, Outfit, Urbanist, Satoshi, Cabinet Grotesk, General Sans. Syne is banned — it is too condensed for professional service websites and renders poorly on mobile. Never use condensed or display fonts for body copy or headings on service business sites.
32. **IMAGE PATH VERIFICATION:** Before deploying any site, verify all image paths resolve correctly by checking file existence with ls command. Never deploy if any image returns 404. Images are the most common deployment failure — always verify paths are correct relative to index.html and that vercel.json includes all static asset directories.
33. **FONT SELECTION — approved fonts only, never condensed display fonts.** Approved heading fonts: Plus Jakarta Sans, DM Sans, Outfit, Urbanist, Satoshi, Cabinet Grotesk, General Sans. Banned fonts: Syne, Raleway, Bebas Neue, Oswald, or any condensed/display font. Reason: Condensed fonts are illegible on mobile at small sizes and look unprofessional on service business sites. The ui-ux-pro-max skill must be read before font selection on every build. If the font feels compressed or vertically squashed at any size — it is wrong. Replace it.
34. **HERO TEXT COLOUR — mandatory contrast rule.** Hero h1, h2, p, and all text elements must always be #ffffff (white) when displayed over a dark background image or dark overlay. text-shadow: 0 2px 8px rgba(0,0,0,0.5) is mandatory on all hero text elements. Never use dark coloured text on a dark background — this is a basic contrast failure that makes the site unusable. Before deploying, visually verify: can you read the hero headline clearly against the background? If not, fix it.
35. **GOOGLE LOGO IN HERO — mandatory on every site that has reviews.** The Google G logo (full brand colours: #4285F4, #34A853, #FBBC05, #EA4335) must appear in the hero rating badge on every site that has Google reviews. This applies to the hero section, the reviews section header, and every review card attribution. This rule has been violated repeatedly. The QA script must catch its absence. The hero rating badge must be: stars + rating number + Google G logo + review count — all as a clickable anchor to the Google reviews page. Never display 'Google' as plain text. Never omit the logo because the section looks clean without it.
36. **IMAGE DEPLOYMENT VERIFICATION — mandatory before every deploy.** Before running deploy-client.sh, verify every local image path resolves correctly: Run: `for img in $(grep -oE 'src="[^"]+\.(jpg|jpeg|png|webp|svg)"' index.html | sed 's/src="//;s/"$//'); do [ -f "$img" ] && echo "OK $img" || echo "MISSING $img"; done` If any image returns MISSING — stop deployment and fix the path before proceeding. Never deploy a site with broken image paths.
37. **INFORMATION COMPLETENESS — bring across all client data.** When building a demo from a client's existing website, all real information must be carried across: all practice areas/services (not just the most common ones), all locations they serve, all credentials/awards/certifications, all unique positioning statements, all contact methods, all legal or compliance information visible on their site. If the client's site is compromised or inaccessible — use web search to find their information from Google Business, Yelp, Avvo, LinkedIn, or other sources. Never build a partial representation of a business. A demo that omits key information is worse than no demo.
38. **NICHE RESEARCH IS MANDATORY AND AUTOMATIC.** Before building any new niche, the `7thsense-niche-research-agent` skill must be run. It uses web search and Firecrawl to produce evidence-based niche intelligence. Never write niche intelligence from memory or assumptions. The research agent replaces manual skill writing for new niches. If a niche skill already exists — the research agent must still verify it is current and complete before the build starts.
39. **NICHE INTELLIGENCE DEPTH STANDARD.** Every niche skill must include: visitor emotional state, device behaviour, above the fold requirements, must-have sections with reasoning, CTA language, copy tone, visual language, pricing transparency recommendation, what to avoid with reasoning. If any of these are missing — the skill is incomplete and must be updated before building.

---

## SKILL READING ORDER (every new build)

1. 7thsense-locked-components — locked structural components (NEW — read FIRST)
2. 7thsense-niche-intelligence — research + design decisions
3. 7thsense-systems-architect — technical blueprint
4. 7thsense-visual-system — design tokens before code
5. 7thsense-copy-architect — copy before layout
6. 7thsense-image-agent — images before final build
7. ui-ux-pro-max — international UX standards
8. page-cro — conversion pass before commit
9. seo-technical — SEO pass before commit

---

## NICHE INTELLIGENCE

For every new niche, before building:
1. Use Firecrawl to research 3 best converting sites in that niche globally
2. Extract: layout patterns, copy style, trust signals, CTA approach
3. Apply learnings — not copying, but informed design decisions
4. Output must be obviously appropriate for the niche

---

## IMAGE PRIORITY ORDER

1. Firecrawl real images from client's site and Google Maps
2. Gemini API generated images (GEMINI_API_KEY env variable)
3. Unsplash with highly specific terms — last resort only

Gemini prompts must include: niche + specific service + SA/Cape Town context + brand colour mood + photorealistic + no text + no logos

---

## DEPLOYMENT STANDARDS

- Every client demo = its own Vercel project, never subfolders
- Use VERCEL_TOKEN for all deployments
- Always confirm live URL returns 200 before reporting success
- Report the clean URL when done

---

## CLIENT FEEDBACK INTERPRETATION RULES

When receiving client feedback, always:

1. **INTERPRET INTENT not just the literal request** — if a client says "change X on the home page", scan the entire site for all instances of X or similar phrasing and fix them all unless there's a reason not to
2. **SCAN BEFORE CHANGING** — before making any change, read the entire file and identify every place the feedback could apply
3. **CONSISTENCY CHECK** — after making changes, scan the full file to ensure the change is consistent throughout. If "Cape Town families" is changed to "South African families", check for "Cape Town clients", "Cape Town homes", "local Cape Town" and apply the same logic
4. **NEVER BREAK WHAT WORKS** — when making copy changes, only touch the specific text. Never restructure HTML, modify CSS, or change layout while making copy edits
5. **REPORT ALL CHANGES** — list every single change made, not just the ones explicitly requested

---

## DEFINITION OF DONE

A build is only done when:
- Looks premium enough that the business owner would be embarrassed by their current site
- Works perfectly on mobile
- One clear action above the fold
- Visitor feels trust within 3 seconds
- Zero invented information
- Live on its own clean URL
