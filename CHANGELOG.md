# CHANGELOG

## next
- Remove the web-full example. Was not maintained.

## 0.2.2+1
- Moved the script tags for the web templates into the head section

## 0.2.2
- Added a `console-simple` template
- Updated the `web-simple` and `web-full` templates

## 0.2.1
- All templates updated to use the latest `test` package

## 0.2.0+1
- Update the template descriptions
- The `web-full` sample now reverses the text on page load

## 0.2.0
- All templates updated to the latest package versions!
- Template ids have now changed to help organize them into categories. So, all
  the web related templates start with `web-`: `web-simple`, `web-full`, and
  `web-polymer`.

## 0.1.5+5

- Updated the dependency on `usage`

## 0.1.5+3

- Updated the dependency on `usage`

## 0.1.5+2

- Changed to using the `usage` library for Google Analytics

## 0.1.5+1

- Update README to mention ubersimplewebapp

## 0.1.5

- Added a new `ubersimplewebapp` template.

## 0.1.4

- Added a new `appengineapp` template (thanks @wibling!)
- updates to the webapp, shelfapp, and polymerapp samples

## 0.1.3

- Added a `label` attribute to the templates and to the `--machine` output
- Renamed the `shelfapp` template to `shelfserver`
- Added a `--version` command-line option
- Clarified and simplified some template descriptions
- Made useage of Sass in the `webapp` template optional; added instructions in
  the template about how to enable it
- Added instructions after project generation to tell the user how best to run
  the project
- Stagehand is now integrated into the Editor, the Eclipe plugins, Chrome Dev
  Editor, and the Sublime plugin

## 0.1.2

- Removed the `-o` option; we now generate the selected template into the
  current directory
- Added pre-generated css to the `webapp` template
- some changes to better support stagehand being driven by existing tooling
  (IDEs)
- The `polymer` template was renamed to `polymerapp`

## 0.1.1

- Changed to allow stagehand to generate a project into an existing directory

## 0.1.0

- Removed Web Starter Kit, waiting for at least WSK 0.6.0
- Renamed `helloworld` to `consoleapp`
- Added `polymer` template
- Added `shelfapp` template
- Added default BSD license to projects
- Analytics are opt-in. Version update ping is still automatic.

## 0.0.5

- Added [Web Starter Kit](https://developers.google.com/web/starter-kit/)!
- Added anonymous user metrics via Google Analytics

## 0.0.4

- Fix bug in publib generator

## 0.0.3

- Add first version of a publib generator
