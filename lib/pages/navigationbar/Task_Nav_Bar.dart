import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../to do pages/create_edit/gen_todo_list.dart';

class TaskNavigationbar extends StatefulWidget {
  const TaskNavigationbar({super.key, required this.openedindex});
  final int openedindex;
  @override
  State<TaskNavigationbar> createState() => _TaskNavigationbarState();
}

class _TaskNavigationbarState extends State<TaskNavigationbar> {
  List pages = [
    const GenToDoList(
        heading: "All",
        field_title: "All",
        field_data: "All",
        headingcolor: Color(0xffD1CC46)),
    const GenToDoList(
        heading: "Important",
        field_title: "Task Type",
        field_data: "Important",
        headingcolor: Color(0xfff9c31f)),
    const GenToDoList(
        heading: "Planned",
        field_title: "Task Type", //
        field_data: "Planned",
        headingcolor: Color(0xff1cf4f4)),
    const GenToDoList(
        heading: "Achieved",
        field_title: "Task Status",
        field_data: "done",
        headingcolor: Color(0xff6cf8a9)),
    const GenToDoList(
        heading: "Not Achieved",
        field_title: "Task Status",
        field_data: "notdone",
        headingcolor: Color(0xFFF89880))
  ];
  late int _selectedpageindex;

//when page opens
  @override
  void initState() {
    setState(() {});
    super.initState();
    _selectedpageindex = widget.openedindex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 400),
        height: 55,
        backgroundColor: const Color(0xFF090a0e),
        color: const Color(0xff2a2e3d),
        index: _selectedpageindex,
        items: const [
          Icon(
            color: Color(0xffD1CC46),
            Icons.star_half,
            size: 30,
          ),
          Icon(
            color: Color(0xfff9c31f),
            Icons.star,
            size: 30,
          ),
          Icon(
            color: Color(0xff1cf4f4),
            Icons.star_border,
            size: 30,
          ),
          Icon(
            color: Color(0xff6cf8a9),
            Icons.done_all,
            size: 30,
          ),
          Icon(
            color: Color(0xFFF89880),
            Icons.close,
            size: 30,
          )
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
