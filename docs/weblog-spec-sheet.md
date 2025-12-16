# Weblog.lol Site Architecture Specification

## Design Philosophy: Brutalist Web Design Principles

**Core Tenets:**
- Content is paramount; raw and unfiltered presentation
- Functionality over aesthetics
- Honest use of web materials (HTML, CSS)
- Minimal JavaScript (only when absolutely necessary)
- Truth to materials: what you see is what you get
- Fast loading, accessible, and straightforward navigation
- Embrace system defaults where appropriate (form elements, browser features)
- No unnecessary decoration or ornamentation

**Visual Language:**
- Monospace or sans-serif fonts (system fonts preferred)
- High contrast color schemes (black/white primary, strategic accent colors)
- Visible borders, exposed structure
- Large, bold typography for hierarchy
- Blue underlined links (honest hyperlinks)
- Minimal to no images unless serving content purpose
- Grid-based or asymmetric layouts that reveal structure
- No smooth animations (instant state changes acceptable)

---

## HOMEPAGE ARCHITECTURE

### 1. NAVIGATION BAR (Sticky Header)

**Desktop Layout:**
```
┌─────────────────────────────────────────────────────────────────┐
│ [SITE TITLE/LOGO]           [Home] [Now] [About] [Archive]     │
│                              [Pages] [Blogroll] [Contact] [RSS] │
└─────────────────────────────────────────────────────────────────┘
```

**Mobile Layout (< 768px):**
- Same structure, but navigation wraps to multiple lines
- Font-size scales down from 16px to 14px
- No hamburger menu (against brutalist principles)
- All links remain visible and accessible

**Implementation Details:**
- Sticky positioning (`position: sticky; top: 0;`)
- Background: solid color (white or black) with full opacity
- Bottom border: thick solid line (3-5px)
- Links: default browser link styling or high-contrast custom
- Hover state: underline, background color change, or bold
- Each nav item prefixed with simple text icon or symbol:
  - Home: [↖]
  - Now: [◐]
  - About: [i]
  - Archive: [□]
  - Pages: [≡]
  - Blogroll: [∞]
  - Contact: [@]
  - RSS: [⚡]

**Configuration:**
```
Navigation: /, now, about, archive, pages, blogroll, contact, [RSS](feed.xml)
```

---

### 2. MAIN CONTENT AREA

**Desktop Layout (two-column):**
```
┌────────────────────────────────┬───────────────────────────┐
│                                │                           │
│  MAIN (70% width)              │  SIDEBAR (30% width)      │
│                                │                           │
│  [Recent Posts]                │  [About Blurb]            │
│  [Post 1]                      │  [Blogroll]               │
│  [Post 2]                      │  [Webrings]               │
│  [Post 3]                      │  [Support]                │
│  [...]                         │  [Stats]                  │
│                                │  [88x31 Badges]           │
│                                │                           │
└────────────────────────────────┴───────────────────────────┘
```

**Mobile Layout (< 768px):**
```
┌─────────────────────────┐
│ MAIN (100% width)       │
│ [Recent Posts]          │
│ [Post 1]                │
│ [Post 2]                │
│ [Post 3]                │
├─────────────────────────┤
│ SIDEBAR (100% width)    │
│ [About Blurb]           │
│ [Blogroll]              │
│ [Webrings]              │
│ [Support]               │
│ [Stats]                 │
│ [88x31 Badges]          │
└─────────────────────────┘
```

#### MAIN CONTENT SECTION

**Recent Posts List:**
- **Post Entry Structure:**
  ```
  ════════════════════════════════════════
  
  [POST TITLE]
  
  YYYY-MM-DD • [TAG1] [TAG2] [TAG3]
  
  [Excerpt: first 200-300 characters...]
  
  → [Read More]
  
  ════════════════════════════════════════
  ```

- **Typography:**
  - Post titles: `<h2>`, large bold, black
  - Date/metadata: monospace font, smaller size, gray
  - Tags: inline, bracketed, linkable
  - Excerpt: regular body text
  - "Read More": styled as clear link or button

- **Spacing:**
  - Generous vertical rhythm (2-3rem between posts)
  - Clear visual separation (horizontal rules or thick borders)

- **Pagination:**
  - Bottom of list: `[← Older Posts] [1] [2] [3] [4] [Newer Posts →]`
  - Simple text links, no fancy controls
  - Current page: bold or different background

---

#### SIDEBAR SECTION

**Module Order (top to bottom):**

**1. ABOUT BLURB**
```
┌─────────────────────────┐
│ ┌───────────────────┐   │
│ │   [PROFILE PIC]   │   │
│ │   (optional)      │   │
│ └───────────────────┘   │
│                         │
│ [YOUR NAME]             │
│ ─────────────           │
│                         │
│ Short bio (2-4 lines)   │
│ describing who you are  │
│ and what this blog is.  │
│                         │
│ → [More About Me]       │
└─────────────────────────┘
```
- Profile picture: square, bordered, max 150px
- Name: bold, larger font
- Bio: concise, honest, personal
- Link to full /about page

---

**2. BLOGROLL**
```
┌─────────────────────────┐
│ BLOGROLL                │
│ ────────────────────    │
│                         │
│ • [Site Name 1]         │
│ • [Site Name 2]         │
│ • [Site Name 3]         │
│ • [Site Name 4]         │
│ • [Site Name 5]         │
│                         │
│ → [Full Blogroll]       │
└─────────────────────────┘
```
- List 5-7 top links
- Simple bullet list format
- Plain text + hyperlinks
- Link to dedicated /blogroll page
- Consider adding RSS indicator (⚡) next to each

---

**3. WEBRINGS**
```
┌─────────────────────────┐
│ WEBRINGS                │
│ ────────────────────    │
│                         │
│ [◄] [Ring Name 1] [►]   │
│ [◄] [Ring Name 2] [►]   │
│                         │
│ Member of:              │
│ • [Webring Name]        │
│ • [Another Ring]        │
└─────────────────────────┘
```
- Active prev/next navigation for each ring
- Text-based navigation (brutalist approach)
- Optional: small badge images if they exist
- Links open in same tab (respect back button)

---

**4. SUPPORT**
```
┌─────────────────────────┐
│ SUPPORT THIS BLOG       │
│ ────────────────────    │
│                         │
│ Enjoy this content?     │
│ Help keep it going:     │
│                         │
│ [☕ Ko-fi]              │
│ [♥ Patreon]             │
│                         │
└─────────────────────────┘
```
- Simple, non-intrusive ask
- Text links with emoji/symbol prefix
- No fancy buttons or widgets
- Brief, honest copy

---

**5. SITE STATS**
```
┌─────────────────────────┐
│ SITE STATS              │
│ ────────────────────    │
│                         │
│ Posts: 127              │
│ Pages: 12               │
│ Words: 89,432           │
│ Est: 2023               │
│ Last: 2024-12-14        │
│                         │
└─────────────────────────┘
```
- Plain text, monospace font
- Key metrics only
- No fancy counters or animations
- Static data (updated on build)

---

**6. 88x31 BADGES**
```
┌─────────────────────────┐
│ BADGES                  │
│ ────────────────────    │
│                         │
│ [IMG] [IMG] [IMG]       │
│ [IMG] [IMG] [IMG]       │
│ [IMG] [IMG] [IMG]       │
│                         │
└─────────────────────────┘
```
- Grid layout, 3 columns
- Standard 88x31px badge images
- Each badge is a link
- Includes: browsers, standards, services, political badges
- Examples: HTML5, CSS3, RSS, "Best Viewed With Eyes", etc.

---

**7. SOCIAL LINKS**
```
┌─────────────────────────┐
│ ELSEWHERE               │
│ ────────────────────    │
│                         │
│ @ [Mastodon]            │
│ @ [GitHub]              │
│ @ [Email]               │
│                         │
└─────────────────────────┘
```
- Simple list format
- Text links only (no icon fonts)
- Use text symbols or just words
- `rel="me"` for verification

---

### 3. FOOTER

**Full-width footer across bottom:**

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│ ═══════════════════════════════════════════════════════════════ │
│                                                                 │
│ [SITE NAME] © 2023-2024                                        │
│                                                                 │
│ Content licensed under [CC BY-SA 4.0]                          │
│ Code/Design by [Your Name]                                     │
│                                                                 │
│ Links: [Sitemap] • [RSS] • [Source] • [Colophon] • [Contact]  │
│                                                                 │
│ Built with weblog.lol • Made with love in [Location]          │
│ Last updated: 2024-12-14                                       │
│                                                                 │
│ [88x31 "Made with Notepad" badge] [Valid HTML badge]          │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

**Elements:**
- **Copyright**: Clear, honest statement
- **License**: Prominent Creative Commons link/badge
- **Attribution**: Who made it, tools used
- **Quick Links**: Essential site navigation
- **Meta info**: Build info, last update
- **Badges**: Small web pride badges
- **Separator**: Heavy horizontal rule at top

---

### 4. "RETURN TO TOP" BUTTON

**Desktop:**
```
Fixed bottom-right corner:

┌────────────────────────────┐
│                      ┌───┐ │
│                      │ ↑ │ │
│                      │TOP│ │
│                      └───┘ │
└────────────────────────────┘
```

**Implementation:**
- `position: fixed; bottom: 20px; right: 20px;`
- Simple bordered box
- Text: "↑ TOP" or just "↑"
- Appears only after scrolling down 300px (optional JS)
- Plain CSS, no smooth scroll (instant jump)
- On mobile: smaller, bottom-right, doesn't obstruct content

**CSS-only alternative:**
- Always visible
- No JavaScript required
- Simple `<a href="#top">` link

---

## RESPONSIVE BREAKPOINTS

**Desktop (> 768px):**
- Main: 70% width
- Sidebar: 30% width
- Side-by-side layout
- Larger fonts (16-18px body)

**Tablet (480px - 768px):**
- Main: 100% width
- Sidebar: 100% width (stacked below)
- Font size: 14-16px

**Mobile (< 480px):**
- Single column
- Font size: 14px
- Reduced padding/margins
- Navigation wraps naturally

---

## TYPOGRAPHY SCALE

**System Font Stack:**
```css
font-family: 'Courier New', Courier, monospace; /* for code/meta */
font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Arial, sans-serif; /* for body */
```

**Sizes:**
- Body: 16px (desktop), 14px (mobile)
- H1: 2.5rem (40px)
- H2: 2rem (32px)
- H3: 1.5rem (24px)
- Small/meta: 0.875rem (14px)
- Navigation: 1rem (16px) → 0.875rem (14px mobile)

**Line Height:**
- Body: 1.6
- Headings: 1.2

---

## COLOR PALETTE

**Option 1: High Contrast Black/White**
- Background: #FFFFFF
- Text: #000000
- Links: #0000EE (browser blue)
- Visited: #551A8B (browser purple)
- Borders: #000000
- Accent: #FF0000 (for important elements)

**Option 2: Terminal Style**
- Background: #000000
- Text: #00FF00 (green)
- Links: #00FFFF (cyan)
- Borders: #00FF00
- Accent: #FFFF00 (yellow)

**Option 3: Brutalist Gray**
- Background: #F5F5F5
- Text: #1A1A1A
- Links: #0000EE
- Borders: #333333
- Accent: #FF4500

---

## HTML/CSS IMPLEMENTATION NOTES

**Core Technologies:**
- Semantic HTML5
- CSS Grid for main layout
- Flexbox for navigation and smaller components
- No CSS frameworks (write custom)
- Minimal or zero JavaScript
- Progressive enhancement

**Accessibility:**
- Semantic HTML throughout
- Proper heading hierarchy
- Alt text on all images
- High contrast ratios
- Keyboard navigable
- Screen reader friendly

**Performance:**
- No external CSS frameworks
- Minimal custom CSS (~200-300 lines)
- No JavaScript libraries
- Inline critical CSS
- Lazy load images (if any)
- Total page weight: < 100KB

---

## CONFIGURATION FILE ADDITIONS

```
# Visual Settings
Weblog title: [Your Blog Name]
Author: [Your Name]
Weblog description: [Your tagline/description]
Timezone: America/Los_Angeles

# Navigation
Navigation: /, now, about, archive, pages, blogroll, contact, [RSS](feed.xml)

# URL Structure
Post path format: /Y/m/

# Date Format
Date format: Y-m-d
```

---

## CONTENT NOTES

**Post Best Practices:**
- Write in plain, honest language
- No clickbait titles
- Clear, descriptive headings
- Generous paragraph spacing
- Lists and code blocks as needed
- Minimal images (only when necessary)
- External links clearly marked

**Page Types:**
- Standard pages (About, Contact, etc.)
- List pages (Archive, Blogroll)
- Index pages (Tags, Categories if applicable)
- Static reference pages (/now, /uses, etc.)

---

This specification prioritizes function over form, embraces honest web materials, and creates a fast, accessible, and maintainable personal weblog that stands in opposition to the homogenized web while remaining deeply usable.