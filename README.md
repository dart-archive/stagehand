# Stagehand - A Dart project generator

![Stagehand banner](site/banner_stagehand.jpg?raw=true)

[![Build Status](https://travis-ci.org/google/stagehand.svg?branch=master)](https://travis-ci.org/google/stagehand)

## Helps you get setup!

Stagehand helps you get your Dart projects set up and ready for the big show.
It is a Dart project scaffolding generator, inspired by tools like Web Starter
Kit and Yeoman.

## Installation

Requirements:

* Dart SDK 1.6 or greater on your path

Install:

    $> pub global activate stagehand

## Usage

    $> cd where_you_want_to_create_the_project_directory
    $> pub global run stagehand -o _directory_name_ webapp

To list all of the project templates:

    $> pub global run stagehand

## Goals

* Opinionated and prescriptive; minimal to no options
* Mobile-first
* Support server and client apps
* Becomes the best way to create a new Dart project
* Used by WebStorm, CDE, Sublime, and more
* Distributed as a pub package

## Non-goals

* Fostering an entire ecosystem of generators
  * This project is too opinionated. It’s not a framework for generators.

## Requirements

* Open source, hosted on github
* Run the generators via `pub global run`
  * or, via an API exposed by the package
* Single package
* Generators for:
  * Dart + HTML app
    * this is the most minimal option. for the developer that doesn’t want to
      be confused by too much going on.
  * Dart + Polymer app
    * this is the most opinionated and complete option. for the developer that
      says “I just want to paint by numbers”
  * Dart + server-side
  * Dart library (suitable to publish on pub.dartlang.org)
* Anonymous and opt-in usage analytics
* Creates
  * the project directory itself
  * all required directories
  * pubspec.yaml file
  * .gitignore file
  * initial files like index.html

## Issues and bugs

Please file on [Github Issues](https://github.com/sethladd/stagehand/issues).

## Analytics and crash reports

Learn more about how
[Stagehand uses Google Analytics][analytics] for measuring usage and error reporting,
and how you can opt-out.

## Disclaimer

This is not an official Google product.


[analytics]: https://github.com/google/stagehand/wiki/Anonymous-analytics-and-crash-reports
