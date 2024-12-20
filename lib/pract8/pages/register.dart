import 'package:flutter/material.dart';
import 'package:mirea_7sem_flatter/pract8/api/auth.dart';
import 'login.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  RegisterPage({super.key});

  Future<void> _register(BuildContext context) async {
    final String login = _loginController.text;
    final String password = _passwordController.text;

    try {
      final response = await registerUser(login, password);

      if (response.statusCode == 200) {
        // Registration successful, navigate to login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else if (response.statusCode == 409) {
        // User already exists, show error message
        _showErrorDialog(context, 'Registration failed: Already exist');
      } else {
        _showErrorDialog(context, 'Registration failed: Unknown error');
      }
    } catch (error) {
      _showErrorDialog(context, 'Registration failed: Network error');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<Widget> loginPass(){
    return [TextField(
      controller: _loginController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Логин"
      ),
    ),
      const SizedBox(height: 20),
      TextField(
        obscureText: true,
        controller: _passwordController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Пароль"
        ),
      )];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Введите данные для регистрации',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              ...loginPass(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _register(context),
                child: const Text("Регистрация"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Назад'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
