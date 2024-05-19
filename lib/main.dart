import 'package:flutter/material.dart';
import 'to_do_task_list_page.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do',
      home: ToDoTaskListPage(),
    );
  }
}