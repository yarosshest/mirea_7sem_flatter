import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:image_picker_web/image_picker_web.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Task {
  final int id;
  final String title;
  final String? description;

  Task({required this.id, required this.title, this.description});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}

final getIt =GetIt.instance;

void setupLocator(){
  getIt.registerSingleton<TaskApi>(TaskApi());
}

class TaskApi {
  final String host = "localhost:60106";

  Future<List<Task>> fetchTasks([int page = 0]) async {
    final prefs = await SharedPreferences.getInstance();
    var token = (prefs.getString('access_token'))!;

    final url = Uri.http(host, "tasks",
        {'skip': '${page * 10}'}); // Replace with your FastAPI URL
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token', // Replace with actual token
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> taskJson = json.decode(response.body);
      return taskJson.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<Response> addTaskRequest(String title, String description) async {
    final prefs = await SharedPreferences.getInstance();
    var token = (prefs.getString('access_token'))!;
    final url = Uri.http(host, "tasks");

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'title': title,
        'description': description,
      }),
    );

    return response;
  }

  Future<Response> fetchTaskDetailsRequest(int taskId) async {
    final prefs = await SharedPreferences.getInstance();
    var token = (prefs.getString('access_token'))!;
    final url = Uri.http(host, "tasks/$taskId");

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });

    return response;
  }

  Future<Response> updateTaskRequest(
      int taskId, String title, String description) async {
    final prefs = await SharedPreferences.getInstance();
    var token = (prefs.getString('access_token'))!;
    final url = Uri.http(host, "tasks/$taskId");

    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'title': title,
        'description': description,
      }),
    );

    return response;
  }

  Future<Response> deleteTaskRequest(int taskId) async {
    final prefs = await SharedPreferences.getInstance();
    var token = (prefs.getString('access_token'))!;
    final url = Uri.http(host, "tasks/$taskId");

    final response = await http.delete(url, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });

    return response;
  }

  Future<List<String>?> getTaskPhotoRequest(int taskId) async {
    final prefs = await SharedPreferences.getInstance();
    var token = (prefs.getString('access_token'))!;
    final url = Uri.http(host, "tasks/$taskId/photos");

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      List<dynamic> photosJson = json.decode(response.body);
      if (photosJson.isNotEmpty) {
        List<String>ret = [];
        for (var photo in photosJson){
          ret.add(photo['url']);
        }
        return ret;
      }
    }
    return null;
  }

  Future<http.Response> uploadTaskPhoto(int taskId, File? photo, Uint8List? webPhoto) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token')!;
    final url = Uri.http(host, "tasks/$taskId/photos");

    // Create the multipart request
    final request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..headers['Content-Type'] =  'multipart/form-data';

    // Add the file to the request based on platform
    if (kIsWeb && webPhoto != null) {
      // Web: Add image as bytes
      request.files.add(http.MultipartFile.fromBytes(
        'file',
        webPhoto,
        filename: 'upload.jpg',
        contentType: MediaType('image', 'jpeg'),
      ));
    } else if (photo != null) {
      // Mobile: Add image from file path
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        photo.path,
        contentType: MediaType('image', 'jpeg'),
      ));
    } else {
      throw Exception("No file selected");
    }

    // Send the request and wait for the response
    final response = await request.send();
    return await http.Response.fromStream(response);
  }
}
