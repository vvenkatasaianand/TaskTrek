import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../home_page.dart';
import '../settings/settings_page.dart';
import '../to do pages/create_edit/create_todo_task.dart';

class BotNavigationbar extends StatefulWidget {
  const BotNavigationbar({super.key});

  @override
  State<BotNavigationbar> createState() => _BotNavigationbarState();
}

class _BotNavigationbarState extends State<BotNavigationbar> {
  List pages = [
    const MyHomepage(),
    const TaskCreatePage(),
    const SettingsPage(),
  ];
  int _selectedpageindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 500),
        height: 50,
        backgroundColor: const Color(0xFF090a0e),
        color: const Color(0xff2a2e3d),
        index: _selectedpageindex,
        items: const [
          Icon(
            color: Colors.white,
            Icons.home,
            size: 30,
          ),
          Icon(
            color: Colors.white,
            Icons.add_task_outlined,
            size: 30,
          ),
          Icon(
            color: Colors.white,
            Icons.settings,
            size: 30,
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedpageindex = index;
          });
        },
      ),
      body: pages[_selectedpageindex],
    );
  }
}
