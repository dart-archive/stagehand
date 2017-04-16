# Dart Chrome apps with PolymerDart

This is an example of how to use PolymerDart in a chrome apps.

## How to get all work together

### Step 1

First create a polymer dart project using stagehand.

### Step 2

When you have that open your pubspec.yaml and add the chrome dependencies you should have something like that :

```yaml
dependencies:
  browser: any
  polymer: '>=0.15.4 <0.16.0'
  paper_elements: '>=0.6.1 <0.7.0'
  chrome: any
```

### Step 3

After that add the chrome transformer and the dart2js transformer :

```yaml
- chrome
- $dart2js:
    csp: true
```

### Step 4

Don't forget to add the background.js and the manifest.json inside your web directory.

### Step 5

Build your application


### Step 6

Load your unpacked extension from your build folder and launch it.
