

import 'package:flutter/cupertino.dart';
import 'package:mirea_7sem_flatter/pract10/api/tasks.dart';

class TaskInheritedWidget extends InheritedWidget{
  final List<Task> tasks;
  Future<List<Task>> Function([int]) fetchTasks;



  TaskInheritedWidget({super.key,
    required this.tasks,
    required this.fetchTasks,
    required super.child,
  });

  static TaskInheritedWidget? of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<TaskInheritedWidget>();
  }

  @override
  bool updateShouldNotify(TaskInheritedWidget oldWidget) {
    return oldWidget.tasks != tasks;
  }
  
}