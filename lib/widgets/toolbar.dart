import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do_app/controllers/todo_controller.dart';

final addTodoKey = UniqueKey();
final activeFilterKey = UniqueKey();
final completedFilterKey = UniqueKey();
final allFilterKey = UniqueKey();

class Toolbar extends HookConsumerWidget {
  const Toolbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(todoListFilter);

    Color? textColorFor(TodoListFilter value) {
      return filter == value ? Colors.blue : Colors.black;
    }

    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Tooltip(
            key: allFilterKey,
            message: 'All todos',
            child: TextButton(
              onPressed: () =>
                  ref.read(todoListFilter.notifier).state = TodoListFilter.all,
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor:
                    MaterialStateProperty.all(textColorFor(TodoListFilter.all)),
              ),
              child: const Text('All'),
            ),
          ),
          Tooltip(
            key: activeFilterKey,
            message: 'Only uncompleted todos',
            child: TextButton(
              onPressed: () => ref.read(todoListFilter.notifier).state =
                  TodoListFilter.active,
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor: MaterialStateProperty.all(
                  textColorFor(TodoListFilter.active),
                ),
              ),
              child: const Text('Active'),
            ),
          ),
          Tooltip(
            key: completedFilterKey,
            message: 'Only completed todos',
            child: TextButton(
              onPressed: () => ref.read(todoListFilter.notifier).state =
                  TodoListFilter.completed,
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor: MaterialStateProperty.all(
                  textColorFor(TodoListFilter.completed),
                ),
              ),
              child: const Text('Completed'),
            ),
          ),
        ],
      ),
    );
  }
}
