import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

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

// Future<Response> fetchTaskDetailsRequest(int taskId)  {
//   late Future<SharedPreferences> prefs_f = SharedPreferences.getInstance().then((prefs){
//     return prefs;
//   });
//   late String? token;
//   Future.wait([prefs_f]).then((res) {
//     token = res[0].getString('access_token');
//   });
//   final url = Uri.http(host, "tasks/$taskId");
//
//   return http.get(
//       url,
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       }
//   ).then((res) {
//     return res;
//   });
// }

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
}
