# Stagehand - A Dart project generator

![Stagehand banner](https://raw.githubusercontent.com/google/stagehand/master/site/banner_stagehand.jpg)

[![pub package](https://img.shields.io/pub/v/stagehand.svg)](https://pub.dartlang.org/packages/stagehand)
[![Build Status](https://travis-ci.org/google/stagehand.svg?branch=master)](https://travis-ci.org/google/stagehand)
[![Coverage Status](https://coveralls.io/repos/google/stagehand/badge.svg?branch=master)](https://coveralls.io/r/google/stagehand?branch=master)

## Helps you get setup!

Stagehand helps you get your Dart projects set up and ready for the big show.
It is a Dart project scaffolding generator, inspired by tools like Web Starter
Kit and Yeoman.

## Stagehand templates
* `console-full` - A larger command-line application sample.
* `console-simple` - A simple command-line application.
* `package-simple` - A starting point for Dart libraries or applications.
* `server-appengine` - A simple App Engine application.
* `server-shelf` - A web server built using the shelf package.
* `web-full` - A mobile-friendly web app with routing, responsive CSS, and (optional) Sass support.
* `web-polymer` - A web app built using polymer.dart.
* `web-simple` - An absolute bare-bones web app.

## Installation

Requirements:

To install:

    $> pub global activate stagehand

To update:

    # activate stagehand again
    $> pub global activate stagehand

## Usage

Stagehand will generate a project skeleton into the current directry. As an
example, here is how you create a webapp with Stagehand:

    $> mkdir fancy_project
    $> cd fancy_project
    $> stagehand web-full

And to list all of the project templates:

    $> stagehand

## Goals

* Opinionated and prescriptive; minimal to no options
* Mobile-first
* Support server and client apps
* Becomes the best way to create a new Dart project
* Used by WebStorm, CDE, Sublime, and more
* Distributed as a pub package

## Issues and bugs

Please file reports on the
[GitHub Issue Tracker](https://github.com/google/stagehand/issues).

## Contributing

Contributions welcome! Please read this short
[guide](https://github.com/google/stagehand/wiki/Contributing) first.

## Analytics and crash reports

Learn more about how [Stagehand uses Google Analytics][analytics] for measuring
usage and error reporting, and how you can opt-out.

## Disclaimer

This is not an official Google product.

[analytics]: https://github.com/google/stagehand/wiki/Anonymous-analytics-and-crash-reports
