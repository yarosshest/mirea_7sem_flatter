import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class CheckWEB extends StatelessWidget {
  const CheckWEB({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Check WEB Example'),
        ),
        body: const Center(
          child: PlatformMessage(),
        ),
      ),
    );
  }
}

class PlatformMessage extends StatelessWidget {
  const PlatformMessage({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      // Сообщение для веб-платформы
      return const Text('Вы используете веб-платформу');
    } else {
      // Сообщение для мобильной или десктопной платформы
      return const Text('Вы используете мобильную или десктопную платформу');
    }
  }
}

void main() {
  runApp(const CheckWEB());
}