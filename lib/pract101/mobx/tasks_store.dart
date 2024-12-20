import 'package:mobx/mobx.dart';
import 'task.dart';

part 'tasks_store.g.dart'; // сгенерированный файл

class TasksStore = _TasksStore with _$TasksStore;

abstract class _TasksStore with Store {
  @observable
  ObservableList<Task> tasks = ObservableList<Task>();

  @action
  void addTask(String description) {
    tasks.add(Task(description: description));
  }

  @action
  void toggleTaskCompletion(int index) {
    final task = tasks[index];
    tasks[index] = task.copyWith(isCompleted: !task.isCompleted);
  }

  @action
  void removeTask(int index) {
    tasks.removeAt(index);
  }
}
