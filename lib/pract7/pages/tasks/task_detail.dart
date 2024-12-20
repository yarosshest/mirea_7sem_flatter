import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mirea_7sem_flatter/pract8/api/tasks.dart';

class TaskDetailPage extends StatefulWidget {
  final int taskId;
  const TaskDetailPage({Key? key, required this.taskId})
      : super(key: key);

  @override
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = true;
  bool _isUpdating = false;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _fetchTaskDetails();
  }

  Future<void> _fetchTaskDetails() async {
    try {
      final response = await fetchTaskDetailsRequest(widget.taskId);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _titleController.text = data['title'];
          _descriptionController.text = data['description'] ?? '';
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load task');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $error')));
    }
  }

  Future<void> _updateTask() async {
    setState(() => _isUpdating = true);

    try {
      final response = await updateTaskRequest(
          widget.taskId, _titleController.text, _descriptionController.text);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Task updated successfully')));
      } else {
        throw Exception('Failed to update task');
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $error')));
    } finally {
      setState(() => _isUpdating = false);
    }
  }

  Future<void> _deleteTask() async {
    setState(() => _isDeleting = true);

    try {
      final response = await deleteTaskRequest(widget.taskId);

      if (response.statusCode == 200) {
        Navigator.pop(
            context, true); // Return to previous page with success signal
      } else {
        throw Exception('Failed to delete task');
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $error')));
    } finally {
      setState(() => _isDeleting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _isDeleting ? null : _deleteTask,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
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
                  _isUpdating
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _updateTask,
                          child: const Text('Update Task'),
                        ),
                ],
              ),
            ),
    );
  }
}
