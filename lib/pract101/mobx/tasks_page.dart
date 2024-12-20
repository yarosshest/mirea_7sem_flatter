import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart'; // Можно использовать Provider для получения Store
import 'tasks_store.dart';

class TasksPage extends StatelessWidget {
  TasksPage({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Получаем доступ к нашему store
    final tasksStore = Provider.of<TasksStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Список задач (MobX)'),
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
                      tasksStore.addTask(_controller.text);
                      _controller.clear();
                    }
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                if (tasksStore.tasks.isEmpty) {
                  return const Center(child: Text('Нет задач'));
                }
                return ListView.builder(
                  itemCount: tasksStore.tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasksStore.tasks[index];
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
                          tasksStore.toggleTaskCompletion(index);
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          tasksStore.removeTask(index);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
