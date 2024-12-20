import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'dart:convert';
import 'package:mirea_7sem_flatter/pract8/api/tasks.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;

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
  File? _selectedImage;
  Uint8List? _webImageData;
  bool _isUploadingPhoto = false;
  final TaskApi taskApi = TaskApi();

  @override
  void initState() {
    super.initState();
    _fetchTaskDetails();
  }

  Future<void> _fetchTaskDetails() async {
    try {
      final response = await taskApi.fetchTaskDetailsRequest(widget.taskId);

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
      final response = await taskApi.updateTaskRequest(
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
      final response = await taskApi.deleteTaskRequest(widget.taskId);

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

  Widget buildTaskPhoto(int taskId) {
    return FutureBuilder<List<String>?>(
      future: taskApi.getTaskPhotoRequest(taskId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
          return Center(child: Text("No photos available"));
        } else {
          // Display a list of images
          return Column(
            children: snapshot.data!.map((imageUrl) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) {
                    print(error);
                    return Icon(Icons.error);
                  },
                  // Optional: Set image height and width
                  // height: 100,
                  // width: 100,
                  fit: BoxFit.cover, // Adjust as needed
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }

  Future<void> _pickImage() async {
    if (kIsWeb) {
      _webImageData = await ImagePickerWeb.getImageAsBytes();
      setState(() {}); // Update UI with selected image
    } else {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
        setState(() {}); // Update UI with selected image
      }
    }
    await _uploadPhoto();
  }

  Future<void> _uploadPhoto() async {
    if (_selectedImage == null && _webImageData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No photo selected')));
      return;
    }

    final response = await taskApi.uploadTaskPhoto(
      widget.taskId,
      _selectedImage,
      _webImageData,
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Photo uploaded successfully')));
      _fetchTaskDetails(); // Refresh task details after upload
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload photo')));
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
              child: ListView(
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
                  buildTaskPhoto(widget.taskId),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('Upload Photo'),
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
