import 'package:flutter/material.dart';
import 'package:flutter_todo_app/todo.dart';
import 'package:flutter_todo_app/todo_screen.dart';

class TodoList extends StatelessWidget {
  final List<Todo> _todos;
  final void Function(UniqueKey id) onRemoveItem;
  final void Function(Todo todo) onUpdateItem;

  const TodoList(
      {Key? key,
      required items,
      required this.onRemoveItem,
      required this.onUpdateItem})
      : _todos = items,
        super(key: key);

  void onItemPress(BuildContext context, Todo todo) async {
    var updatedTodo = await Navigator.push<Todo>(
        context,
        MaterialPageRoute(
            builder: (context) => TodoScreen(
                  todo: todo,
                )));

    if (updatedTodo != null) onUpdateItem(updatedTodo);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, idx) {
          final item = _todos[idx];

          return Column(children: [
            ListTile(
              title: Text(
                item.title,
                style: TextStyle(
                    decoration:
                        item.isComplete ? TextDecoration.lineThrough : null),
              ),
              subtitle:
                  item.description.isNotEmpty ? Text(item.description) : null,
              leading: Checkbox(
                value: item.isComplete,
                onChanged: (value) {
                  item.isComplete = value!;

                  onUpdateItem(item);
                },
              ),
              trailing: TextButton(
                child: Icon(Icons.delete_rounded, color: Colors.red.shade800),
                onPressed: () => onRemoveItem(item.id),
              ),
              onTap: () {
                onItemPress(context, item);
              },
            ),
            const Divider(
              thickness: 1,
            )
          ]);
        });
  }
}
