# Minimal Dart Webapp

A starting point for a webapp built with Dart. This template
is recommended if you don't want to, or
cannot, use Polymer or AngularDart.

This template features:

* Responsive web design, thanks to Web Starter Kit
* CSS minification, thanks to Sass
* Inlining scripts, thanks to `script_inliner`
* Routing and views, thanks to `route_hierarchical`
* Handling input, thanks to `dart:html`

## Responsive

Thanks to Web Starter Kit, this template looks and acts great on
mobile and desktop. Using the styles found in `web/styles`, you can
be assured there is base support for phones, tablets, and laptops.

The `lib/nav_menu.dart` is required to trigger the menus when on a phone.

## CSS minification

Thanks to Sass, CSS or SCSS files imported by `web/styles/main.scss`
are concantenated and minified during builds. The result is a small
and fast-loading CSS file.

Look in `pubspec.yaml` for the `sass` dependency. The Sass transformer
does the work of converting Sass into CSS and minimizing it.

## Inlining scripts

To reduce the app startup time, this template inlines the `dart.js` file.
During a build, the contents of `dart.js` are included in the `index.html`
file.

Look in `pubspec.yaml` for the `script_inliner` dependency and transformer.

## Routing

Any real app needs to deal with different views. _Routing_ is the technique
of responding to changing in the URL and changing the view of the app.

This template uses the `route_hierarchical` package. Look inside `main.dart`
for the route setup. It's very easy to extend.

Because this template isn't a full app framework (you should use
AngularDart, Polymer, or other great options in http://pub.dartlang.org
if you want a full app framework), the work of actually switching the views
is simply changing the display properties of different divs. Look inside
of `main.dart` for how different divs are displayed.

The authors of this template believe in routing, but do admit there are
more scalable ways to manage views.

## Handing input

Using `dart:html`, this template simply finds the necessary input fields
via `querySelector` and binds to their keyUp events. Look inside
`lub/reverser.dart` for an example.

However, a real app framework will offer robust data binding.
