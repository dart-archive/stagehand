# Stagehand - A Dart project generator

![Stagehand banner](https://raw.githubusercontent.com/google/stagehand/master/site/banner_stagehand.jpg)

[![pub package](https://img.shields.io/pub/v/stagehand.svg)](https://pub.dartlang.org/packages/stagehand)
[![Build Status](https://travis-ci.org/google/stagehand.svg?branch=master)](https://travis-ci.org/google/stagehand)
[![Coverage Status](https://coveralls.io/repos/google/stagehand/badge.svg?branch=master)](https://coveralls.io/r/google/stagehand?branch=master)

## Helps you get set up!

Stagehand helps you get your Dart projects set up and ready for the big show.
It is a Dart project scaffolding generator, inspired by tools like Web Starter
Kit and Yeoman.

## Stagehand templates
* `console-full` - A larger command-line application sample.
* `console-simple` - A simple command-line application.
* `package-simple` - A starting point for Dart libraries or applications.
* `server-shelf` - A web server built using the shelf package.
* `web-angular` - A web app that uses the AngularDart framework.
* `web-simple` - A bare-bones web app.

## Installation

Requirements:

To install:

```console
> pub global activate stagehand
```

To update, run activate again:

```console
> pub global activate stagehand
```

## Usage

Stagehand will generate a project skeleton into the current directory. As an
example, here is how you create a package with Stagehand:

```console
> mkdir fancy_project
> cd fancy_project
> stagehand package-simple
```

And to list all of the project templates:

```console
> stagehand
```

## Goals

* Opinionated and prescriptive; minimal to no options
* Mobile first
* Support for both server and client apps
* The best way to create a new Dart project
* Used by IntelliJ, WebStorm, Atom, Sublime, and more
* Distributed as a pub package

## Issues and bugs

Please file reports on the
[GitHub Issue Tracker](https://github.com/google/stagehand/issues).

## Contributing

Contributions welcome! Please read this short
[guide](https://github.com/google/stagehand/wiki/Contributing) first.

## Analytics and crash reports

Learn more about how [Stagehand uses Google Analytics][analytics] for measuring
usage and error reporting, and how you can opt out.

## Disclaimer

This is not an official Google product.

[analytics]: https://github.com/google/stagehand/wiki/Anonymous-analytics-and-crash-reports
