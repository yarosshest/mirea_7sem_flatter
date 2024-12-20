import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mirea_7sem_flatter/pract6/pages/task_detail.dart';


class TaskStarter extends StatefulWidget {
  const TaskStarter({ super.key });
  @override
  State<TaskStarter> createState() => _TaskStarterState();
}
class _TaskStarterState extends State<TaskStarter> {
  final List<Widget> _tasks = [];
  final List<TaskData> _dataTasks = [];

  Future<void> runTask(int id,Duration dur) async {

    await Future.delayed(dur);

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
    var dur = const Duration(seconds: 60);
    var td = TaskData(
      start: DateTime.now().toString(),
      end: DateTime.now().add(dur).toString(),
      name: id.toString(),
    );
    _dataTasks.add(td);

    setState(() {
      _tasks.add(
        ElevatedButton(onPressed: () => context.goNamed(
            'task',
            pathParameters: {
              'name': td.name,
              'start': td.start,
              'end': td.end}),
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all(),
                    borderRadius: BorderRadius.circular(6)),
                child: Text("Задача номер $id в работе",
                  style: const TextStyle(color: Colors.amber),)))
        );
    });
    runTask(id, dur);
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
            ElevatedButton(onPressed: () => context.go("/"), child: const Text('Назад')),
          ],
        )
    ),),);
  }
}


