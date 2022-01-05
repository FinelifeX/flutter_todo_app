import 'package:flutter/material.dart';
import 'package:flutter_todo_app/todo.dart';
import 'package:flutter_todo_app/todo_list.dart';
import 'package:flutter_todo_app/todo_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final _todos = <Todo>[];

  void onRemoveTodo(UniqueKey id) {
    setState(() {
      _todos.removeWhere((element) => element.id == id);
    });
  }

  void onAddTodo(Todo todo) async {
    setState(() {
      _todos.add(todo);
    });
  }

  void onUpdateTodo(Todo todo) async {
    setState(() {
      _todos[_todos.indexWhere((element) => todo.id == element.id)] = todo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('To Do List'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const TodoScreen()));
          },
          child: const Icon(Icons.create_outlined),
          tooltip: 'Add new To Do item',
        ),
        body: _todos.isEmpty
            ? Container(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'No items yet',
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 8),
                          child: const Text('How about creating one?',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 18)),
                        )
                      ],
                    ),
                  ],
                ))
            : TodoList(
                items: _todos,
                onRemoveItem: onRemoveTodo,
                onUpdateItem: onUpdateTodo,
              ));
  }
}
