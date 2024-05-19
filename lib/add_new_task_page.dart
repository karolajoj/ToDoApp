import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'task.dart';
import 'task_provider.dart';

class AddNewTaskPage extends ConsumerStatefulWidget {
  final Task? task;

  const AddNewTaskPage({super.key, this.task});

  @override
  ConsumerState<AddNewTaskPage> createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends ConsumerState<AddNewTaskPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _taskController;

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController(text: widget.task?.title ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Container(
          color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: 'Task',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a task';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5))),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Sprawdzenie, czy formularz jest poprawnie wypełniony
                          if (_formKey.currentState!.validate()) {
                            final taskProvider = ref.read(taskListProvider.notifier);

                            // Sprawdzenie, czy zadanie jest nowe
                            if (widget.task == null) {
                              // Dodanie nowego zadania z tytułem z kontrolera tekstowego
                              taskProvider.addTask(Task(title: _taskController.text));
                            } else {
                              // Aktualizacja istniejącego zadania z nowym tytułem z kontrolera tekstowego
                              taskProvider.updateTask(widget.task!..title = _taskController.text);
                            }
                            
                            Navigator.pop(context);
                          }
                        },
                        child: Text(widget.task == null ? 'Add' : 'Save'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      )
    ;
  }
}