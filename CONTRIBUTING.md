# Contributing :purple_heart:

Thanks for thinking about helping with [Stagehand][]!
Here are a couple of ways that you can contribute:

* [Report issues](https://github.com/dart-lang/stagehand/issues/new).
* Fix issues (especially ones with the label
  **[help wanted](https://github.com/dart-lang/stagehand/issues?utf8=%E2%9C%93&q=is%3Aopen%20is%3Aissue%20label%3A%22help%20wanted%22%20)**).
  * If this is your first contribution—_welcome!_—please
  [sign the CLA](https://developers.google.com/open-source/cla/individual)
  and check out issues that are
  labeled **[beginner](https://github.com/dart-lang/stagehand/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aopen%20label%3A%22help%20wanted%22%20label%3Abeginner%20)**.
  * We use the usual [GitHub pull request](https://help.github.com/articles/about-pull-requests/) process.

To avoid wasting your time, please talk with us before you make any nontrivial
pull request. The [issue tracker](https://github.com/dart-lang/stagehand/issues)
is a good way to track your progress publicly, but we can also communicate
other ways such as email and [Gitter](https://gitter.im/dart-lang/TALK-general).

### Compress templates

If you make changes to template files, regenerate the templates:

```
pub run build_runner build --delete-conflicting-outputs
```

Make sure to use Unix line endings when you edit template files, especially on Windows machines.
Otherwise the template files might get the wrong line endings.

### Run tests

Travis runs these too, but your PR will look better if all tests pass the
first time:

```
pub run test
dart test/validate_templates.dart
```

The `validate_templates.dart` test currently doesn't support the different line endings
on Windows machines and fails, so prefer using a Linux or Mac machine for contributing to this project.


## Resources

For more information on contributing to Dart, see the
[dart-lang/sdk Contributing page](https://github.com/dart-lang/sdk/wiki/Contributing).

<!-- Put link to dart-lang/site-www and other receptive repos here?-->

[Stagehand]: https://pub.dev/packages/stagehand
