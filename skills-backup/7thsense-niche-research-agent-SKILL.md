---
name: 7thsense-niche-research-agent
description: 'Run this skill BEFORE building any new niche. Automatically researches the niche using web search and Firecrawl to produce deep, evidence-based niche intelligence. Replaces manual niche skill writing. Output is saved as a niche skill file that governs the build.'
---

# 7thsense Niche Research Agent

## Purpose
Before building any new niche, this agent runs automated research to produce a niche intelligence document grounded in real data — not assumptions. This replaces manually written niche skills with evidence-based ones.

## Trigger
Run this agent when:
- A new niche is being built for the first time
- A niche skill file does not yet exist
- Max provides a good reference site and a bad site for a new niche
- The system needs to understand visitor psychology for a new industry

## Research Process — Run Every Step

### STEP 1: Analyse the reference sites
Use Firecrawl to scrape both the good reference site and the target bad site.
Extract:
- Section structure and order
- Copy tone and language
- CTAs used
- Trust signals shown
- What they do well (good site) and what's missing (bad site)

### STEP 2: Research the niche conversion patterns
Use web search to find:
- "[niche] website best practices conversion"
- "[niche] website what patients/clients look for"
- "[niche] website mistakes"
- "best [niche] websites examples"
- "[niche] visitor psychology booking behaviour"
Extract real data, not assumptions. Find industry studies, CRO reports, and practitioner forums.

### STEP 3: Research the visitor psychology
Use web search to find:
- What emotional state visitors are in when searching for this service
- What their biggest fears and objections are
- What makes them choose one provider over another
- What trust signals matter most in this niche
- How long they research before booking
- What device they use (mobile vs desktop split for this niche)

### STEP 4: Research pricing and value
Use web search to find:
- Typical service price ranges in this niche
- How price-sensitive the visitor is
- Whether showing pricing helps or hurts conversion
- What the ROI argument is for the business owner (why a website is worth it to them)

### STEP 5: Find the best and worst examples
Use web search to find 3 examples of excellent websites in this niche and 3 poor ones.
For each good example: what specifically makes it work?
For each bad example: what specifically makes it fail?

### STEP 6: Compile the niche intelligence document
Produce a complete skill file at:
~/.claude/skills/7thsense-niche-[name]/SKILL.md

The document must include:
- Why this niche (ROI argument for business owner)
- Visitor emotional state and psychology (evidence-based)
- Device and search behaviour
- Above the fold requirements
- Must-have sections in priority order
- Trust signals that matter most in this niche
- CTA language that converts
- Copy tone and voice
- Visual language and photography style
- Pricing transparency recommendation
- What to avoid (with reasons)
- Section order optimised for this niche's visitor journey
- Reference sites (good and bad)

### STEP 7: Cross-reference with locked components
Check which locked components apply unchanged and which need niche-specific variants.
Document any niche-specific module variations.

### STEP 8: Save and commit
Save the skill file.
Backup to ~/agency-templates/skills-backup/
Commit: "feat: [niche] niche intelligence — auto-researched"

## Output Quality Standard
The output must be at least as deep as this example from our sales partner for law firms:
- Visitor mindset with specific emotional context
- Above the fold requirements with reasoning
- Must-haves with reasoning not just a list
- What to avoid with reasoning
- Section-level guidance not just page-level

If the research produces shallow output — run more searches until it is deep enough.
