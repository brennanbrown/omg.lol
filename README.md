# omg.lol

This repo is a version-controlled “source of truth” for my **omg.lol** address configuration.

There’s no build step and no automation here (yet). The goal is simply:

- Keep the content I paste into omg.lol editors in Git
- Make changes locally, review diffs, and then copy/paste into the relevant omg.lol UI
- Have a clean backup/history of everything

## Structure

- **`web/`**
  - `main.md` — content for my omg.lol profile page
  - `now.md` — content for my `/now` page
  - `custom.css` — custom CSS for my omg.lol profile page
  - `head.html` — custom `<head>` markup for my omg.lol profile page

- **`weblog/`**
  - `config.yml` — weblog.lol configuration
  - `landing-page-template.html` — landing page template
  - `main-template.html` — post template
  - `page-template.html` — general page template

- **`paste/`**
  These are “special paste” files served by omg.lol at well-known endpoints:
  - `humans.txt`
  - `robots.txt`
  - `security.txt`
  - `.plan`

- **`pics/`**
  - `template.html` — placeholder for a custom some.pics template (currently empty)

- **`docs/`**
  Notes/reference docs I keep alongside the config. In particular:
  - `spec-sheet.md` — a spec for future GitHub Actions syncing (not implemented here)

- **`scripts/`**
  - `key-generator.sh` — interactive script to generate public/private keys for omg.lol (runs locally; never commit generated private keys)

## How to apply changes (manual)

- **omg.lol profile page**
  - Copy/paste `web/main.md` into the omg.lol web editor
  - Copy/paste `web/custom.css` into the custom CSS field
  - Copy/paste `web/head.html` into the custom `<head>` field

- **/now page**
  - Copy/paste `web/now.md` into the Now editor (or use the API manually)

- **weblog.lol**
  - Apply settings from `weblog/config.yml` in the weblog configuration UI
  - Copy/paste templates from `weblog/*.html` into the relevant template editors

- **Paste “special files”**
  - Create pastebin entries matching the filenames in `paste/` (see `paste/special-pastes.md`)

## License

MIT (see `LICENSE`).
