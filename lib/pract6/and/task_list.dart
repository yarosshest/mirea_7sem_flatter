import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'task_detail.dart';


class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TaskListScreen> {
  List<String> _tasks = ['Задача 1', 'Задача 2', 'Задача 3'];
  final TextEditingController _textController = TextEditingController();
  void _addTask() {
    if (_textController.text.isNotEmpty) {
      setState(() {_tasks.add(_textController.text); _textController.clear();});
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(controller: _textController,
              decoration: const InputDecoration(labelText: 'Add a task', border: OutlineInputBorder()),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: _addTask, child: Text('Добавить задачу')),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_tasks[index]),
                  trailing: const Icon(Icons.arrow_forward),
                  // onTap: () => Navigator.pushReplacement(context, "/task/${_tasks[index]}"),
                  onTap: () => context.go("/task?name=${}")
                );
              },
            ),
          ),
          // ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Назад')),
          ElevatedButton(onPressed: () => context.go("/"), child: const Text('Назад')),
        ],
      ),
    );
  }
}
