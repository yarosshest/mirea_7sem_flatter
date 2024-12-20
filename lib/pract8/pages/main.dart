import 'package:flutter/material.dart';
import 'package:mirea_7sem_flatter/pract8/pages/tasks/taskStarter.dart';

import 'logout.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [ const TaskListPage(), const LogoutPage()];
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
            icon: Icon(Icons.filter_list), label: 'Задачи',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.output), label: 'Настройки',
          ),
        ],
      ),
    );
  }
}