import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirea_7sem_flatter/pract101/bloc/task.dart';
import 'package:mirea_7sem_flatter/pract101/bloc/tasks_cubit.dart';

class TasksPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      context.read<TasksCubit>().addTask(_controller.text);
                      _controller.clear();
                    }
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TasksCubit, List<Task>>(
              builder: (context, tasks) {
                if (tasks.isEmpty) {
                  return const Center(child: Text('Нет задач'));
                }

                return ListView.builder(
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
                          context.read<TasksCubit>().toggleTaskCompletion(index);
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<TasksCubit>().removeTask(index);
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
