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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, idx) {
          final item = _todos[idx];

          return Column(children: [
            ListTile(
              leading: Checkbox(value: item.isComplete, onChanged: null),
              title: Text(item.title),
              subtitle: Text(item.description),
              trailing: TextButton(
                child: Icon(Icons.delete_rounded, color: Colors.red.shade800),
                onPressed: () => onRemoveItem(item.id),
              ),
              onTap: () {
                onUpdateItem(item);
              },
            ),
            const Divider()
          ]);
        });
  }
}
