import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'taskStarter.dart';

import 'logout.dart';
import 'task_detail.dart';
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
                onPressed: () => context.go('/tasks'),
                child: const Text('Задачи'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/logout'),
                child: const Text('Выход'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class MyRouter extends StatelessWidget {
  const MyRouter({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(title: 'Task Manager'),
          routes: [
            GoRoute(
              path: 'tasks',
              builder: (context, state) => const TaskStarter(),
                routes: [
                  GoRoute(
                    path: 'task/:name/:start/:end',
                    name: 'task',
                    builder: (context, state) {
                      var td = TaskData(
                        start: state.pathParameters['start']!,
                        end: state.pathParameters['end']!,
                        name: state.pathParameters['name']!,
                      );
                      return TaskDetailScreen(task: td);
                    },
                  ),
                ],
            ),
            GoRoute(
              path: '/logout',
              builder: (context, state) => const LogoutPage(),
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