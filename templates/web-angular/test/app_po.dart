import 'dart:async';

import 'package:pageloader/objects.dart';

class AppPO {
  @ByTagName('h1')
  PageLoaderElement _title;

  @ByTagName('h2')
  @optional
  PageLoaderElement _greeting;

  @ByTagName('input')
  PageLoaderElement _input;

  @FirstByCss('material-button')
  PageLoaderElement _sayHello;

  @ByTagName('tab-button')
  List<PageLoaderElement> _tabs;

  @ByCss('tab-button.active')
  PageLoaderElement _activeTabName;

  Future<String> get title => _title.visibleText;

  Future<Null> sayHello() => _sayHello.click();

  Future<String> get greeting => _greeting?.visibleText;

  Future type(String s) => _input.type(s);

  Future<String> get activeTabName => _activeTabName.visibleText;

  Future<List<String>> get tabNames =>
      _inIndexOrder(_tabs.map((el) => el.visibleText)).toList();
}

Stream<T> _inIndexOrder<T>(Iterable<Future<T>> futures) async* {
  for (var x in futures) yield await x;
}
