---
title: Version-Controlled omg.lol: Auto-Syncing Your Entire Web Presence with GitHub Actions
published: false
description: How I built a complete CI/CD pipeline to auto-deploy my omg.lol profile, weblog, statuslog, and more using GitHub Actions and the omg.lol API
tags: github, automation, indie-web, webdev
cover_image: 
canonical_url: 
---

There's something genuinely delightful about [omg.lol](https://home.omg.lol/). For $20/year, you get a profile page, blog, Mastodon instance, email forwarding, paste hosting, URL shortening, image hosting, and more—all without surveillance capitalism or dark patterns. It's the kind of service that makes you remember when the Internet was _fun_.

But as a developer who lives in Git, I wanted more. I wanted every piece of my omg.lol presence version-controlled, with automatic deployment on push. No more copy-pasting into web UIs. No more wondering "wait, what did this look like two weeks ago?"

So I built it. My entire omg.lol ecosystem now lives in a [GitHub repository](https://github.com/brennanbrown/omg.lol) with automatic syncing via GitHub Actions. Every profile update, blog template change, status page edit—all tracked in Git, all automatically deployed.

Here's how it works.

## The Vision: One Repo to Rule Them All

The goal was simple: **everything that can be synced via the omg.lol API should automatically sync when pushed to GitHub**.

This includes:
- 🌐 **Profile page** (content, CSS, custom `<head>`)
- 📝 **Weblog** (configuration + 4 templates)
- ⏰ **Now page** (`/now` content)
- 📋 **Paste files** (humans.txt, robots.txt, security.txt, .plan)
- 💬 **Statuslog** (bio, CSS, custom `<head>`)

Each of these lives in its own directory with its own GitHub Actions workflow. Push to any directory, and it syncs automatically.

## Repository Structure

```
omg.lol/
├── .github/workflows/
│   ├── sync-profile.yml
│   ├── sync-weblog.yml
│   ├── sync-now.yml
│   ├── sync-pastes.yml
│   └── sync-statuslog.yml
├── web/
│   ├── main.md           # Profile content
│   ├── custom.css        # Profile styles
│   ├── head.html         # Custom <head>
│   └── now.md            # /now page
├── weblog/
│   ├── config.yml
│   ├── landing-page-template.html
│   ├── main-template.html
│   ├── page-template.html
│   ├── post-template.html
│   └── weblog.css        # Hosted externally
├── paste/
│   ├── humans.txt
│   ├── robots.txt
│   ├── security.txt
│   └── .plan
└── statuslog/
    ├── bio.md
    ├── custom.css
    └── head.html
```

Clean. Organized. Every file has a purpose.

## The omg.lol API: Surprisingly Complete

omg.lol has a [well-documented API](https://api.omg.lol/) that covers nearly everything you can do in the web UI. The endpoints we'll use:

- `POST /address/{address}/web` - Update profile
- `POST /address/{address}/now` - Update now page
- `POST /address/{address}/weblog/configuration` - Update weblog config
- `POST /address/{address}/weblog/template/{name}` - Update weblog templates
- `POST /address/{address}/pastebin/` - Create/update pastes
- `POST /address/{address}/statuses/bio` - Update statuslog bio

All endpoints require a Bearer token (your API key), which we'll store as a GitHub secret.

## Setting Up the API Secret

First, get your omg.lol API key from your account settings. Then add it to your GitHub repo:

1. Go to **Settings** → **Secrets and variables** → **Actions**
2. Click **New repository secret**
3. Name: `OMG_LOL_API_KEY`
4. Value: Your API key
5. Save

This lets workflows access the key via `${{ secrets.OMG_LOL_API_KEY }}` without exposing it in your code.

## Workflow 1: Profile Sync

The profile workflow is the most complex because it syncs three files simultaneously: content, CSS, and custom head HTML.

```yaml
name: Sync Profile to omg.lol

on:
  push:
    branches: [main, master]
    paths:
      - 'web/**'
  workflow_dispatch:

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Sync profile content
        run: |
          CONTENT=$(cat web/main.md)
          CSS=$(cat web/custom.css)
          HEAD=$(cat web/head.html)
          
          curl --fail-with-body --location --request POST \
            --header "Authorization: Bearer ${{ secrets.OMG_LOL_API_KEY }}" \
            --header "Content-Type: application/json" \
            "https://api.omg.lol/address/brennan/web" \
            --data "$(jq -n \
              --arg content "$CONTENT" \
              --arg css "$CSS" \
              --arg head "$HEAD" \
              '{publish: true, content: $content, css: $css, head: $head}')"
```

**Key details:**

- `paths: - 'web/**'` means the workflow only triggers on changes to the web directory
- `workflow_dispatch` lets you manually trigger it from the Actions tab
- `jq -n` constructs proper JSON from the file contents
- `--fail-with-body` shows API error messages if something goes wrong
- Replace `brennan` with your omg.lol address

## Workflow 2: Weblog Sync

The weblog requires multiple API calls: one for config, one for each template.

```yaml
name: Sync Weblog to omg.lol

on:
  push:
    branches: [main, master]
    paths:
      - 'weblog/**'
  workflow_dispatch:

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Sync weblog configuration
        run: |
          curl --fail-with-body --location --request POST \
            --header "Authorization: Bearer ${{ secrets.OMG_LOL_API_KEY }}" \
            "https://api.omg.lol/address/brennan/weblog/configuration" \
            --data-binary "@weblog/config.yml"

      - name: Sync Landing Page Template
        run: |
          curl --fail-with-body --location --request POST \
            --header "Authorization: Bearer ${{ secrets.OMG_LOL_API_KEY }}" \
            "https://api.omg.lol/address/brennan/weblog/template/landing-page-template" \
            --data-binary "@weblog/landing-page-template.html"

      - name: Sync Main Template
        run: |
          curl --fail-with-body --location --request POST \
            --header "Authorization: Bearer ${{ secrets.OMG_LOL_API_KEY }}" \
            "https://api.omg.lol/address/brennan/weblog/template/main-template" \
            --data-binary "@weblog/main-template.html"

      - name: Sync Page Template
        run: |
          curl --fail-with-body --location --request POST \
            --header "Authorization: Bearer ${{ secrets.OMG_LOL_API_KEY }}" \
            "https://api.omg.lol/address/brennan/weblog/template/page-template" \
            --data-binary "@weblog/page-template.html"

      - name: Sync Post Template
        run: |
          curl --fail-with-body --location --request POST \
            --header "Authorization: Bearer ${{ secrets.OMG_LOL_API_KEY }}" \
            "https://api.omg.lol/address/brennan/weblog/template/post-template" \
            --data-binary "@weblog/post-template.html"
```

**Template naming matters:** The API path `/weblog/template/landing-page-template` must match the template's internal `Title: Landing Page Template` metadata. Keep them consistent.

## Workflow 3: Now Page Sync

Simple and beautiful:

```yaml
name: Sync Now Page to omg.lol

on:
  push:
    branches: [main, master]
    paths:
      - 'web/now.md'
  workflow_dispatch:

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Sync now page
        run: |
          CONTENT=$(cat web/now.md)
          
          curl --fail-with-body --location --request POST \
            --header "Authorization: Bearer ${{ secrets.OMG_LOL_API_KEY }}" \
            --header "Content-Type: application/json" \
            "https://api.omg.lol/address/brennan/now" \
            --data "$(jq -n \
              --arg content "$CONTENT" \
              '{content: $content, listed: "1"}')"
```

The `listed: "1"` parameter makes your now page appear on [nownownow.com](https://nownownow.com/), Derek Sivers' directory of now pages.

## Workflow 4: Paste Files Sync

Special paste files (humans.txt, robots.txt, security.txt, .plan) need individual uploads:

```yaml
name: Sync Paste Files to omg.lol

on:
  push:
    branches: [main, master]
    paths:
      - 'paste/**'
  workflow_dispatch:

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Sync humans.txt
        run: |
          CONTENT=$(cat paste/humans.txt)
          
          curl --fail-with-body --location --request POST \
            --header "Authorization: Bearer ${{ secrets.OMG_LOL_API_KEY }}" \
            --header "Content-Type: application/json" \
            "https://api.omg.lol/address/brennan/pastebin/" \
            --data "$(jq -n \
              --arg content "$CONTENT" \
              '{title: "humans.txt", content: $content}')"

      # Repeat for robots.txt, security.txt, .plan
```

These files then become accessible at special endpoints like `brennan.omg.lol/humans.txt`.

## Workflow 5: Statuslog Sync

Statuslog can have custom bio content, CSS, and head HTML:

```yaml
name: Sync Statuslog to omg.lol

on:
  push:
    branches: [main, master]
    paths:
      - 'statuslog/**'
  workflow_dispatch:

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Sync statuslog bio
        run: |
          CONTENT=$(cat statuslog/bio.md)
          CSS=$(cat statuslog/custom.css)
          HEAD=$(cat statuslog/head.html)
          
          curl --fail-with-body --location --request POST \
            --header "Authorization: Bearer ${{ secrets.OMG_LOL_API_KEY }}" \
            --header "Content-Type: application/json" \
            "https://api.omg.lol/address/brennan/statuses/bio" \
            --data "$(jq -n \
              --arg content "$CONTENT" \
              --arg css "$CSS" \
              --arg head "$HEAD" \
              '{content: $content, css: $css, head: $head}')"
```

## The Developer Experience

Once set up, the workflow is effortless:

```bash
# Update your profile
vim web/main.md
git add web/main.md
git commit -m "Update about section"
git push

# GitHub Actions automatically syncs it to omg.lol
# Check the Actions tab to see the workflow run
```

No more:
- Opening multiple web UIs
- Copy-pasting between local files and web forms
- Wondering what changed
- Losing track of old versions

Everything lives in Git. Every change is tracked. Every deployment is automatic.

## Why This Matters

This isn't just about automation (though that's nice). It's about **ownership**.

Big Tech platforms want you dependent on their UIs, their workflows, their lock-in. They make it easy to create but hard to leave. Your data lives in their databases, accessible only through their interfaces, exportable (if at all) in formats nobody else supports.

omg.lol is different. It's [small by design](https://home.omg.lol/), built by [Adam Newbold](https://adam.omg.lol/) who isn't chasing unicorn valuations or VC money. He's just building good tools for people who care about the independent web.

And because omg.lol provides a proper API, we can treat it like infrastructure. Version-controlled infrastructure. GitOps for your personal web presence.

This is what the independent web looks like: **tools that respect you enough to let you own your workflow**.

## Performance Notes

Each workflow runs in ~30 seconds. The API calls are fast. GitHub Actions provides 2,000 free minutes per month for private repos (unlimited for public), so unless you're pushing hundreds of times daily, you'll never hit limits.

I've had zero failed deployments after dozens of pushes. The API is solid.

## Edge Cases and Gotchas

**Line endings:** If you're on Windows, configure Git to preserve Unix line endings:
```bash
git config --global core.autocrlf input
```

**Large files:** The API has reasonable size limits. Don't put megabyte-sized paste files in your repo.

**Template metadata:** Weblog template files need proper metadata at the top:
```
Type: Template
Title: Landing Page Template
```

The `Title` must match the API endpoint name exactly.

**Character encoding:** Everything should be UTF-8. The API handles it correctly, but double-check your editor settings.

## Smart Optimization: Stylesheet as a Paste

Initially, I kept `weblog.css` in the `weblog/` directory and planned to manually upload it to paste.lol whenever it changed. Then I realized: **paste.lol files are just pastes**. Why not move the stylesheet to the `paste/` directory and let it auto-sync?

```yaml
- name: Sync stylesheet.css
  run: |
    CONTENT=$(cat paste/stylesheet.css)
    
    curl --fail-with-body --location --request POST \
      --header "Authorization: Bearer ${{ secrets.OMG_LOL_API_KEY }}" \
      --header "Content-Type: application/json" \
      "https://api.omg.lol/address/brennan/pastebin/" \
      --data "$(jq -n \
        --arg content "$CONTENT" \
        '{title: "stylesheet.css", content: $content}')"
```

Now my weblog templates reference `https://brennan.paste.lol/stylesheet.css/raw`, and every CSS change auto-syncs. No exceptions. No manual steps.

This is the kind of thinking that makes automation actually work: **question every manual step**. If something feels tedious, there's probably an API endpoint for it.

## What I Can't Auto-Sync (Yet)

Some omg.lol features don't have API endpoints (or I haven't found them):

- Individual weblog **posts** (these are managed through the web UI or email)
- Profile **picture uploads** (supported, but I haven't implemented it)
- DNS records (manageable via API, but I do it rarely enough that manual is fine)
- PURL creation/management (API exists, might add this later)

For posts, I write in Markdown locally and email them to my weblog address. It's not fully automated, but it works.

## The Bigger Picture

Twenty dollars a year gets you:
- Profile page + blog + Mastodon instance
- Email forwarding + paste hosting + URL shortening
- Image hosting + code hosting + IRC + XMPP
- No ads. No surveillance. No dark patterns.

And now, with this setup, **everything is version-controlled and auto-deployed**.

This is what happens when you combine ethical services with open APIs and Git workflows. You get actual ownership. Real control. The ability to version your entire online presence like it's code (because it _is_ code).

## Get Started

1. Sign up for [omg.lol](https://home.omg.lol/referred-by/brennan) ($20/year)
2. Clone [my repo](https://github.com/brennanbrown/omg.lol) as a template
3. Add your API key as a GitHub secret
4. Update the workflows with your omg.lol address
5. Push changes and watch the magic happen

The independent web is alive. The tools exist. The community thrives.

All you have to do is join it.

---

**Brennan Kenneth Brown** is a Queer Métis author and web developer based in Calgary, Alberta. He founded [Write Club](https://writeclub.ca/), a creative collective that has raised funds for literacy nonprofits. He runs [Berry House](https://berryhouse.ca/), a values-driven studio building accessible JAMstack websites while offering pro bono support to marginalized communities.

**Find me:** [omg.lol profile](https://brennan.omg.lol) | [weblog](https://weblog.brennan.lol) | [statuslog](https://brennan.status.lol) | [Mastodon](https://social.lol/@brennan) | [GitHub](https://github.com/brennanbrown)

**Support my work:** [Ko-fi](https://ko-fi.com/brennan) | [Patreon](https://www.patreon.com/brennankbrown) | [GitHub Sponsors](https://github.com/sponsors/brennanbrown)
