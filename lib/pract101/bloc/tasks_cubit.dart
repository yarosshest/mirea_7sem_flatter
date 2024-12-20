import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mirea_7sem_flatter/pract101/bloc/task.dart';

// Состояние Cubit будет просто списком задач.
class TasksCubit extends Cubit<List<Task>> {
  TasksCubit() : super([]);

  void addTask(String description) {
    final newTask = Task(description: description);
    emit([...state, newTask]);
  }

  void toggleTaskCompletion(int index) {
    final updatedTask = state[index].copyWith(isCompleted: !state[index].isCompleted);
    final newState = [...state];
    newState[index] = updatedTask;
    emit(newState);
  }

  void removeTask(int index) {
    final newState = [...state]..removeAt(index);
    emit(newState);
  }
}
