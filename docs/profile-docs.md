Our web editor offers a unique Markdown-based approach to managing your profile page. Your profile page is essentially a Markdown document, making it easy to add content and rearrange things however you wish. 

## Profile or Web pages 

The web editor can be used to edit and publish [Profile](https://home.omg.lol/info/profiles) pages (with the aforementioned Markdown document approach), or to manage a simple web page (just set your **Page type** to **Raw HTML only**). 

## Profile Metadata 

The web editor uses a custom process for defining and including profile metadata, intended to preserve the beauty of the underlying Markdown document. You can define a metadata block like this: 
    
    | Pronouns: they/them | Occupation: Seed Preservationist | Location: Svalbard 

Each line above is its own _metadata item_, which is in turn rendered into HTML with a "metadata" class and a unique ID to aid in page styling and structure. For example, the metadata block above would be rendered into HTML as: 
    
    <div class="metadata" id="pronouns">they/them</div> <div class="metadata" id="occupation">Seed Preservationist</div> <div class="metadata" id="location">Svalbard</div> 

Certain metadata items also receive icons automatically, and you can add your own icons to your own custom metadata. For example, if you wanted to share that you have a 2300 rating in Chess, you might add `{chess}` to use the [chess icon](https://fontawesome.com/icons/chess?s=solid&f=classic). Like this: 
    
    | Chess Rating: 2300 {chess} 

## Profile Sections 

Sections can be added to pages with a special section indicator, like this: 
    
    --- Bio --- 

This would be rendered as: 
    
    <div id="bio"> ... </div> 

The contents of this `<div>` would consist of whatever comes after the section indicator, up to the end of the document or the start of another section indicator. (As such, it's not possible to nest sections... yet.) 

## Profile Items 

If you have a `--- Profile Items ---` section indicator in your profile document, you'll create a special section that intelligently applies icons to whatever lists to include within that section. Learn more about how this works in our [Profile Items](https://home.omg.lol/info/profile-items) article.  (See below.)

## Profile Picture 

Your profile picture will be rendered wherever the `{profile-picture}` tag is placed within your document. 

## Custom Metadata 

You can fill in the custom metadata fields to define a page title and description (or leave them blank and we'll do it for you). 

## Custom CSS 

Specify any amount of custom CSS you'd like. You can get creative here and really transform the entire look and feel of your page! 

## Custom `<head>` content 

Need to put some custom elements in your page head? Go for it!

# Profile Items 

Updated 3 years ago

---

One of the best parts of an [omg.lol profile](https://home.omg.lol/info/profiles) is the total flexibility you have in adding and managing your profile items. 

Your profile items can be just about anything: plain text, a link to something (like a personal website or a social media profile), or whatever. Add as many as you'd like! You can re-order them any time. 

## Adding items 

* Just insert a new Markdown list item (starting with `-`) within the `--- Profile Items ---` section of your page. 

## Using Markdown 

Markdown is supported, so you can format text or add links as you see fit. For example, you can add a link with custom text like this: 
    
    [My awesome link text](https://myawesomesite.example.com) 

Setting links to be opened in a new tab (i.e., `target="_blank"`) can be achieved by appending `⧉` to the end of the link markdown, like this: 
    
    [This opens in a new tab](https://example.com)⧉ 

## Linking to social profiles or other sites 

When you link to a known social profile or website, we'll try to clean up the display of that link for you by showing a nice icon and your username (taken from the URL). If you're not seeing a certain icon that you're expecting, [get in touch](https://home.omg.lol/info/contact) or [add an icon request on GitHub](https://github.com/neatnik/omg.lol/issues/new?assignees=&labels=icon&template=icons.yml&title=%5BIcon%5D+) and we'll add it for you. 

## Special Items 

* {snowfall} will make it snow on your profile.
* {norelme} will disable the global default `rel="me"` attribute applied to all profile page links. 

## Keys 

You can easily share your [cryptographic public keys](https://home.omg.lol/info/keys) on your profile. These key types are supported: 

* `{pgp-key}` for your PGP key
* `{ssh-key}` for your SSH key
* `{age-key}` for your age key
* `{cosign-key}` for your Cosign key
* `{minisign-key}` for your Minisign key 

## Choosing icons 

If you'd like to have a specific icon appear on a profile item, just use an icon tag, like this: `{cat}`. Put it at the end of the line, and when your profile is published, the tag will be removed and the icon will be applied. You can use any icon in the [Font Awesome free set](https://fontawesome.com/search?m=free&o=r), as well as any of the [custom omg.lol icons](https://omgalol.cache.lol/profiles/icons/omg.lol-icons.html). 

For example: 

* ` - https://instagram.com/foobar` will show the Instagram icon by default
* ` - https://instagram.com/foobar {cat}` will show the cat icon (useful for Instagram feeds dedicated to your cat)