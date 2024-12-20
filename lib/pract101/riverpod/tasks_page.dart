import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'task.dart';        // ваш файл с классом Task
import 'tasks_notifier.dart'; // ваш файл с tasksProvider

class TasksPage extends ConsumerWidget {
  TasksPage({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Получаем текущее состояние списка задач
    final tasks = ref.watch(tasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Список задач'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Описание задачи',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      // Читаем провайдер без подписки и вызываем метод добавления задачи
                      ref.read(tasksProvider.notifier).addTask(_controller.text);
                      _controller.clear();
                    }
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: tasks.isEmpty
                ? const Center(child: Text('Нет задач'))
                : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(
                    task.description,
                    style: TextStyle(
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (_) {
                      ref.read(tasksProvider.notifier).toggleTaskCompletion(index);
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      ref.read(tasksProvider.notifier).removeTask(index);
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
