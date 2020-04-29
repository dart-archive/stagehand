# Stagehand - A Dart project generator

![Stagehand banner](https://raw.githubusercontent.com/dart-lang/stagehand/master/site/banner_stagehand.jpg)

[![Pub package](https://img.shields.io/pub/v/stagehand.svg)](https://pub.dev/packages/stagehand)
[![Build status](https://travis-ci.org/dart-lang/stagehand.svg?branch=master)](https://travis-ci.org/dart-lang/stagehand)
[![Coverage status](https://coveralls.io/repos/dart-lang/stagehand/badge.svg?branch=master)](https://coveralls.io/r/dart-lang/stagehand?branch=master)
[![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-Ready--to--Code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/dart-lang/stagehand) 

## Helps you get set up!

Stagehand helps you get your Dart projects set up and ready for the big show.
It's a Dart project scaffolding generator, inspired by tools like Web Starter
Kit and Yeoman.

Dart-savvy IDEs and editors use Stagehand behind the scenes to get project templates,
but you can also use Stagehand on the command line (`stagehand`).

## Stagehand templates
* `console-simple` - A simple command-line application.
* `console-full` - A command-line application sample.
* `package-simple` - A starting point for Dart libraries or applications.
* `server-shelf` - A web server built using the shelf package.
* `web-angular` - A web app with material design components.
* `web-simple` - A web app that uses only core Dart libraries.
* `web-stagexl` - A starting point for 2D animation and games.

## Installation

If you want to use Stagehand on the command line,
install it using `pub global activate`:

```console
> pub global activate stagehand
```

To update Stagehand, use the same `pub global activate` command.

## Usage

Stagehand generates a project skeleton into the current directory.
For example, here's how you create a package with Stagehand:

```console
> mkdir fancy_project
> cd fancy_project
> stagehand package-simple
```

Here's how you list all of the project templates:

```console
> stagehand
```

## Goals

* Opinionated and prescriptive; minimal to no options
* Support for server and client apps
* The best way to create a new Dart project
* Used by IntelliJ, WebStorm, Visual Studio Code, Atom, Sublime, and more
* Distributed as a pub package

## Issues and bugs

Please file reports on the
[GitHub issue tracker](https://github.com/dart-lang/stagehand/issues).

## Contributing

Contributions welcome! Please read this short
[guide](https://github.com/dart-lang/stagehand/blob/master/CONTRIBUTING.md) first.

## Analytics and crash reports

Learn more about how [Stagehand uses Google Analytics][analytics] for measuring
usage and error reporting, and how you can opt out.

[analytics]: https://github.com/dart-lang/stagehand/wiki/Anonymous-analytics-and-crash-reports
