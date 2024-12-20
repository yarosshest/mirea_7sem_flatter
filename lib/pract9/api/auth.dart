import 'package:http/http.dart' as http;
import 'package:http/http.dart';

String host = "localhost:60106";


Future<Response> registerUser(String username, String password) async {
  final url = Uri.http(host, "auth/register"); // Update with your API URL

  final response = await http.post(
    url,
    headers: {
      'accept':' application/json',
      'Content-Type': 'application/x-www-form-urlencoded', // Necessary for form data
    },
    body: {
      'login': username,
      'password': password,
    },
  );

  return response;
}

Future<Response> loginUser(String username, String password) async {
  final url = Uri.http(host, "auth/login"); // Update with your API URL

  final response = await http.post(
    url,
    headers: {
      'accept':' application/json',
      'Content-Type': 'application/x-www-form-urlencoded', // Necessary for form data
    },
    body: {
      'login': username,
      'password': password,
    },
  );

  return response;
}
