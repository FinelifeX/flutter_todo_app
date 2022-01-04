import 'package:flutter/material.dart';

class Todo {
  UniqueKey id;
  String title;
  String description;
  bool isComplete;

  Todo(
      {required this.title,
      required this.description,
      required this.isComplete})
      : id = UniqueKey();
}
