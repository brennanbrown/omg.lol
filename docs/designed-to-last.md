# A Manifesto for Preserving Content on the Web 

## This Page is Designed to Last 

### By [Jeff Huang](https://jeffhuang.com/), published 2019-12-19, updated 2021-08-24 

## Core Principles

**Keep it simple and maintainable.** Design for someone who won't constantly update their tech stack—a "casual maintainer" who wants their content accessible for 10+ years.

## Technical Guidelines

**Use vanilla HTML/CSS.** Modern CSS (Flexbox, Grid) eliminates most needs for JavaScript libraries. Skip jQuery, Bootstrap, and complex frameworks. Write clean HTML that validates and works across browsers without polyfills.

**Don't minify your code.** Compressed HTML saves minimal bandwidth (gzip handles that) but adds build complexity and hides your code from learners who view source. Keep it readable.

**Favor single-page design.** One `index.html` file is far easier to track than multiple linked pages. Embrace vertical scrolling. For archiving old versions, use dated filenames like `index.20191213.html`.

**Self-host everything.** Download and host all external resources—images, stylesheets, fonts, scripts. Hotlinking creates dependencies that break when external sites change or disappear. This includes analytics; use server logs instead of Google Analytics.

**Use system fonts.** Stick to the 13 web-safe fonts or system font stacks. Custom fonts add complexity and loading issues. Your content matters more than typography.

**Aggressively compress images.** Smaller files load faster and archive easier. Optimize JPEGs, losslessly compress PNGs, minify SVGs. Keep total site size minimal—remember that bandwidth costs real money for users.

**Monitor uptime religiously.** Use two independent monitoring services so if one fails, the other alerts you. Services shut down over decades, so redundancy matters.

## The Goal

Create content that can survive 10-30 years with minimal intervention, making it easier for both you to maintain and others to archive.
This page is [designed to last](http://jeffhuang.com/designed_to_last/).