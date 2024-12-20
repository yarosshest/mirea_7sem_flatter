import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirea_7sem_flatter/pract10/api/tasks.dart';
import 'package:mirea_7sem_flatter/pract10/bloc/events.dart';
import 'package:mirea_7sem_flatter/pract10/bloc/task_bloc.dart';
import 'package:mirea_7sem_flatter/pract10/bloc/taskStarter.dart';
import 'package:mirea_7sem_flatter/pract10/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void setupLocator(){
  getIt.registerSingleton<TaskApi>(TaskApi());
}

void main() {
  setupLocator();
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({Key? key}) : super(key: key);

  Future<Widget> _determineStartPage() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    if (token != null) {
      return BlocProvider(
        create: (_) => TaskBloc(TaskApi())..add(FetchTasks()),
        child: const TaskListPage(),
      );
    } else {
      return const LoginPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: FutureBuilder<Widget>(
        future: _determineStartPage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return const Scaffold(
              body: Center(child: Text('An error occurred')),
            );
          } else {
            return snapshot.data!;
          }
        },
      ),
    );
  }
}