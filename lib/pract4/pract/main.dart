import 'package:flutter/material.dart';
import 'ColumnPract.dart';
import 'ListViewPract.dart';
import 'ListViewSepPract.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});
  final String title;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [ const PractColumn(), const PractListView(),
    const PractListViewSep()];
  void _onTabTapped(int index) {
    setState(() { _currentIndex = index; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea( child: _screens[_currentIndex],),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_column), label: 'Column',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list), label: 'ListView',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.line_style_sharp), label: 'ListViewSeparated',
          ),
        ],
      ),
    );
  }
}


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: const MainPage(title: '4 практика',)
      )
    );
  }
}