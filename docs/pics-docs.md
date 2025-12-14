# Picture Sharing 

Updated 6 days ago

---

You've got beautiful pictures that you want to share, and we've got a place for you to share them. A match made in visual heaven! 

Our picture sharing service, [some.pics](https://some.pics/), does two things: 

1. Makes it easy to share your favorite pictures on the internet.
2. Offers a way to add pictures to your weblog.lol site. 

## Features 

The focus is on simple public image sharing. If you want to put a picture on the internet and let people see it, this is the service for you! If you need privacy or want to limit who can see your pictures, this is _not_ the service for you. The core intention of the service is to make it easy to share pictures with ease. 

## What it isn't 

* It's not a general cloud photo storage solution.
* It's not a place to backup or store an entire photo library.
* It's not really intended for sharing transient screenshots or other temporary/throwaway stuff. 

## How it works 

* You can upload pictures up to 8 MB in size, in any of these formats: GIF, HEIC, JPG, PNG, SVG, and WEBP.
* All images need to have a description (for alt text) to be shared publicly.
* We'll generate a lower-res preview image to display on the landing page, but the full un-messed-with version of your uploaded picture will be shown on the picture's individual page.
* We strip all geolocation metadata from the EXIF of all uploaded pictures. 

## Community Guidelines 

Please note that our guidelines will evolve as the service matures. What you see below was last updated on February 23, 2023\. 

* Our [Code of Conduct](https://home.omg.lol/info/code-of-conduct) applies here (as well as everywhere else on omg.lol).
* We're passionate about accessibility, so all pictures must have a description. These descriptions are how some people will "see" your pictures, so you shouldn't half-ass them! [Learn how to write good image descriptions](https://supercooldesign.co.uk/blog/how-to-write-good-alt-text).
* In general, we'd like to try to keep things family-friendly around here. That doesn't mean that everything you share has to be squeaky clean or get a nod from Ned Flanders, but it does mean that we're going to moderate content and may remove things that run far astray (illegal content, gratuitous explicit sexual content, content that promotes drug use or self-harm, etc.). To be clear, most artistic nudity is fine. If you could see it on European television, it's probably going to be OK here.
* You can share other people's content here if it's licensed or you have permission. If someone doesn't want you to share their content here, please don't do it. Copyright violations put our service in legal jeopardy, and that's not cool. 

We appreciate you keeping these guidelines in mind when sharing pictures. 

## Customizing your page 

There's a simple template system that you can use to customize your some.pics page, if you'd like. To get started, head over to the "Pics" section of your omg.lol address, and then click the "Edit your template" button. 

The [default template](https://adam.paste.lol/some.pics.template.txt) is what powers all some.pics pages currently, and also serves as a convenient reference for customizing your own template. 

The template itself is an HTML page, so as long as you know your way around HTML (and maybe CSS or some JS), you should feel mostly at home. There are two unique elements to it, though: **variables** and **conditionals**. We'll dive into those now. 

### Variables 

Template variables are the things you see in curly braces, like `{title}`. Each of these will be swapped with an appropriate value when your some.pics page is loaded. Here's the full list of template variables that you can use: 

* `{title}` is a dynamically generated page title
* `{description}` is your picture's description, in plaintext
* `{description-markdown}` will render any Markdown in your picture's description to HTML (so you can use this where you'd want to show fully marked-up stuff on your page, whereas the regular `{description}` is better suited for page metadata to avoid any HTML conflicts)
* `{alt}` is your picture's alt text (which defaults to the description text if no separate alt text was provided)
* `{preview-image-url}` is the URL to a preview image for your picture
* `{domain}` is the domain for your some.pics page (if you've configured a custom domain for your some.pics page on the Switchboard, it will be used here)
* `{tag-header}` is a marked up header for picture tags
* `{picture-page-url}` is a dynamically generated URL to an individual picture's page
* `{picture-url}` is a dynamically generated URL to a picture file (not its page, but the raw media directly)
* `{address}` is a marked-up version of your omg.lol address (also converted to emoji if you have a Punycode/emoji address)
* `{address-raw}` is the plaintext version of your address
* `{file-format}` is the file format of your picture (e.g. JPG, PNG, etc.)
* `{camera-model}` is the camera model used to capture your picture (from the picture's EXIF data)
* `{width}` is the width of the picture in pixels
* `{height}` is the height of the picture in pixels
* `{exif}` is a table of EXIF data for the picture
* `{tags}` is a list of tags associated with the picture
* `{relative-timestamp}` is a relative timestamp of when the picture was uploaded to some.pics (e.g. "four days ago") 

These variables can be used anywhere in your template, though some may only work in the correct context (i.e. whether you're viewing your landing page or an individual picture page). More on that below, where we cover **conditionals**. 

### Conditionals 

There are two kinds of pages that exist in some.pics: landing pages and picture pages. Your landing page lists all of your shared pictures (the default is the grid of pictures), and picture pages are what you see when you click on a picture from your landing page (picture pages are individual pages for each picture). 

To keep things simple, we use a single template to cover both of these pages (since most people want to have a consistent visual appearance regardless of the page type). But to account for the unique differences between the two page types, we need a way to say "if we're on a landing page do _this_, but if we're on a picture page do _something else_". And that's where conditionals come in. 

In the template, you'll notice two types of conditionals: 
    
    <!-- if:landing --> ... <!-- endif:landing --> <!-- if:picture --> ... <!-- endif:picture --> 

These do pretty much exactly what you think they do. Anything between the `if` and `endif` applies to that specific condition, either being a landing page or a picture page. Those are the places where you can do unique things for each page type. 

There's one final special thing that happens in the landing page conditional, which looks like this: 
    
    <!-- foreach:picture --> ... <!-- endforeach:picture --> 

This is a "for each loop", which basically says "for every picture, do _this_". This is how you can generate a list (or grid, or some other creative thing) of your pictures on your landing page. This only works in the landing page conditional because that's the only place where it makes sense to show more than one picture. 

If you ever run into any issues working with your template or just get stuck and need a hand, feel free to [reach out](https://home.omg.lol/info/contact) any time!