# Angular2 Dart Gnome Example App

## My Angular2 API cheatsheet
[Angular2 Dart cheatsheet (google doc)](https://docs.google.com/document/d/1FYyA-b9rc2UtlYyQXjW7lx4Y08MSpuWcbbuqVCxHga0/edit#heading=h.34sus6g4zss3)

## What this app demonstrates in Angular2
 - nested components
 - passing data to a nested component
 - receiving DOM events from a nested component
 - receiving custom events from a nested component
 - displaying variables in HTML
 - showing/hiding DOM elements based on state
 - testing asynchronous behavior using expectAsync
 - testing asynchronous behavior using async/await

## How to run the app with Dartium
 - cd to the application directory
 - pub get
 - pub serve
 
## How to run the tests
 - pub run test  # runs the non-browser tests
 - pub run test -p dartium  # runs all the tests using Dartium (assuming it's configured)
 
## Roadmap, stuff to add
 - testing a component with a custom HTML testbed
 - testing a component using TestComponentBuilder, [like this](https://github.com/angular/angular/blob/0db88f34b8ee20c5b6f926d2c92481de74d3f030/modules/angular2/test/test_lib/test_component_builder_spec.ts)
 - per-component CSS
 - testing elements in the shadow dom
 - router integration
 - service layer using JSON
