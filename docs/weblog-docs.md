# Personalizing your weblog 

- [Personalizing your weblog](#personalizing-your-weblog)
  - [Configuration file basics](#configuration-file-basics)
    - [Understanding comments](#understanding-comments)
  - [What if I mess something up?](#what-if-i-mess-something-up)
  - [Personalize your weblog's title](#personalize-your-weblogs-title)
  - [Set your weblog author and description](#set-your-weblog-author-and-description)
  - [Set your weblog's timezone](#set-your-weblogs-timezone)
  - [Pages](#pages)
  - [Make your first page](#make-your-first-page)
  - [Customize your new page's URL](#customize-your-new-pages-url)
  - [A few more notes on custom locations](#a-few-more-notes-on-custom-locations)
- [Advanced Configuration](#advanced-configuration)
  - [Making links in Markdown](#making-links-in-markdown)
  - [Make a navigation menu](#make-a-navigation-menu)
  - [Date, time, and URL structures](#date-time-and-url-structures)
  - [Setting the URL structure](#setting-the-url-structure)


Now that you've written a blog post or two and familiarized yourself with Markdown a little, it's time to make your weblog a little more your own. We're going to do that by learning how to use your weblog's configuration page. 

You can find the configuration page by visiting the main weblog.lol page. To get there: 

1. Visit [https://omg.lol](https://omg.lol/).
2. Click "Dashboard".
3. If you have more than one omg.lol address, click the one you want to use. If not, move on to the next step.
4. Click "Weblog". 

Once you're there, you should see a new blog post screen. Look below the blog post's text area for a button that says "Configuration" and click it. You'll see a text area that looks a lot like the blog post editing area. Feel free to click inside that text area and look around. 

## [](https://weblog.lol/quickstart-3-personalize#content-configuration-file-basics)Configuration file basics 

weblog.lol uses what's commonly referred to as a "configuration file" to customize your weblog. If you're used to using programs with a settings window of some kind, this is a little different: You don't click buttons or check boxes to change the settings, but instead edit text. 

You might have noticed that the text you're looking at is similar to the front matter of a blog post. Front matter and the configuration file behave similarly, using pairs of setting names and values. 

For instance, similar to how you set the date in a post's front matter using the setting name `date` and a date value: 

`Date: 2013-02-10 13:45` 

... you can set your weblog's title using the setting name `Weblog name` and some text: 

`Weblog name: A Pretty Fine Weblog` 

Using the configuration file, you can: 

* Set your weblog's name.
* Set your weblog's description.
* Set your weblog's timezone.
* Change how your weblog shows the date and time. 

... and much more. 

In case you didn't notice, there's a space between the colon and the configuration value for each setting. Make sure to keep that in there. In other words: 
    
    ;; correct Weblog name: A Pretty Fine Weblog 

    ;; incorrect Weblog name:A Pretty Fine Weblog 

You may have just noticed some lines starting with `;;`. Let's cover that. 

### [](https://weblog.lol/quickstart-3-personalize#content-understanding-comments)Understanding comments 

There is one other thing to know about the configuration file before we start poking around, and that's the idea of "comments." 

Simply put, any line that begins with `;;` or `//` is a comment. That means weblog.lol will ignore that line when it's deciding how to configure your weblog. 

You can use comments to add notes to your configuration file to keep track of what does what or try new things out by commenting out one line and adding another that's a little different just to see what happens without forgetting what the original line looked like in case you need to switch back. 

Here's an example of how you can use comments: 
    
    ;; tell marketing to pick a better name for this weblog Weblog name: A Blog Full of Things You Should Buy Right Now 

## [](https://weblog.lol/quickstart-3-personalize#content-what-if-i-mess-something-up)What if I mess something up? 

If you're new to configuration files, or just a normal human being who occasionally makes a typo or forgets the right name for something, there's a chance you'll make a mistake and mess up your weblog. Or, you might just make a bunch of changes to your weblog's configuration and decide you don't like them. There are two ways to handle this: 

1. You can always copy and paste your configuration file into a text editor (like Apple's Notes or Windows' Notepad) and save it. That's a good practice once you've made a few changes no matter what.
2. You can copy the original configuration file from our site repository on GitHub and get back to a completely default state. 

If you need to do the latter: 

1. [Visit our copy on GitHub](https://github.com/neatnik/weblog.lol/blob/main/configuration/configuration.txt).
2. Click on the button that says "Raw" at the top of the configuration file text.
3. Select all the text and copy it.
4. Paste the text back into your configuration file on weblog.lol. 

Now that you know how to get back to a good state you can start poking around a little without worrying too much. 

## [](https://weblog.lol/quickstart-3-personalize#content-personalize-your-weblogs-title)Personalize your weblog's title 

Your weblog's title is the simplest thing to change in your configuration that you'll be able to observe immediately. It's also the very first option you can set in the configuration file, so let's start there. 

Your weblog's title is what people see at the top of the page when they visit your blog. It's also what they see in browser tabs, RSS readers, and any preview widgets on social media. To set it: 

1. Look for the line that reads `Weblog title: weblog.lol`
2. Change the text after `Weblog title: ` to your weblog's title.
3. Click "Save & Publish" 

You'll get a notification that your weblog is rebuilding. It might take a little time for that to happen: Each page has to be updated with your weblog's new title. 

You can see the results a couple of ways: 

* Visit your weblog's homepage: `https://YOURADDRESS.weblog.lol`
* Click on one of the posts in the "Posts" list underneath the configuration file editing area, then click "View Live." 

Either way, at the top of your page you'll see your new weblog title in the upper left of the page. 

## [](https://weblog.lol/quickstart-3-personalize#content-set-your-weblog-author-and-description)Set your weblog author and description 

Just like you changed the title, you can change your weblog's author and description. 

The author setting turns up in your weblog's RSS feeds, and you can also use it in your weblog templates if you want to add a byline to your blog posts, or put your name in a copyright notice. 

By default it looks like this: 
    
    Author: Your Name 

As with the `Weblog title` setting, you can modify it by changing the text after the colon. 

Your weblog description is also something you won't see very often. It also shows up in your RSS feeds and can be added to templates. Some people like to use their weblog description as a subtitle in their templates, but that's a step beyond what we're trying to accomplish today. 

By default, it looks like this: 
    
    Weblog description: This is a weblog. 

Go ahead and change it to whatever suits you. 

## [](https://weblog.lol/quickstart-3-personalize#content-set-your-weblogs-timezone)Set your weblog's timezone 

Finally, we're going to end these very basic customizations by setting your weblog's timezone. 

As we noted at the beginning of this guide, your weblog defaults to the UTC timezone. When it makes a blank post the time will reflect UTC. To get it to show your timezone, you'll need to change the `Timezone` setting. 

To make this change, you'll first need to know what to call your timezone. [Wikipedia has a helpful reference](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones). Visit that page and scroll down to the "List" section and start looking for your country and major city in the "TZ database name" column. Once you've found it, copy the value. It will look something like `America/Los_Angeles` or `Africa/Cairo `. 

By default, the configuration file looks like this: 
    
    Timezone: UTC 

Replace `UTC` with the value you copied.

## Pages
If posts are the core of most weblogs, pages help you round things out: Unlike posts, pages exist outside what people often think of as the "feed" of a weblog -- the stream of regular posts -- and provide a way to share more long-lived or less date-bound information. 

Pages are great for: 

* Telling people what your weblog is about.
* Telling people more about you.
* Providing links to resources, favorite sites, etc. 

On weblog.lol, the default templates for pages differ a little from posts: 

* They don't show tags.
* They don't show the publishing date/time.
* They don't show the recent pages list. 

You can put these things back in if you feel like it, but for purposes of this quick start we're going to work with them in their default form, which is pretty common to most weblog designs. 

We're also going to offer examples centered around a common use for pages on weblogs: The "About" page. "About" pages often include a little biographical or personal information, an overview of what the weblog is about, and sometimes how the weblog is made (such as what tools the author uses). 

## [](https://weblog.lol/quickstart-4-pages#content-make-your-first-page)Make your first page 

Let's start by going to your main weblog.lol page. To get there: 

1. Visit [https://omg.lol](https://omg.lol/).
2. Click "Dashboard".
3. If you have more than one omg.lol address, click the one you want to use. If not, move on to the next step.
4. Click "Weblog". 

Once you're there, you should see the familiar new blog post screen. 

You use the new post screen to make pages, as well. You just have to add some metadata to the front matter. 

Looking at the new post editing area, the front matter should look like this: 
    
    --- Date: 2023-02-13 19:17 --- 

To start working on your new page, you need to add a line to the front matter to set the `Type` of content you're working on. Add a line under the `Date`, setting the `Type` to "Page," like this: 
    
    --- Date: 2023-02-13 19:17 Type: Page --- 

Before we save it let's also change the title and text of the page to something a little more appropriate for this exercise. The main body of page should look like this: 
    
    # Your new post This is a new blog post. You can author it in _Markdown_, which is **awesome**. 

As you may recall, starting the beginning of the first line in a post (or page) with `#` sets the title. Let's make a few small changes: 
    
    # About this weblog This is a new page we are authoring in _Markdown_, which is **awesome**. 

Once you've made the changes, let's save it and see how it looks: 

* Click the "Save and Publish" button, just underneath the editing area.
* Click the "View Live" button. 

Your new page will open in a new tab: 

As we noted in the introduction, this looks a little different from a regular blog post: 

* There's no date.
* There's no list of recent posts.
* There's no list of tags. 

When you're done looking around, close the tab and let's learn one more thing about pages. 

## [](https://weblog.lol/quickstart-4-pages#content-customize-your-new-pages-url)Customize your new page's URL 

Every web page has a "URL" -- its address, which you can find in the location bar of your browser. Depending on whether you followed along or decided to go your own way, you may have noticed that your new page has a URL like this: 

`https://YOURADDRESS.weblog.lol/about-this-weblog` 

The part of the URL after the right-most `/` is often referred to as the "slug." 

Once upon a time in the early web it was not uncommon for web pages to have less readable URLs. You may remember seeing things like: 

`http://somesite.com/section?234&article_id=12345` 

or 

`http://anothersite.com/1a235fc69088bz` 

These kinds of URLs didn't work very well for people and over time it became more and more common to make URLs a little more human (and search engine) readable. 

As it stands, `https://YOURADDRESS.weblog.lol/about-this-weblog` isn't the worst URL in the world. It's human-readable, and it's relatively easy to share by quickly writing it down or just saying it to someone. We can make it a little bit more easy to share, and also make it easier to guess. 

Your page's front matter should currently look something like: 
    
    --- Date: 2023-02-13 19:17 Type: Page --- 

We can change the URL by adding the `Location` setting to the front matter. Most "About" pages have the very simple slug of "about," so let's use that: 
    
    --- Date: 2023-02-13 19:17 Type: Page Location: /about --- 

You may have noticed the leading `/` in the `Location` setting. If a `Location` setting starts with `/` that means the URL will be relative to the "site root" (the topmost directory) of your weblog. 

See for yourself by clicking "Save and Publish" and then clicking "View Live." Your new page will open in a new tab and you can review the new URL in your browser's location bar: 

`https://YOURADDRESS.weblog.lol/about` 

That's a little shorter, a little easier to share, and more in line with what people expect for an "About" page URL if they decide to just type it into their browser for some reason. 

## [](https://weblog.lol/quickstart-4-pages#content-a-few-more-notes-on-custom-locations)A few more notes on custom locations 

You are no doubt wondering, if you didn't just go find one of your blog posts and try it yourself, if the `Location` setting works for blog posts, as well. It does, indeed. If you don't like the default URL structure of weblog.lol posts, however, we're going to cover how to change that in the next section. 

You can also create custom locations a few "directory" levels deep, to help organize your weblog a little better if you're going to have numerous pages about multiple topics. For instance, suppose your interests are botany and skateboarding. You could set custom locations for each page about those topics in a way that creates a directory structure for your weblog: 

* `Location: /plants/interesting-links`
* `Location: /plants/my-house-plants`
* `Location: /plants/care-tips` 

and 

* `Location: /skateboarding/my-collection`
* `Location: /skateboarding/trick-videos`

# Advanced Configuration 

This final section will teach you how to make some finishing touches on your weblog by adding navigation and customizing how it shows the date and time in blog posts, and customizing how its URL structure works. 

Before we jump in, let's refresh on one important part of Markdown: Making links. 

## [](https://weblog.lol/quickstart-5-advanced-config#content-making-links-in-markdown)Making links in Markdown 

If you're familiar with HTML, you know that a link looks something like this: 
    
    <a href="https://omg.lol">omg.lol</a> 

For this next section, you can make links in your weblog's navigation menu that way if you like, or you can use Markdown links. The Markdown version of the link above looks like this: 
    
    [omg.lol](https://omg.lol) 

That's a little more compact and easy to read. 

## [](https://weblog.lol/quickstart-5-advanced-config#content-make-a-navigation-menu)Make a navigation menu 

Most web sites have some sort of navigation menu. They're so common that many people just refer to it as "the nav." The menu might include links to pages on the website itself, social media profiles, or other sites you maintain. For this exercise we're going to include links to the "About" page you created in the previous section, your omg.lol address page, and a Mastodon profile. 

If you created some other page or gave it a custom `Location` different from `/about`, make sure you know its location before jumping in. 

As with previous customizations, you'll need to visit your configuration file: 

1. Visit [https://omg.lol](https://omg.lol/)
2. Click "Dashboard"
3. Click "Weblog" (If you have more than one omg.lol address, click the one you want to use and then click "Weblog")
4. Click the "Configuration" button in the "Tools" section, toward the bottom of the page. 

To make things a little easier, your configuration file already has a menu set up. Scroll down a few lines and look for one that looks like this: 
    
    // Navigation: about, another-page, <a href="https://example.com">Example</a>, [Example](https://example.com) 

You may remember from the previous section about your configuration file that lines starting with a `//` or `;;` are "comments." weblog.lol doesn't do anything with configuration settings that are "commented out." That's the case here. 

When you're working with a configuration file, it's a good practice to make incremental changes and use comments liberally so that it's easy to get back to a "known good state" -- something that was working before you started making changes. So instead of changing this line, let's make a copy so that we have a good example of how the `Navigation` setting is supposed to look. Just do that by copying and pasting the line right underneath itself, so you have: 
    
    // Navigation: about, another-page, <a href="https://example.com">Example</a>, [Example](https://example.com) // Navigation: about, another-page, <a href="https://example.com">Example</a>, [Example](https://example.com) 

As you can see, `Navigation` is just a comma-delimited list that can use several kinds of values: weblog locations, HTML links, and Markdown links. 

In order of their appearance in the sample navigation: 

* `about` is a page or post address on your weblog. If you've followed this guide closely, you created an About page in the previous section and gave it a custom `Location` of `/about`.
* `another-page` is also a page or post address on your weblog. Unless you've made this page yourself, you won't have `another-page` to link to. If a page with a given address on this list doesn't exist, weblog.lol will skip over it when it's making a navigation menu.
* `<a href="https://example.com">Example</a>` is a regular HTML link.
* `[Example](https://example.com)` is a Markdown link. 

Just like the example, you can mix and match how you add links to your navigation menu. 

For now, it will be useful to see what happens when you try to use the default `Navigation` setting found in your configuration file, so let's uncomment one of those two `Navigation` lines: 
    
    // Navigation: about, another-page, <a href="https://example.com">Example</a>, [Example](https://example.com) Navigation: about, another-page, <a href="https://example.com">Example</a>, [Example](https://example.com) 

... then click the "Save and Publish" button. 

There's not a one-click way to get to your weblog, so just point your browser to `https://YOURADDRESS.weblog.lol`. 

If you've followed this quick start guide closely, your weblog will look something like this: 

Your new menu is just underneath your weblog's title in the upper left corner of the page. 

Looking closely, the results might seem a little different from what you were expecting: 

The first link in the `Navigation` setting, which we set to `about`, shows the title of page it links to, not the shorter version we set in the `Location` setting in the page's front matter. 

The second link in the `Navigation` setting, which we set to `another-page`, doesn't appear at all because that location doesn't exist in our weblog. If a page ever fails to appear in the navigation, always check to make sure its address or custom `Location` matches what you put in the `Navigation` setting exactly. 

The third and fourth links, the HTML and Markdown links, appear about as you'd expect. 

Let's circle back to that first link: 

If you'd prefer to use shorter text to keep things a little more readable, you can go back to your "About" page and add a setting in the front matter. Using the example we created in the last section, for instance, your front matter would change from this: 
    
    --- Date: 2023-02-13 19:17 Type: Page --- 

to this: 
    
    --- Date: 2023-02-13 19:17 Type: Page Title: About --- 

The title you set in the front matter will override the title you set using the Markdown `#` (heading) tag for purposes of the navigation. 

So let's finish up the navigation and move on. Open your weblog's configuration file by clicking the "Configuration" button in the "Tools" section, toward the bottom of the page and scrolling back to your `Navigation` settings: 
    
    // Navigation: about, another-page, <a href="https://example.com">Example</a>, [Example](https://example.com) Navigation: about, another-page, <a href="https://example.com">Example</a>, [Example](https://example.com) 

Here's an example that would create a navigation menu pointing to your about page, your omg.lol address page, and a Mastodon account. We'll make things a little easier to read by using Markdown for the last two links. Where we have `YOUR_ADDRESS`, replace it with your own omg.lol address: 
    
    // Navigation: about, another-page, <a href="https://example.com">Example</a>, [Example](https://example.com) Navigation: about, [Me on omg.lol](https://@YOUR_ADDRESS.omg.lol), [Mastodon](https://social.lol/@YOUR_ADDRESS) 

Click "Save and Publish," visit your weblog's front page, and you should see your new navigation menu, looking something like this: 

## [](https://weblog.lol/quickstart-5-advanced-config#content-date-time-and-url-structures)Date, time, and URL structures 

Next, we're going to need to go on a brief excursion into a topic most programmers will be very familiar with: Formatting date and time. Learning how this works will help you both customize how your blog posts display the date and time they were published, and how your weblog structures post URLs. 

Let's open your configuration file to get ready. If you don't remember how to find it: 

1. Visit [https://omg.lol](https://omg.lol/)
2. Click "Dashboard"
3. Click "Weblog" (If you have more than one omg.lol address, click the one you want to use and then click "Weblog")
4. Click the "Configuration" button in the "Tools" section, toward the bottom of the page. 

Once you're in your configuration file, look for this line: 
    
    Date format: F j, Y g:i A 

Based on what we've covered already, you probably understand you're looking at the `Date format` setting. This controls how the date and time are shown on your weblog. For instance, using this setting, your weblog will show the following as the date and time on blog posts: 

`February 10, 2023 6:24 PM` 

As you may have surmised, the individual letters in the setting you found in your configuration file are placeholders for date and time values. Here's a key: 

* `F` = the full version of the month name
* `j` = the day of the month
* `Y` = the four-digit year
* `g` = the hour (in 12-hour time format)
* `i` = the minutes after the hour
* `A` = AM/PM 

Any spaces and punctuation you include in the `Date format` setting are shown as is by weblog.lol. 

So, to provide a very simple example if you don't care about displaying the time that something was posted, you could change `Date format` to: 
    
    Date format: F j, Y 

... and you'd see this on your weblog: 

`February 10, 2023` 

If you'd like to customize this further, we've put together [a cheat sheet with all the placeholders](https://docs.paste.lol/weblog-time-formatting.md/markup). Here's another example using this guide: 
    
    Date format: l, jS F Y, g:i A T 

Depending on when the post was written, this will result in a date and time line that looks like this: 

`Friday, 10th February 2023, 6:24 PM` 

## [](https://weblog.lol/quickstart-5-advanced-config#content-setting-the-url-structure)Setting the URL structure 

Setting the `Date format` gets you ready to create a custom URL structure. 

Looking in your configuration file, scroll down until you find this line: 
    
    Post path format: /Y/m/ 

This is the `Post path format` setting, which determines how your URLs look. It uses the same placeholders the `Date format` setting uses. By default, your post paths will include a four-digit year and a two-digit month (with leading zeroes for single-digit month numbers). The blog post we created earlier in this guide, for instance, has a path something like: 

`2023/02/my-first-blog-post` 

You can use [the same cheat sheet](https://docs.paste.lol/weblog-time-formatting.md/markup) you used to set `Date format` to change everything in front of the slug (`my-first-blog-post`). For instance, you might want to leave out the month: 
    
    Post path format: /Y/ 

or add the day: 
    
    Post path format: /Y/m/d/ 

It's a good idea to think this through early on, before you have too many blog posts under your belt: If you change the `Post path format` down the line it will break any links, bookmarks, or search engine results that may exist.