import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do_app/models/todo_model.dart';

enum TodoListFilter {
  all,
  active,
  completed,
}

final todoListFilter = StateProvider((_) => TodoListFilter.all);

final todoListProvider =
    StateNotifierProvider<TodoController, List<TodoModel>>((ref) {
  return TodoController([]);
});

final filteredTodos = Provider<List<TodoModel>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todos = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.completed:
      return todos.where((todo) => todo.isCompleted).toList();
    case TodoListFilter.active:
      return todos.where((todo) => !todo.isCompleted).toList();
    case TodoListFilter.all:
      return todos;
  }
});

class TodoController extends StateNotifier<List<TodoModel>> {
  TodoController([List<TodoModel>? initialTodos]) : super(initialTodos ?? []);

  void add(String description) {
    state = [
      ...state,
      TodoModel(description: description),
    ];
  }

  void toggle(String id) {
    state = [
      for (final todoList in state)
        if (todoList.id == id)
          TodoModel(
            id: todoList.id,
            description: todoList.description,
            isCompleted: !todoList.isCompleted,
          )
        else
          todoList,
    ];
  }

  void edit({@required String? id, @required String? description}) {
    state = [
      for (final todoList in state)
        if (todoList.id == id)
          TodoModel(
            id: todoList.id,
            description: description,
            isCompleted: todoList.isCompleted,
          )
        else
          todoList,
    ];
  }

  void remove(TodoModel target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }
}
