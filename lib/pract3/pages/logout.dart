import 'package:flutter/material.dart';
import 'hellow.dart';
import 'login.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Material(child: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            ElevatedButton(onPressed: () { Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    const HellowPage()));
            }, child: const Text("Выход"),)
        ),
      ),
    );
  }
}