# Stagehand - A Dart project generator

![Stagehand banner](https://raw.githubusercontent.com/google/stagehand/master/site/banner_stagehand.jpg)

[![Build Status](https://travis-ci.org/google/stagehand.svg?branch=master)](https://travis-ci.org/google/stagehand)

## Helps you get setup!

Stagehand helps you get your Dart projects set up and ready for the big show.
It is a Dart project scaffolding generator, inspired by tools like Web Starter
Kit and Yeoman.

## Things you can create with Stagehand

* appengineapp - a simple AppEngine application
* consoleapp - a simple command-line application
* package - a starting point for Dart libraries or applications
* polymerapp - a web app built using polymer.dart
* shelfserver - a web server built using the shelf package
* ubersimplewebapp - an absolute bare-bones web app
* webapp - a mobile-friendly web app with routing, responsive CSS, and (optional) Sass support

## Installation

Requirements:

* Dart SDK 1.6 or greater on your path

Install:

    $> pub global activate stagehand

Update:

    # activate stagehand again
    $> pub global activate stagehand

## Usage

Stagehand will generate a project skeleton into the current directry. As an
example, here is how you create a webapp with Stagehand:

With Dart 1.7 or greater:

    $> mkdir fancy_project
    $> cd fancy_project
    $> stagehand webapp

With Dart 1.6:

    $> mkdir fancy_project
    $> cd fancy_project
    $> pub global run stagehand webapp

Here is how you list all of the project templates:

With Dart 1.7 or greater:

    $> stagehand

With Dart 1.6:

    $> pub global run stagehand

### How to install a third party template

You can use the option git to install a third party template from a git repository:

    $> stagehand --git <git repo url>

Once installed, the generator will be listed while running the stagehand command.

### How to build a third party template

Clone the [emptyStagehandTemplate](https://github.com/kunaldeo/emptyStagehandTemplate) and add your project to template-dir folder. Detailed instructions are available in the README file.
You can also checkout [polymerContacts](https://github.com/kunaldeo/polymerContacts), it is a complete build of a third party stagehand template.

## Goals

* Opinionated and prescriptive; minimal to no options
* Mobile-first
* Support server and client apps
* Becomes the best way to create a new Dart project
* Used by WebStorm, CDE, Sublime, and more
* Distributed as a pub package
* Non-goal: fostering an entire ecosystem of generators. This project is opinionated. It’s not a framework for generators.

## Issues and bugs

Please file reports on the
[GitHub Issue Tracker](https://github.com/google/stagehand/issues).

## Contributing

Contributions welcome! Please read this short [guide](https://github.com/google/stagehand/wiki/Contributing) first.

## Analytics and crash reports

Learn more about how [Stagehand uses Google Analytics][analytics] for measuring
usage and error reporting, and how you can opt-out.

## Disclaimer

This is not an official Google product.

[analytics]: https://github.com/google/stagehand/wiki/Anonymous-analytics-and-crash-reports
