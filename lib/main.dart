import 'package:flutter/material.dart';
import 'package:todo_app/task_form_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO List'),
      ),
      body: const Center(
        child: Text('Lista zadań będzie tutaj'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          const TaskFormPage();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}