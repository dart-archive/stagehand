## 1.1.4

- Update `web-angular` to use `lib/src` for everything but the main app
  component.

## 1.1.3

- Removed `platform_*` options from `web-angular`.

## 1.1.2

- Removed `web-angular-simple` and `console-simple` templates:
  - The list of templates had become too long.
  - Documentation (such as the
    [Angular guide](https://webdev.dartlang.org/angular/guide/setup))
    that used to rely on `web-angular-simple` now uses
    https://github.com/angular-examples/quickstart.
- Changed `web-angular`template:
   - The template is now a simple todo-list app.
   - Added component tests.
- Tweaked the text of some template descriptions.

## 1.1.1

- Added `angular_test` based tests to web-angular-simple.
- Updated `web-angular-*` templates:
  - Renamed `angular2_components` to `angular_components`.
  - Package version updates in `pubspec.yaml`:
    - `angular` to 3.0.0
    - `angular_components` to 0.5.0
    - Minimal SDK to 1.23
  - Adjusted `index.html` `<base href>` initialization script.

## 1.1.0

- Added `web-stagexl` template.
- Updated `analysis_options.yaml` for all templates.
  - Strong mode is on by default.
  - A basic set of lint rules is now included.

## 1.0.24

- Improve web-angular* routing regex.

## 1.0.23

- Standardized the layout of `pubspec.yaml` for all templates.
  - Use `^` notation for versions.
  - Define the minimum SDK to be `1.20.1`.
- Simplified `.gitginore` for all templates.
  - No longer need to ignore `packages` directory. They are not not generated
    with SDK 1.20.1+.
  - No longer ignoring compiled outputs by extension. These will all be in the
    `build` directory, which is already ignored.
  - No longer ignoring JetBrains IDE files. These should be ignored in a users
    global `.gitignore`.

## 1.0.22
- Tweaked pubspec descriptions for web-angular-* templates.
- Updated `web-angular-simple` to have copyrights and various project
  support files such as `LICENSE`.
- Updated `web-angular` to use global `styles.css`. Also tweaked `hello_dialog.dart`,
  and added project support files like `LICENSE`.

## 1.0.21
- Changed the names of all `.analysis_options` files to `analysis_options.yaml`.
- In an effort to forestall routing issues during development, added code in
  `web-angular*/web/index.html` to generate a base href.
- Renamed `web-angular-quickstart` to `web-angular-simple`.

## 1.0.20
- Updated `web-angular` to use `angular2_components` and to follow
  best practices.
- Made generated code use the current calendar year.

## 1.0.19
- Added `web-angular-quickstart`, a copy of the Angular docs' first example.
- Removed `web-polymer`.
- Updated `web-angular` to `^2.2.0`.

## 1.0.18
- Added platform_directives & platform_pipes back to the `web-angular` pubspec.

## 1.0.17
- Updated `web-angular` to `^2.0.0`.

## 1.0.16
- Moved the `dart_to_js_script_rewriter` dependency to a dev_dependency.

## 1.0.15
- Updated the `.analysis_options` files for all templates.

## 1.0.14
- Renamed `Console Application` to `Simple Console Application`.
- Renamed `Uber Simple Web Application` to `Simple Web Application`.
- Removed the `App Engine Application` sample.

## 1.0.13
- Updated `web-angular` to `2.0.0-beta.21`.

## 1.0.12
- Add commented-out `.analysis_options` file to all templates.
- Add a component CSS file to `web-angular`.

## 1.0.11
- Updated `web-angular` to `2.0.0-beta.20`.

## 1.0.10
- Updated `web-angular` to `2.0.0-beta.18`.
- Made stagehand strong-mode clean, and cleaned up dependencies.

## 1.0.9
- Use git user name for author name.
- Change shelf listener address.

## 1.0.8
- Updated `web-angular` to `2.0.0-beta.17`.

## 1.0.7
- Updated `web-angular` to `2.0.0-beta.16`.

## 1.0.6
- Updated `web-angular` to `2.0.0-beta.15`.

## 1.0.5
- Updated `web-angular` to `2.0.0-beta.13.1`.

## 1.0.4
- Updated `web-angular` to `2.0.0-beta.12`. Also changed imports:
  - `angular2.dart` -> `core.dart`
  - `bootstrap.dart` -> `platform/browser.dart`
- Updated dart_to_js_script_rewriter dependencies to ^1.0.1.

## 1.0.3
- Fixed the `web-polymer` template, which was broken in 1.0.2.

## 1.0.2
- Removed `library` directives almost everywhere.
- Updated LICENSE.
- Updated `web-angular` to `2.0.0-beta.9`.

## 1.0.1
- Updated `web-angular` to `2.0.0-beta.6`. Also added a description
  and dart_to_js_script_rewriter to the pubspec.
- Made generator initialization code more consistent.

## 1.0.0
- This project is stable (as of 0.2), so we're belatedly declaring it 1.0.
- Updated `web-angular` to `2.0.0-beta.3`.
- Updated `web-simple` to use `<script defer...>` instead of `<script async...>`.

## 0.2.6
- Updated the Polymer and Angular templates to the latest packages.

## 0.2.5+4
- Added a reference to the webcomponents-lite.js in the Polymer template.

## 0.2.5+3
- Updated `web-angular` to `2.0.0-beta.0`.

## 0.2.5+2
- Fixed `web-polymer` app bindings.

## 0.2.5+1
- Fixed the generated test file for `console-full`.

## 0.2.5
- Added `web-angular` template for an Angular2 (alpha) app.

## 0.2.4
- Migrated `server-appengine` to use `shelf`.
- Updated the template `.gitignore` files.
- Updated reflectable entry point format for the polymer template.

## 0.2.3+1
- Fixed an issue with the Polymer template.

## 0.2.3
- Updated the Polymer sample to the latest version (`1.0.0-rc.1`).
- Removed the web-full example (it had not been maintained).

## 0.2.2+1
- Moved the script tags for the web templates into the head section.

## 0.2.2
- Added a `console-simple` template.
- Updated the `web-simple` and `web-full` templates.

## 0.2.1
- All templates updated to use the latest `test` package.

## 0.2.0+1
- Updated the template descriptions.
- The `web-full` sample now reverses the text on page load.

## 0.2.0
- All templates updated to the latest package versions!
- Template ids have now changed to help organize them into categories. So, all
  the web related templates start with `web-`: `web-simple`, `web-full`, and
  `web-polymer`.

## 0.1.5+5
- Updated the dependency on `usage`.

## 0.1.5+3
- Updated the dependency on `usage`.

## 0.1.5+2
- Changed to using the `usage` library for Google Analytics.

## 0.1.5+1
- Update README to mention ubersimplewebapp.

## 0.1.5
- Added a new `ubersimplewebapp` template.

## 0.1.4
- Added a new `appengineapp` template (thanks @wibling!).
- Updates to the webapp, shelfapp, and polymerapp samples.

## 0.1.3
- Added a `label` attribute to the templates and to the `--machine` output.
- Renamed the `shelfapp` template to `shelfserver`.
- Added a `--version` command-line option.
- Clarified and simplified some template descriptions.
- Made useage of Sass in the `webapp` template optional; added instructions in
  the template about how to enable it.
- Added instructions after project generation to tell the user how best to run
  the project.
- Stagehand is now integrated into the Editor, the Eclipe plugins, Chrome Dev
  Editor, and the Sublime plugin.

## 0.1.2
- Removed the `-o` option; we now generate the selected template into the
  current directory.
- Added pre-generated css to the `webapp` template.
- Some changes to better support stagehand being driven by existing tooling
  (IDEs).
- The `polymer` template was renamed to `polymerapp`.

## 0.1.1
- Changed to allow stagehand to generate a project into an existing directory.

## 0.1.0
- Removed Web Starter Kit, waiting for at least WSK 0.6.0.
- Renamed `helloworld` to `consoleapp`.
- Added `polymer` template.
- Added `shelfapp` template.
- Added default BSD license to projects.
- Analytics are opt-in. Version update ping is still automatic.

## 0.0.5
- Added [Web Starter Kit](https://developers.google.com/web/starter-kit/)!
- Added anonymous user metrics via Google Analytics.

## 0.0.4
- Fix bug in publib generator.

## 0.0.3
- Add first version of a publib generator.
