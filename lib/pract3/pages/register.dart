import 'package:flutter/material.dart';

import 'login.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  RegisterPage({super.key});

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
    return Material(child: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Введите данные для регистрации', style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ...loginPass(),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () { Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                LoginPage(login:_loginController.text,
                    pass:_passwordController.text)));
              }, child: const Text("Регистрация"),)
          ],
        ),
      ),
    ),);
  }
}