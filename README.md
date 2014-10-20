# Stagehand - A Dart project generator

![Stagehand banner](https://raw.githubusercontent.com/google/stagehand/master/site/banner_stagehand.jpg)

[![Build Status](https://travis-ci.org/google/stagehand.svg?branch=master)](https://travis-ci.org/google/stagehand)

## Helps you get setup!

Stagehand helps you get your Dart projects set up and ready for the big show.
It is a Dart project scaffolding generator, inspired by tools like Web Starter
Kit and Yeoman.

## Things you can create with Stagehand

* consoleapp - a minimal command-line script
* package - a library for pub, complete with tests
* polymer - a web app with Polymer.dart and paper (material design) elements
* shelfapp - a minimal web server using the shelf package
* webapp - a minimal responsive web app, with Sass, routing, and more

## Installation

Requirements:

* Dart SDK 1.6 or greater on your path

Install:

    $> pub global activate stagehand

## Usage

As an example, here is how you create a webapp with Stagehand:

With Dart 1.7 or greater:

    $> cd where_you_want_to_create_the_project_directory
    $> stagehand -o _directory_name_ webapp

With Dart 1.6:

    $> cd where_you_want_to_create_the_project_directory
    $> pub global run stagehand -o _directory_name_ webapp

Here is how you list all of the project templates:

With Dart 1.7 or greater:

    $> stagehand

With Dart 1.6:

    $> pub global run stagehand

## Goals

* Opinionated and prescriptive; minimal to no options
* Mobile-first
* Support server and client apps
* Becomes the best way to create a new Dart project
* Used by WebStorm, CDE, Sublime, and more
* Distributed as a pub package
* Non-goal: fostering an entire ecosystem of generators. This project is opinionated. It’s not a framework for generators.

## Issues and bugs

Please file on [Github Issues](https://github.com/sethladd/stagehand/issues).

## Analytics and crash reports

Learn more about how [Stagehand uses Google Analytics][analytics] for measuring
usage and error reporting, and how you can opt-out.

## Disclaimer

This is not an official Google product.

[analytics]: https://github.com/google/stagehand/wiki/Anonymous-analytics-and-crash-reports
