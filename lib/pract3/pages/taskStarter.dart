import 'package:flutter/material.dart';

import 'main.dart';

class TaskStarter extends StatefulWidget {
  const TaskStarter({ super.key });
  @override
  State<TaskStarter> createState() => _TaskStarterState();
}
class _TaskStarterState extends State<TaskStarter> {
  final List<Widget> _tasks = [];

  Future<void> runTask(int id) async {
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _tasks[id] = Container(
          padding: EdgeInsets.all(10),
      decoration: BoxDecoration(border: Border.all(),
      borderRadius: BorderRadius.circular(6)),
      child: Text("Задача номер $id выполнена",
        style: const TextStyle(color: Colors.green)));
    });
  }

  void startTask() {
    var id = _tasks.length;

    setState(() {
      _tasks.add(
          Container(
            padding: EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border.all(),
              borderRadius: BorderRadius.circular(6)),
              child: Text("Задача номер $id в работе",
        style: const TextStyle(color: Colors.amber),)));
    });
    runTask(id);
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: Center(child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () { startTask(); },
                child: const Text("Запустить задачу"),),
              SizedBox(width: 20,),
              Text("Запущенно ${_tasks.length} задач")
            ]
            ),
            const SizedBox(height: 16), // Space between button and task list
            if (_tasks.isNotEmpty) Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _tasks,
                ),
              ),
            ),
          ],
        )
    ),),);
  }
}


