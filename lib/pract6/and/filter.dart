import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class FilterTasksScreen extends StatefulWidget {
  const FilterTasksScreen({super.key});

  @override
  State<FilterTasksScreen> createState() => _FilterTasksScreenState();
}

class _FilterTasksScreenState extends State<FilterTasksScreen> {
  bool _showCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Детали задачи')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SwitchListTile(
              title: const Text('Показать выполненные задачи'),
              value: _showCompleted,
              onChanged: (bool value) => setState(() => _showCompleted = value),
            ),
            SizedBox(height: 10),
            Text(
              _showCompleted
                  ? 'Показаны выполненные задачи'
                  : 'Показаны невыполненные задачи',
              style: const TextStyle(fontSize: 18),
            ),
            // ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Назад')),
            ElevatedButton(onPressed: () => context.go("/"), child: const Text('Назад')),
          ],
        ),
      ),
    );
  }
}