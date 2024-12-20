import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'filter.dart';
import 'settings.dart';
import 'stats.dart';
import 'task_detail.dart';
import 'task_list.dart';

void main() {
  runApp(TaskApp());
}

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomePage(title: 'Task Manager'),
          routes: [
            GoRoute(
              path: 'task',
              builder: (context, state) => TaskListScreen(),
            routes: [
              GoRoute(
                path: 'detail',
                builder: (context, state) => const DetailScreen(),
              ),
            ]),
            ),
            GoRoute(
              path: 'filter',
              builder: (context, state) => FilterTasksScreen(),
            ),
            GoRoute(
              path: 'stats',
              builder: (context, state) => TaskStatsScreen(),
            ),
            GoRoute(
              path: 'settings',
              builder: (context, state) => UserSettingsScreen(),
            ),
            GoRoute(
              path: 'task/:task',
              builder: (context, state) {
                final task = state.pathParameters['task']!;
                return TaskDetailScreen(task: task);
              },
            ),
          ],
        ),
      ],
    );
    return MaterialApp.router(
      routerConfig: _router
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => context.go('/task'),
                child: const Text('Go to Task List'),
              ),
              ElevatedButton(
                onPressed: () => context.go('/filter'),
                child: const Text('Go to Filter Tasks'),
              ),
              ElevatedButton(
                onPressed: () => context.go('/stats'),
                child: const Text('Go to Task Stats'),
              ),
              ElevatedButton(
                onPressed: () => context.go('/settings'),
                child: const Text('Go to User Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
