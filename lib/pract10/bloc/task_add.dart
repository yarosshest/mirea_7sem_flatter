import 'package:flutter/material.dart';
import 'package:mirea_7sem_flatter/pract10/api/tasks.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;
  String? _responseMessage;
  final TaskApi taskApi = TaskApi();

  Future<void> addTask() async {

    try {
      final response = await taskApi.addTaskRequest(_titleController.text,
          _descriptionController.text);


      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          _responseMessage = "Task added successfully!";
          _titleController.clear();
          _descriptionController.clear();
        });
      } else {
        setState(() {
          _responseMessage = "Failed to add task: ${response.body}";
        });
      }
    } catch (error) {
      setState(() {
        _responseMessage = "An error occurred: $error";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : addTask,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Add Task'),
            ),
            if (_responseMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                _responseMessage!,
                style: TextStyle(
                  color: _responseMessage == "Task added successfully!"
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
