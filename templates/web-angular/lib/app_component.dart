// Copyright (c) __year__, __author__. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular_components/angular_components.dart';

import 'todo_list/todo_list_component.dart';
import 'todo_list_service.dart';

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [materialDirectives, TodoListComponent],
  providers: const [materialProviders, TodoListService],
)
class AppComponent {
  String todoItemDescription = '';

  @ViewChild('todoList')
  TodoListComponent todoList;

  bool get disableAdd => todoItemDescription.isEmpty;

  void addItem() {
    todoList.add(todoItemDescription);
    todoItemDescription = '';
  }
}
