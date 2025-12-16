# omg.lol

This repo is a version-controlled “source of truth” for my **omg.lol** address configuration.

**Weblog changes now auto-sync via GitHub Actions!** When you push changes to the `weblog/` directory, they're automatically deployed to omg.lol.

For other content (profile, now page, paste files), the process is still manual:

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

- **`docs/`**
  Notes/reference docs I keep alongside the config. In particular:
  - `spec-sheet.md` — a spec for future GitHub Actions syncing (not implemented here)

- **`scripts/`**
  - `key-generator.sh` — interactive script to generate public/private keys for omg.lol (runs locally; never commit generated private keys)

## How to apply changes

### Automatic (weblog only)

Push any changes to the `weblog/` directory to automatically sync:
- Configuration (`config.yml`)
- All templates (landing page, main, page, post)

The GitHub Actions workflow (`.github/workflows/sync-weblog.yml`) handles this via the omg.lol API.

### Manual (everything else)

- **omg.lol profile page**
  - Copy/paste `web/main.md` into the omg.lol web editor
  - Copy/paste `web/custom.css` into the custom CSS field
  - Copy/paste `web/head.html` into the custom `<head>` field

- **/now page**
  - Copy/paste `web/now.md` into the Now editor (or use the API manually)

- **weblog.css stylesheet**
  - Upload `weblog/weblog.css` to https://brennan.paste.lol/stylesheet.css

- **Paste "special files"**
  - Create pastebin entries matching the filenames in `paste/` (see `paste/special-pastes.md`)

## License

MIT (see `LICENSE`).
