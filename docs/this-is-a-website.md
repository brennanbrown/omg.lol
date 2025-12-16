Based on "This is an Actual Website," guidelines for making a static blog:

## Core Definition

**A website is hypertext documents, period.** Not an imitation of newspapers, magazines, or television. It should communicate messages meaningful to the author through linked documents.

## Fundamental Requirements

**Build with the basics first.** A proper website should:
- Fit into any screen
- Look consistent in all standards-compliant browsers
- Be accessible to people using assistive technologies
- Be navigable by hyperlinks
- Be searchable with browser's "find in page"
- Be legible and coherent
- Work without JavaScript (though a little can enhance)
- Work without CSS (but use it anyway—default browser styles are terrible)

## Technology Philosophy

**Exhaust HTML before reaching for anything else.** Modern HTML5 provides more than you might expect:
- Form validation elements
- `<picture>` for efficient image formats with fallbacks
- `<details>` and `<summary>` for accordions
- `<dialog>` for modals
- `<audio>` and `<video>` for multimedia
- `<template>` and `<slot>` for web components

**Use modern CSS features.** Grid and Flexbox solve layout problems that once required Bootstrap.

**Question your JavaScript.** Does your blog really need React? A build step? Node and 9,000+ npm packages? Who are you trying to impress?

## Practical Guidelines

**Omit needless graphics.** If your site works when you replace all images with photos of William Howard Taft, you might not need them.

**Test in text browsers.** Try Lynx. If it doesn't work there, it doesn't actually work.

**Use relative URLs.** Makes moving between hosts easier and simplifies mirroring.

**Provide RSS/Atom feeds.** People get too much email—don't force newsletter signups.

**Consider Unix tools first.** Shell scripts, GNU make, HTML-XML-utils, and rsync before locking into static site generators or npm ecosystem.

**Validate everything.** Use W3C validators for HTML, CSS, and feeds. Use JSLint for JavaScript. Do this regularly.

**Provide archives.** Offer downloadable compressed versions for offline viewing and archival.
