import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:mirea_7sem_flatter/pract5/pract/desktop_page.dart';
import 'package:mirea_7sem_flatter/pract5/pract/mobile_page.dart';
import 'web_page.dart';
import 'dart:io';
void main() {
  runApp(TaskApp());
}

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PlatformSpecificHomePage(),
    );
  }
}

// home
class PlatformSpecificHomePage extends StatelessWidget {
  const PlatformSpecificHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const ConnectionCountryPage();
    }  else if (Platform.isAndroid || Platform.isIOS) {
      return PingIpPage();
    }
    else{
      return MacAddressPage();
    }
  }
}