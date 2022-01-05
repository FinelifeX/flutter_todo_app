import 'package:flutter/material.dart';
import 'package:flutter_todo_app/todo.dart';

class TodoScreen extends StatefulWidget {
  final Todo? todo;

  const TodoScreen({Key? key, this.todo}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  bool _isComplete = false;

  @override
  void initState() {
    _title = widget.todo?.title ?? '';
    _description = widget.todo?.description ?? '';
    _isComplete = widget.todo?.isComplete ?? false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add new To Do'),
        ),
        body: ListView(children: [
          Container(
            padding: const EdgeInsets.all(32),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextFormField(
                      initialValue: _title,
                      decoration: const InputDecoration(
                          label: Text('Title'),
                          hintText: 'What\'s the name of the task?',
                          border: OutlineInputBorder()),
                      maxLength: 50,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required!';
                        }

                        return null;
                      },
                      onSaved: (newValue) {
                        _title = newValue ?? '';
                      },
                    ),
                  ),
                  Container(
                      child: TextFormField(
                    initialValue: _description,
                    decoration: const InputDecoration(
                        label: Text('Description'),
                        hintText: 'A few words about the task...',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder()),
                    maxLength: 120,
                    minLines: 2,
                    maxLines: null,
                    onSaved: (value) {
                      _description = value ?? '';
                    },
                  )),
                  Container(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: FormField<bool>(
                      initialValue: _isComplete,
                      onSaved: (newValue) {
                        _isComplete = newValue ?? false;
                      },
                      builder: (field) {
                        return CheckboxListTile(
                          value: field.value,
                          tristate: false,
                          onChanged: field.didChange,
                          title: const Text('Is already complete'),
                          controlAffinity: ListTileControlAffinity.leading,
                          visualDensity: VisualDensity.compact,
                          contentPadding: const EdgeInsets.all(0),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Todo resultingTodo;

                        if (widget.todo == null) {
                          resultingTodo = Todo(
                              title: _title,
                              description: _description,
                              isComplete: _isComplete);
                        } else {
                          resultingTodo = widget.todo!;
                          resultingTodo.title = _title;
                          resultingTodo.description = _description;
                          resultingTodo.isComplete = _isComplete;
                        }

                        Navigator.pop<Todo>(context, resultingTodo);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.todo == null
                                      ? 'Created item succesfully!'
                                      : 'Updated item succesfully!')
                                ],
                              )),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green.shade700,
                                  )
                                ],
                              )
                            ],
                          ),
                        ));
                      }
                    },
                    child: widget.todo == null
                        ? const Text('CREATE TODO')
                        : const Text('UPDATE TODO'),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48)),
                  ),
                ],
              ),
            ),
          )
        ]));
  }
}
