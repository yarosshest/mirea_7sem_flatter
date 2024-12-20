import 'package:flutter/material.dart';
import 'package:mirea_7sem_flatter/pract10/api/tasks.dart';
import 'package:mirea_7sem_flatter/pract10/pages/hellow.dart';

void main() {
  setupLocator();
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pract 10 ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HellowPage(),
    );
  }
}