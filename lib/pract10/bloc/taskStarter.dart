import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirea_7sem_flatter/pract10/bloc/task_add.dart';
import 'package:mirea_7sem_flatter/pract10/pages/tasks/task_detail.dart';
import '../bloc/task_bloc.dart';
import '../bloc/events.dart';
import '../bloc/states.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task List')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskPage()),
          );
          if (result == true) {
            context.read<TaskBloc>().add(FetchTasks());
          }
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            final tasks = state.tasks;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<TaskBloc>().add(FetchTasks());
              },
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailPage(taskId: task.id),
                        ),
                      ).then((_) => context.read<TaskBloc>().add(FetchTasks()));
                    },
                    child: Card(
                      color: Colors.blueAccent,
                      child: ListTile(
                        title: Text(task.title),
                        subtitle: Text(task.description ?? 'No description'),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is TaskError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No tasks available.'));
          }
        },
      ),
    );
  }
}