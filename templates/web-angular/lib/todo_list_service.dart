import 'dart:async';

import 'package:angular2/core.dart';

/// Mock service granting access to a todo list. It emulates accessing
/// the list from a server by returning the list asynchronously.
@Injectable()
class TodoListService {
  List<String> mockTodoList = <String>[
    'Feed the cats',
    'Walk the dogs',
  ];

  Future<List<String>> getTodoList() async => mockTodoList;

  Future<List<String>> getTodoListSlowly() {
    return new Future<List<String>>.delayed(
        const Duration(seconds: 3), getTodoList);
  }
}
