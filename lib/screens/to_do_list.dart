import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do_app/controllers/todo_controller.dart';
import 'package:to_do_app/widgets/toolbar.dart';

class ToDoList extends HookConsumerWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(filteredTodos);
    final todoListNotifier = ref.read(todoListProvider.notifier);
    final newTodoController = useTextEditingController();

    return Scaffold(
      body: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: newTodoController,
                  decoration: const InputDecoration(
                    labelText: 'What needs to be done',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    todoListNotifier.add(newTodoController.text);
                    newTodoController.clear();
                  },
                  child: const Text('Add new task'),
                ),
                const Toolbar(),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: ValueKey(todos[index].id),
                        onDismissed: (_) {
                          todoListNotifier.remove(todos[index]);
                        },
                        child: ListTile(
                          leading: Checkbox(
                            onChanged: (bool? value) =>
                                todoListNotifier.toggle(todos[index].id),
                            value: todos[index].isCompleted,
                          ),
                          title: Text(todos[index].description!),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
