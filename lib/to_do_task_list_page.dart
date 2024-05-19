import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'task_provider.dart';
import 'add_new_task_page.dart';

class ToDoTaskListPage extends ConsumerWidget {
  const ToDoTaskListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(taskListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
        child: ListView.builder(
          itemCount: taskList.length,
          itemBuilder: (context, index) {
            final task = taskList[index];
            return ListTile(
              leading: Checkbox(
                value: task.isDone,
                onChanged: (bool? value) {
                  ref.read(taskListProvider.notifier).toggleTask(task);
                },
              ),
              title: Text(
                task.title,
                style: TextStyle(
                  decoration: task.isDone ? TextDecoration.lineThrough : null, // Przekreślenie tekstu
                  color: task.isDone ? Colors.grey : null, // Wyszarzenie kolor tekstu
                ),
              ),
              tileColor: task.isDone ? Theme.of(context).colorScheme.inversePrimary.withOpacity(0.3) : null, // Zmiana koloru tła wykonanego zadania
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  ref.read(taskListProvider.notifier).removeTask(task);
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNewTaskPage(task: task),), // Edytowanie zadania
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNewTaskPage()), // Dodawanie nowego zadania
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}