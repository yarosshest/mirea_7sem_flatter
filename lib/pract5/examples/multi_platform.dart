import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
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
      return const WebPage();
    } else if (Platform.isAndroid || Platform.isIOS) {
      return const MobilePage();
    } else {
      return const DesktopPage();
    }
  }
}

// web
class WebPage extends StatelessWidget {
  const WebPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Current Path (WebPage)')),
      body: const Center(child: Text('Noting')),
    );
  }
}

// mobile
class MobilePage extends StatefulWidget {
  const MobilePage({super.key});

  @override
  State<MobilePage> createState() => _MobilePageState();
}
class _MobilePageState extends State<MobilePage> {
  String _currentPath = '';
  @override
  void initState() {
    super.initState();
    _getCurrentPath();
  }
  Future<void> _getCurrentPath() async {
    final directory = await getApplicationDocumentsDirectory();
    setState(() => _currentPath = directory.path);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Current Path (Mobile)')),
      body: Center(child: Text('Current Path: $_currentPath')),
    );
  }
}

// desktop
class DesktopPage extends StatefulWidget {
  const DesktopPage({super.key});

  @override
  State<DesktopPage> createState() => _DesktopPageState();
}
class _DesktopPageState extends State<DesktopPage> {
  String _currentPath = '';
  @override
  void initState() {
    super.initState();
    setState(() => _currentPath = Directory.current.path);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Current Path (Desktop)')),
      body: Center(child: Text('Current Path: $_currentPath')),
    );
  }
}