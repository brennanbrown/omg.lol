# omg.lol Config Sync - Project Spec Sheet

## Project Overview
Automated GitHub Actions workflow that syncs configuration files and stylesheets to omg.lol services via API whenever changes are pushed to the repository.

Status: not implemented in this repository yet (manual updates for now).

---

## Repository Structure

```
omg.lol/
├── .gitignore
├── LICENSE
├── README.md
├── docs/
│   ├── essay-on-omglol.md
│   ├── now-docs.md
│   ├── omg-icons.md
│   ├── pics-docs.md
│   ├── profile-docs.md
│   └── spec-sheet.md
├── paste/
│   ├── .plan
│   ├── humans.txt
│   ├── robots.txt
│   ├── security.txt
│   └── special-pastes.md
├── pics/
│   └── template.html
├── scripts/
│   └── key-generator.sh
├── web/
│   ├── custom.css
│   ├── head.html
│   ├── main.md
│   └── now.md
└── weblog/
    ├── config.yml
    ├── landing-page-template.html
    ├── main-template.html
    └── page-template.html
```

---

## GitHub Secrets Required

| Secret Name | Description | Where to Get It |
|-------------|-------------|-----------------|
| `OMGLOL_API_KEY` | Your omg.lol API key | https://home.omg.lol/account |
| `OMGLOL_ADDRESS` | Your omg.lol address (e.g., "yourname") | Your omg.lol username |

---

## omg.lol API Endpoints

### Profile CSS
- **Endpoint:** `https://api.omg.lol/address/{address}/web`
- **Method:** POST
- **Headers:** `Authorization: Bearer {API_KEY}`
- **Body:** `{ "css": "{css_content}" }`

### Weblog CSS
- **Endpoint:** `https://api.omg.lol/address/{address}/weblog/configuration`
- **Method:** POST
- **Headers:** `Authorization: Bearer {API_KEY}`
- **Body:** `{ "css": "{css_content}" }`

### Weblog Template (if used)
- **Endpoint:** `https://api.omg.lol/address/{address}/weblog/template`
- **Method:** POST
- **Headers:** `Authorization: Bearer {API_KEY}`
- **Body:** `{ "template": "{html_content}" }`

### Pastebin CSS
- **Endpoint:** `https://api.omg.lol/address/{address}/pastebin/custom-css`
- **Method:** POST
- **Headers:** `Authorization: Bearer {API_KEY}`
- **Body:** `{ "css": "{css_content}" }`

### Statuslog CSS
- **Endpoint:** `https://api.omg.lol/address/{address}/statuslog/configuration`
- **Method:** POST
- **Headers:** `Authorization: Bearer {API_KEY}`
- **Body:** `{ "css": "{css_content}" }`

### Now Page
- **Endpoint:** `https://api.omg.lol/address/{address}/now`
- **Method:** POST
- **Headers:** `Authorization: Bearer {API_KEY}`
- **Body:** `{ "content": "{markdown_content}" }`

---

## GitHub Actions Workflow Requirements

### Trigger Conditions
- Trigger on: `push` to `main` branch
- Only when files in specific directories change:
  - `web/**`
  - `weblog/**`
  - `paste/**`
  - `pics/**`

### Workflow Steps
1. **Checkout repository** - Get the latest code
2. **Read file contents** - Read each CSS/config file
3. **Detect changes** - Determine which files were modified (optional optimization)
4. **Sync to omg.lol** - For each service:
   - Read the file content
   - Make API call to appropriate endpoint
   - Handle success/failure
   - Log results

### Error Handling
- Catch and log API errors
- Continue syncing other files if one fails
- Exit with error code if any sync fails (for visibility)
- Include response messages in logs

### Optional Enhancements
- Only sync files that were actually changed (use git diff)
- Add a manual workflow trigger option
- Send notification on success/failure (GitHub issue comment, email, etc.)
- Validate CSS/HTML before syncing
- Create a summary comment with what was synced

---

## Implementation Notes

### Language Options
- **Bash script** - Simple, built into GitHub Actions
- **Python** - Better error handling, easier to read
- **Node.js** - Good for JSON handling
- **GitHub Actions composite action** - Reusable

### Recommended: Python or Bash
Python is probably easiest for HTTP requests and error handling.

### Example Workflow Structure (Pseudocode)
```yaml
name: Sync to omg.lol

on:
  push:
    branches: [ main ]
    paths:
      - 'web/**'
      - 'weblog/**'
      - 'paste/**'
      - 'pics/**'


jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Sync Profile CSS
        run: |
          # Read profile/profile.css
          # POST to profile API endpoint
      
      - name: Sync Weblog CSS
        run: |
          # Read weblog/weblog.css
          # POST to weblog API endpoint
      
      # ... repeat for other services
```

---

## Testing Strategy

1. **Local testing:** Test API calls locally with curl before implementing workflow
2. **Test in workflow:** Push changes to test branch first
3. **Verify on omg.lol:** Check that changes appear on your live sites
4. **Error scenarios:** Test with invalid API key, malformed CSS, etc.

---

## README Documentation Needs

- How to set up the repo (clone, add secrets)
- How the sync works (automatic on push)
- How to test locally
- How to manually trigger (if implemented)
- Troubleshooting common issues

---

## Security Considerations

- ✅ API key stored in GitHub Secrets (encrypted)
- ✅ Never commit API key to repo
- ✅ Secrets not exposed in logs
- ⚠️ Consider branch protection rules (only allow sync from main)
- ⚠️ Consider requiring PR reviews before merging to main

---

## Future Enhancements

- Web dashboard to view sync status
- Rollback capability (revert to previous version)
- Preview changes before syncing
- Multi-address support (if you have multiple omg.lol addresses)
- Sync schedule (daily sync even without changes)