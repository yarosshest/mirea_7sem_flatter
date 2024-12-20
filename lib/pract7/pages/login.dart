import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:mirea_7sem_flatter/pract7/api/auth.dart";

import 'main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loginErr = false;
  bool _loading = false;

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _loginErr = false;
    });

    final response = await loginUser(_loginController.text,_passwordController.text);

    setState(() {
      _loading = false;
    });

    if (response.statusCode == 200) {
      final accessToken = response.headers['access_token'];
      if (accessToken != null) {
        await _saveToken(accessToken); // Save the token in shared preferences
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage(title: "Такс трекер")),
        );
      }
    } else if (response.statusCode == 401) {
      setState(() {
        _loginErr = true;
      });
    } else {
      _showErrorDialog('An unexpected error occurred. Please try again.');
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Widget loginWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (_loginErr)
          const Text(
            "Неверные данные",
            style: TextStyle(color: Colors.red),
          ),
        const SizedBox(height: 20),
        const Text(
          'Введите данные для авторизации',
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _loginController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Логин",
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          obscureText: true,
          controller: _passwordController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Пароль",
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _loading ? null : _login,
          child: const Text("Авторизация"),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Назад'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _loading ? const CircularProgressIndicator() : loginWidget(),
        ),
      ),
    );
  }
}
