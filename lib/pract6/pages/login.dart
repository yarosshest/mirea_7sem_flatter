import 'package:flutter/material.dart';

import 'main.dart';

class LoginPage extends StatefulWidget {
  final  String login;
  final  String pass;
  const LoginPage({ super.key, this.login = "", this.pass= "" });

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {


  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loginErr = false;
  bool _loading = false;

  bool validateUser() {
    return ((_loginController.text == widget.login)&&
        (_passwordController.text == widget.pass));
  }

  Future<void> loadSim() async {

    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _loading = false;
    });
  }

  void login() {
    setState(() {
      _loginErr = !validateUser();
      _loading = true;
    });
    loadSim();
    if (!_loginErr){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>
          const MyRouter()));
    }
  }

  Widget loginWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (_loginErr) const Text("Неверные данные",
          style: TextStyle(color: Colors.red),),
        const SizedBox(height: 20),
        const Text(
          'Введите данные для авторизации', style: TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 20),
        TextField(
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
        ),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () { login(); }, child: const Text("Авторизация"),),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Назад')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: Center(child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: (_loading) ? const CircularProgressIndicator() : loginWidget()
    ),),);
  }
}
