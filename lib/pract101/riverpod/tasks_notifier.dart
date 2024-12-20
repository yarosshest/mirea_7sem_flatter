import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirea_7sem_flatter/pract101/riverpod/task.dart';

// Нотифайер, управляющий списком задач.
class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super([]);

  void addTask(String description) {
    state = [...state, Task(description: description)];
  }

  void toggleTaskCompletion(int index) {
    final updatedTask = state[index].copyWith(isCompleted: !state[index].isCompleted);
    final newState = [...state];
    newState[index] = updatedTask;
    state = newState;
  }

  void removeTask(int index) {
    final newState = [...state]..removeAt(index);
    state = newState;
  }
}

// Провайдер, который будет доступен глобально для управления задачами
final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  return TasksNotifier();
});
