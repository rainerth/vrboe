# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Hugo static site for the **Vereinsring Bösingen e.V.** — a community association that bundles all local clubs in 78662 Bösingen and runs joint events such as the *Dorffest*.

- **Live URL:** https://www.boesinger-vereine.de
- **Repo:** `git@github.com:rainerth/vrboe.git`
- **Server:** `wme00-vrboe` (Hostsharing, SSH)

## Architecture

- **Theme:** `hugo-theme-cleanwhite` — checked in directly under `themes/` (NOT a submodule, has local customisations)
- **Content Structure:**
  - `/content/_index.md` — landing page (event list)
  - `/content/termine/<verein>/YYYYMMDD_*.md` — event entries per club, each with `img/` siblings
  - `/content/vereine/index.md` — single page listing all clubs with logos and descriptions
  - `/content/buergerenergie/index.md` — redirect to `https://www.buergerenergie-boesingen.de`
  - `/content/zukunft-boesingen/index.md` — Zukunftswerkstatt (with Tally form)
  - `/content/{kontakt,dorffest,anreise,archiv,programm,schauplätze}/index.md`
- **Build System:** `build.sh` (Hugo + Pagefind)
- **Search:** Pagefind index under `public/pagefind/`

## Key Commands

```bash
# Development server (with future-dated events)
hugo server --buildFuture --bind 127.0.0.1 --port 1314

# Production build with search
./build.sh

# Alternative production build via npm
npm run build

# Create new event
hugo new content termine/<verein>/YYYYMMDD_event.md
```

## Build Process

`./build.sh`:
1. Runs `hugo --cleanDestinationDir --buildFuture --minify`
2. Runs `npx pagefind --site public --output-subdir pagefind`

## Deployment

Two paths:

- **Cron (Server):** `~/bin/update-gitrepo.sh` runs every hour on `wme00-vrboe`. It fetches GitHub, resets to remote and rebuilds with Hugo + Pagefind. The bundled `deploy-server.sh` is the more verbose alternative (with logging) and can be called manually with `--force`.
- **Manual via Skill:** `/deploy vrboe` — local preview, push, and force-build via SSH. See `~/Dokumente/Obsidian.rth/rthwiki/.claude/skills/deploy/SKILL.md`.

## Frontmatter Conventions

Event posts (`/content/termine/<verein>/*.md`):

```yaml
---
layout: post
title: "Weinfest"
subtitle: "25. und 26. Oktober"
PublishDate: 2025-04-01
date: 2026-10-25
location: "Mehrzweckhalle Bösingen"
organizer: "Musikverein Bösingen e.V."
image: "/termine/musikverein-boesingen/img/mvhb-hero.jpg"
---
```

Redirect pages use `layout: redirect` and `redirect_url: …` (see `layouts/_default/redirect.html`).

## Site Configuration

- **`hugo.toml`** — global settings, sidebar friend-link list, additional menus
- **`buildFuture = true`** — future-dated events appear on the site immediately
- `paginate = 15`, RSS enabled, robots.txt enabled
- Custom CSS: `/static/css/custom.css`

## Language Guidelines

- All content in German
- Use the formal address form "Sie" (not "Du")

## Server Tooling

`wme00-vrboe` provides:
- `~/bin/hugo` — Hugo extended (v0.152.2+)
- `npx pagefind` — Pagefind via npm registry
- `~/bin/update-gitrepo.sh` — cron-driven repo-pull + rebuild

## Dokumentation in Obsidian

Vault-Notizen (Konventionen, Memory):
`~/Dokumente/Obsidian.rth/rthwiki/`
