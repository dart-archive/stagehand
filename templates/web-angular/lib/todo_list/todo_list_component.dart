// Copyright (c) __year__, __author__. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular_components/angular_components.dart';

import '../todo_list_service.dart';

@Component(
  selector: 'todo-list',
  styleUrls: const ['todo_list_component.css'],
  templateUrl: 'todo_list_component.html',
  directives: const [materialDirectives],
)
class TodoListComponent implements OnInit {
  final TodoListService todoListService;
  List<String> items = [];

  TodoListComponent(this.todoListService);

  ngOnInit() async => items = await todoListService.getTodoList();

  add(String description) => items.add(description);
  remove(int index) => items.removeAt(index);
  onReorder(ReorderEvent e) =>
      items.insert(e.destIndex, items.removeAt(e.sourceIndex));
}
