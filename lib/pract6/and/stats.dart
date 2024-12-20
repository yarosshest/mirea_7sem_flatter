import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class TaskStatsScreen extends StatelessWidget {
  final int _completedTasks = 5;
  final int _pendingTasks = 3;
  const TaskStatsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(title: const Text('Детали задачи')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Статистика выполнения задач', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Выполнено: $_completedTasks', style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 20),
                  Text('Невыполнено: $_pendingTasks', style: const TextStyle(fontSize: 18)),
                ],
              ),
              // ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Назад')),
              ElevatedButton(onPressed: () => context.go("/"), child: const Text('Назад')),
            ],
          ),
        ),
      ),
    );
  }
}

