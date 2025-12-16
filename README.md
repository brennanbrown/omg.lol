# omg.lol

This repo is a version-controlled "source of truth" for my **omg.lol** address configuration.

**Everything auto-syncs via GitHub Actions!** Push changes to any directory and they're automatically deployed to omg.lol:

- 🌐 **Profile** — content, CSS, and custom head HTML
- 📝 **Weblog** — configuration and all templates  
- ⏰ **Now page** — /now content
- 📋 **Paste files** — special pastes (humans.txt, robots.txt, security.txt, .plan)
- 💬 **Statuslog** — bio, CSS, and custom head HTML

All changes are tracked in Git with full version history and automatic deployment.

## Structure

- **`web/`**
  - `main.md` — content for my omg.lol profile page
  - `now.md` — content for my `/now` page
  - `custom.css` — custom CSS for my omg.lol profile page
  - `head.html` — custom `<head>` markup for my omg.lol profile page

- **`weblog/`**
  - `config.yml` — weblog.lol configuration
  - `landing-page-template.html` — landing page template
  - `main-template.html` — main template
  - `page-template.html` — page template
  - `post-template.html` — dedicated post template with enhanced typography
  - `weblog.css` — shared stylesheet (hosted externally at paste.lol)

- **`paste/`**
  These are “special paste” files served by omg.lol at well-known endpoints:
  - `humans.txt`
  - `robots.txt`
  - `security.txt`
  - `.plan`

- **`pics/`**
  - `template.html` — placeholder for a custom some.pics template (currently empty)

- **`statuslog/`**
  - `bio.md` — Statuslog bio content
  - `custom.css` — custom CSS for Statuslog
  - `head.html` — custom `<head>` markup for Statuslog

- **`.github/workflows/`**
  GitHub Actions workflows for automatic syncing:
  - `sync-weblog.yml` — syncs weblog config and templates
  - `sync-profile.yml` — syncs profile content, CSS, and head HTML
  - `sync-now.yml` — syncs /now page
  - `sync-pastes.yml` — syncs paste files
  - `sync-statuslog.yml` — syncs Statuslog bio, CSS, and head HTML

- **`docs/`**
  Notes/reference docs I keep alongside the config

- **`scripts/`**
  - `key-generator.sh` — interactive script to generate public/private keys for omg.lol (runs locally; never commit generated private keys)

## How to apply changes

### Automatic (everything!)

All content auto-syncs when you push to the respective directories:

| Directory | Triggers | What Syncs |
|-----------|----------|------------|
| `web/` | Profile workflow | Profile content, CSS, and head HTML |
| `web/now.md` | Now page workflow | /now page content |
| `weblog/` | Weblog workflow | Configuration and all templates |
| `paste/` | Paste files workflow | humans.txt, robots.txt, security.txt, .plan |
| `statuslog/` | Statuslog workflow | Bio, CSS, and head HTML |

Each directory has its own GitHub Actions workflow in `.github/workflows/` that handles syncing via the omg.lol API.

### Manual (externally hosted files only)

- **weblog.css stylesheet**
  - Upload `weblog/weblog.css` to https://brennan.paste.lol/stylesheet.css (this is hosted externally, not on omg.lol)

### Setup

The workflows require an API key stored as a GitHub secret:

1. Go to your repo's **Settings** → **Secrets and variables** → **Actions**
2. Add a secret named `OMG_LOL_API_KEY` with your omg.lol API key
3. Push changes and workflows will run automatically!

## License

MIT (see `LICENSE`).
