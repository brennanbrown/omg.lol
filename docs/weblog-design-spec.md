# Weblog Design Specification

## Project Overview

A simple, cozy diary-style personal blog built on weblog.lol with a focus on accessibility, longevity, and brutalist design principles. This is not intended to be an all-encompassing site (that's brennan.day), but rather a comfortable space for personal, diary-style writing.

---

## Design Philosophy

### Core Principles
- **Content First**: Prioritize readability and user experience over decorative elements
- **Brutalist Web Design**: Honest, transparent design that serves content without vanity
- **Designed to Last**: Simple, maintainable code that will work for 10+ years
- **Accessibility**: A11y-friendly design that works for everyone
- **Lightweight**: Fast loading, minimal dependencies, respectful of users' bandwidth

### Technical Approach
- Vanilla HTML/CSS with minimal JavaScript
- Semantic HTML5 elements used properly
- Modern CSS features (Grid, Flexbox) for layout
- Self-hosted resources (no external dependencies)
- System fonts for reliability and performance

---

## Visual Design

### Color Scheme: Gruvbox

```css
:root {
  /* Light mode */
  --bg: #fbf1c7;
  --fg: #3c3836;
  --bg-alt: #ebdbb2;
  --fg-alt: #665c54;
  --primary: #458588;
  --secondary: #b16286;
  --accent: #d79921;
  --border: #d5c4a1;
  
  /* Dark mode */
  --bg-dark: #282828;
  --fg-dark: #ebdbb2;
  --bg-alt-dark: #3c3836;
  --fg-alt-dark: #d5c4a1;
  --primary-dark: #83a598;
  --secondary-dark: #d3869b;
  --accent-dark: #fabd2f;
  --border-dark: #665c54;
}
```

### Typography
- **Primary**: System UI font stack for maximum compatibility
- **Headings**: Slightly larger, weighted text with clear hierarchy
- **Body**: 1.1rem line height for readability
- **Code**: Monospace stack with distinct styling

### Layout Structure
- **Mobile-first responsive design**
- **Max-width content**: 720px for optimal reading
- **Flexible navigation**: Adapts to screen size
- **Consistent header/footer**: Present on all pages

---

## Template Structure

### 1. Landing Page Template
- Header with site title and navigation
- Site blurb section (below nav)
  - Brief description of the blog's purpose
  - Link to main blog (brennan.day)
- Recent posts list (10 posts per page)
- Pagination controls
- Footer with social links

### 2. Post Template
- Article wrapper with semantic HTML5
- Large post title (h1)
- Metadata section (date, tags)
- Post body content
- Previous/next navigation
- Footer

### 3. Page Template
- Similar to post but without date/tags
- Clean, focused layout for static content
- Optional table of contents for long pages

### 4. Main Template (individual post view)
- Full post content
- Metadata display
- Recent posts sidebar/section
- Footer

---

## Navigation Design

### Header Navigation
```html
<header>
  <nav>
    <div class="nav-left">
      <a href="/">Home</a>
    </div>
    <div class="nav-right">
      <a href="/about">About</a>
      <a href="/archive">Archive</a>
      <a href="/rss">RSS</a>
    </div>
  </nav>
</header>
```

### Behavior
- **Desktop**: Home link on left, other links on right
- **Mobile**: Hamburger menu or stacked layout
- **Sticky**: Navigation stays visible while scrolling
- **Accessible**: Proper ARIA labels, keyboard navigation

---

## Footer Design

### Single Row Layout
```html
<footer>
  <nav class="footer-links">
    <a href="https://brennan.omg.lol" aria-label="omg.lol">
      <i class="fas fa-laptop"></i>
    </a>
    <a href="mailto:brennan@omg.lol" aria-label="Email">
      <i class="fas fa-envelope"></i>
    </a>
    <a href="https://brennan.day" aria-label="Main weblog">
      <i class="fas fa-blog"></i>
    </a>
    <a href="https://brennan.some.pics/" aria-label="Photo gallery">
      <i class="fas fa-image"></i>
    </a>
    <a href="https://brennan.social.lol" aria-label="Mastodon">
      <i class="fab fa-mastodon"></i>
    </a>
    <a href="https://source.tube/brennan" aria-label="Source code">
      <i class="fas fa-git"></i>
    </a>
    <a href="https://brennan.paste.lol" aria-label="Pastebin">
      <i class="fas fa-paste"></i>
    </a>
  </nav>
</footer>
```

### Styling
- Icons only, no text (tooltips on hover)
- Even spacing between links
- Responsive: wraps on smaller screens
- Subtle hover effects

---

## Content Display

### Post Listings
- **Title**: Large, clickable
- **Date**: Human-readable format (e.g., "January 6, 2026")
- **Excerpt**: First paragraph or custom excerpt
- **Tags**: Small, clickable badges
- **Pagination**: Clear "Older/Newer" buttons

### Individual Posts
- **Title**: Prominent h1 at top
- **Metadata**: Date, reading time, tags
- **Body**: Clean typography with proper spacing
- **Navigation**: Previous/next post links at bottom

### Typography Scale
```css
h1 { font-size: 2.5rem; }  /* Post titles */
h2 { font-size: 2rem; }   /* Section headers */
h3 { font-size: 1.5rem; } /* Subsections */
p  { font-size: 1.1rem; } /* Body text */
```

---

## Accessibility Features

### Semantic HTML
- Proper heading hierarchy (h1-h6)
- `<main>`, `<header>`, `<footer>`, `<nav>`, `<article>` tags
- `<time>` element for dates
- ARIA labels where needed

### Keyboard Navigation
- Visible focus indicators
- Logical tab order
- Skip to content link
- Accessible menu patterns

### Visual Accessibility
- Sufficient color contrast (WCAG AA)
- Text resizable to 200%
- Works without CSS (content still readable)
- Alt text for all images

---

## Performance Optimization

### Loading Strategy
- CSS in `<head>` (critical path)
- Minimal JavaScript (progressive enhancement)
- Optimized images (WebP with fallbacks)
- HTTP/2 ready

### File Size Targets
- CSS: < 10KB gzipped
- Total page weight: < 100KB
- Load time: < 2 seconds on 3G

---

## Configuration Settings

### weblog.lol Config
```yaml
Weblog title: brennan's diary
Weblog description: A cozy corner for personal thoughts and diary entries
Author: Brennan Brown
Timezone: America/Edmonton
Date format: F j, Y
Post path format: /
Navigation: about, archive, [RSS](/rss)
Posts per page: 10
```

### Custom CSS Variables
- Easy color customization
- Adjustable font sizes
- Flexible spacing system
- Dark mode support

---

## Implementation Checklist

### Templates
- [ ] Landing page with blurb
- [ ] Post template with metadata
- [ ] Page template for static content
- [ ] Main template for individual posts
- [ ] Archive page for all posts

### Styles
- [ ] Gruvbox color scheme
- [ ] Responsive navigation
- [ ] Footer with icon links
- [ ] Typography system
- [ ] Dark mode support

### Features
- [ ] Pagination (10 posts)
- [ ] Tag system
- [ ] RSS feed
- [ ] Search functionality (if available)
- [ ] Accessibility testing

### Testing
- [ ] Validate HTML
- [ ] Validate CSS
- [ ] Screen reader testing
- [ ] Keyboard navigation
- [ ] Mobile responsiveness
- [ ] Performance audit

---

## Future Considerations

### Content Strategy
- Focus on personal, diary-style posts
- Cross-post to main blog for important content
- Regular but not mandatory posting schedule
- Emphasis on authenticity over polish

### Maintenance
- Regular backups of content
- Monitor for broken links
- Update dependencies (minimal)
- Periodic accessibility audits

### Evolution
- Add features only if they serve content
- Maintain simplicity as core value
- Preserve backward compatibility
- Document any customizations
