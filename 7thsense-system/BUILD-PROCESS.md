# 7thsense Build Process — Master Template System

## The Rule

**Same skeleton. Different skin and soul.**

Every build uses the same section registry and structural rules.
Every build looks completely different because a niche config drives all visual decisions.

---

## Build Steps (follow in exact order)

### Step 1: Create Niche Config (10 min)

Copy `niche-config-template.json` to your project directory.
Fill in EVERY field. Leave nothing blank.

```bash
cp ~/7thsense-system/niche-config-template.json ./niche-config.json
# Edit niche-config.json — fill ALL fields
```

**Key decisions at this stage:**
- What is the emotional tone? (reassuring / authoritative / urgent / aspirational / friendly)
- What is the hero layout? (pick one you haven't used in the last 3 builds)
- What is the visual personality? (border radius, card style, divider style)
- What is the section order? (niche determines this, not habit)

### Step 2: Validate Config

```bash
bash ~/7thsense-system/scripts/validate-niche-config.sh ./niche-config.json
```

Do not proceed until this passes with 0 errors.

### Step 3: Run Pre-Build Skills (per CLAUDE.md)

1. **7thsense-systems-architect** — blueprint from config
2. **7thsense-visual-system** — CSS variables from config brand values
3. **7thsense-copy-architect** — all copy written using config's copy_register
4. **7thsense-image-agent** — images sourced/generated using config's image prompts

### Step 4: Build

Build the HTML using:
- Section order from `config.sections.order`
- CSS variables from `config.brand` + `config.visual_personality`
- Copy tone from `config.copy_register`
- CTA text from `config.cta_config`
- Hero layout from `config.hero`
- Font pairing from `config.typography`

**The config is the spec. Don't improvise.**

### Step 5: QA

```bash
bash ~/7thsense-system/scripts/qa-pre-deploy.sh ./index.html ./niche-config.json
```

Do not deploy until this passes with 0 errors.

### Step 6: Deploy

Deploy to its own Vercel project. Confirm 200 response.

---

## The 8 Differentiation Levers

These are the minimum variables that produce maximum visual difference between builds:

| # | Lever | Options | Impact |
|---|-------|---------|--------|
| 1 | **Heading font** | 8 approved fonts | Changes entire feel instantly |
| 2 | **Hero layout** | 6 layouts | First thing visitor sees |
| 3 | **Border radius** | 0px to 9999px | Sharp vs soft vs pill — changes everything |
| 4 | **Card style** | flat / elevated / bordered / glass | Section personality |
| 5 | **Section order** | Niche-driven | Different story flow |
| 6 | **Divider style** | none / line / gradient / wave / angle | Visual rhythm |
| 7 | **Accent pattern** | 5 options | How colour is applied |
| 8 | **CTA shape + text** | 3 shapes x niche verbs | Call to action personality |

**Rule: No two consecutive builds may share the same value on more than 2 of these 8 levers.**

---

## Niche Quick-Reference

### Dentist / Medical
- Tone: reassuring, clinical
- Font: DM Sans or Inter
- Hero: image_right (show the practice)
- Radius: 8-12px (soft, approachable)
- Cards: elevated (clean, professional)
- CTA: "Book Your Appointment"
- Order: Trust → Services → Social Proof → Team

### Insurance / Financial
- Tone: authoritative, confident
- Font: Syne or Outfit
- Hero: full_bleed_overlay (dramatic)
- Radius: 9999px (pill buttons, bold)
- Cards: bordered (structured, clear)
- CTA: "Get a Free Quote"
- Order: Process → Services → Social Proof → Pricing

### Plumber / Trades
- Tone: urgent, direct
- Font: Urbanist or General Sans
- Hero: gradient_only (fast-loading)
- Radius: 4px (sharp, no-nonsense)
- Cards: flat (utility, speed)
- CTA: "Call Now" / "Get Emergency Help"
- Order: Services → Social Proof → Service Area → Gallery

### Lawyer / Professional Services
- Tone: authoritative, restrained
- Font: Plus Jakarta Sans or Cabinet Grotesk
- Hero: split_diagonal (distinctive)
- Radius: 0-4px (serious, sharp)
- Cards: glass or bordered (sophisticated)
- CTA: "Free Consultation"
- Order: About → Services → Social Proof → Process

### Spa / Beauty / Wellness
- Tone: aspirational, warm
- Font: Satoshi or Outfit
- Hero: image_left (showcase experience)
- Radius: 16px (soft, luxurious)
- Cards: elevated with subtle shadow
- CTA: "Book Your Treatment"
- Order: Gallery → Services → Social Proof → Pricing

### Restaurant / Hospitality
- Tone: friendly, inviting
- Font: Cabinet Grotesk or General Sans
- Hero: video_bg or full_bleed_overlay
- Radius: 8px (balanced)
- Cards: flat (let food/atmosphere speak)
- CTA: "Reserve a Table" / "View Menu"
- Order: Gallery → About → Services → Social Proof

---

## Anti-Repetition Checklist

Before starting any build, check the last 3 builds:

- [ ] Different heading font from last build
- [ ] Different hero layout from last build
- [ ] Different border radius from last build
- [ ] Different card style from last build
- [ ] Different section order from last build
- [ ] Different divider style from last build
- [ ] Different colour family from last build
- [ ] Different CTA verb from last build

If more than 2 match — change them before building.
