import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'task.dart';
import 'package:hive/hive.dart';

final taskListProvider = StateNotifierProvider<TaskListNotifier, List<Task>>((ref) {
  return TaskListNotifier();
});

class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier() : super([]) {
    _loadTasks();
  }

  void addTask(Task task) {
    // [...state, task] tworzy nową listę, która zawiera wszystkie elementy obecnej listy (...state) oraz nowe zadanie jako ostatni element (task).
    state = [...state, task];
    _saveTasks();
  }

  void removeTask(Task task) {
    // Filtrowanie listy zadań, zachowując tylko elementy różne od usuwanego zadania.
    state = state.where((t) => t != task).toList();
    _saveTasks();
  }

  void toggleTask(Task task) {
    task.isDone = !task.isDone;
    // Aktualizacja stanu poprzez umieszczenie nieukończonych zadań przed ukończonymi.
    state = [
      ...state.where((t) => !t.isDone),
      ...state.where((t) => t.isDone),
    ];
    _saveTasks();
  }

  void updateTask(Task task) {
    // Stworzenie nowej listy zadań, zamieniając zadanie t na zaktualizowane zadanie, jeśli są równe.
    state = [
      for (final t in state) if (t == task) task else t
    ];
    _saveTasks();
  }

  Future<void> _saveTasks() async {
    final box = await Hive.openBox<Task>('tasks');
    await box.clear(); // Wyczyszczenie box przed zapisaniem nowych zadań.
    for (final task in state) {
      box.add(task);
    }
  }

  Future<void> _loadTasks() async {
    final box = await Hive.openBox<Task>('tasks');
    state = box.values.toList();
  }
}