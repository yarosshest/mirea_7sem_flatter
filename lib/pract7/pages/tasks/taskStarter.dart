import 'package:flutter/material.dart';
import 'package:mirea_7sem_flatter/pract7/api/tasks.dart';
import 'package:mirea_7sem_flatter/pract7/pages/tasks/task_add.dart';
import 'package:mirea_7sem_flatter/pract7/pages/tasks/task_detail.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final ScrollController _scrollController = ScrollController();
  int _page = 0;
  late Future<List<Task>> _tasksFuture;
  List<Task> _tasks = [];
  bool _isLoading = false;
  bool _hasMoreTasks = true;
  final TaskApi taskApi = TaskApi();

  @override
  void initState() {
    super.initState();
    _loadTasks();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading && _hasMoreTasks) {
        _loadTasks();
      }
    });
  }

  Future<void> _loadTasks() async {
    setState(() {
      _isLoading = true;
    });

    // Fetch next page of tasks
    final newTasks = await taskApi.fetchTasks(
        _page); // Assume `fetchTasks` accepts a `page` parameter
    setState(() {
      if (newTasks.isNotEmpty) {
        _tasks.addAll(newTasks);
        _page++;
      } else {
        _hasMoreTasks = false;
      }
      _isLoading = false;
    });
  }

  Future<void> _refreshTasks() async {
    setState(() {
      _tasks.clear();
      _page = 0;
      _hasMoreTasks = true;
    });
    await _loadTasks();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskPage()),
          );
          if (result == true) {
            _refreshTasks();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshTasks,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _tasks.length + (_hasMoreTasks ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == _tasks.length) {
              return const Center(child: CircularProgressIndicator());

            }

            final task = _tasks[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetailPage(taskId: task.id),
                  ),
                ).then((_) => _refreshTasks());
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
      ),
    );
  }
}
