import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tasks_store.dart';
import 'tasks_page.dart';

void main() {
  runApp(
    Provider(
      create: (_) => TasksStore(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasks App (MobX)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TasksPage(),
    );
  }
}
