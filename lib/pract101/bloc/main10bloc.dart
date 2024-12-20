import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirea_7sem_flatter/pract101/bloc/app_bloc_observer.dart';
import 'package:mirea_7sem_flatter/pract101/bloc/tasks_cubit.dart';
import 'package:mirea_7sem_flatter/pract101/bloc/tasks_page.dart';


void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasks App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => TasksCubit(),
        child: TasksPage(),
      ),
    );
  }
}
