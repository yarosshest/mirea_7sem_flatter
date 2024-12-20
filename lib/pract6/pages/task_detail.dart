


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaskData{
  final String start;
  final String end;
  final String name;
  const TaskData({required this.start, required this.end, required this.name});
}

class TaskDetailScreen extends StatefulWidget {
  final  TaskData task;
  const TaskDetailScreen({ super.key, required this.task });
  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}
class _TaskDetailScreenState extends State<TaskDetailScreen> {

  @override
  Widget build(BuildContext context) {
    return Material(child: Center(child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.task.name),
            const SizedBox(height: 16),
            Text("Начало задачи ${widget.task.start}"),
            const SizedBox(height: 16),
            Text("Конец задачи ${widget.task.end}"),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: () => context.go("/tasks"), child: const Text('Назад')),
          ],
        )
    ),),);
  }
}