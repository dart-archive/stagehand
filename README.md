# Stagehand - A Dart project generator

## Helps you get setup!

Stagehand helps you get your Dart projects set up and ready for the big show.
It is a Dart project scaffolding generator, inspired by tools like Web Starter Kit and Yeoman.

## Goals

* Opinionated and prescriptive
  * minimal to no options
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
    * this is the most minimal option. for the developer that doesn’t want to be confused by too much going on.
  * Dart + Polymer app
    * this is the most opinionated and complete option. for the developer that says “I just want to paint by numbers”
  * Dart + server-side
* Creates
  * the project directory itself
  * all required directories
  * pubspec.yaml file
  * .gitignore file
  * initial files like index.html

## Issues and bugs

Please file on [Github Issues](https://github.com/sethladd/stagehand/issues).
