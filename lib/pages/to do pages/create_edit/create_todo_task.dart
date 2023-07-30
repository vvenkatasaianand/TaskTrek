import 'package:TaskTrek/components/my_neubutton.dart';
import 'package:TaskTrek/components/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskCreatePage extends StatefulWidget {
  const TaskCreatePage({super.key});

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final user = FirebaseAuth.instance.currentUser!;

  final _newtasktitleController = TextEditingController();
  final _newtaskdescriptionController = TextEditingController();
  String taskType = "";

//toast message
  void tostme(String message, int time) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: time),
    ));
  }

// type box
  Widget chipdata(String lable, dynamic color) {
    return InkWell(
      onTap: () {
        setState(() {
          taskType = lable;
        });
      },
      child: Chip(
        backgroundColor:
            taskType == lable ? Color(color) : const Color(0xFF090a0e),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          lable,
          style: GoogleFonts.ysabeau(
              fontSize: 15,
              letterSpacing: 0.5,
              color: taskType == lable ? Colors.black : Colors.white,
              fontWeight: FontWeight.w600),
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

//send data to firestore
  void senddatatofirebase() {
    if (_newtasktitleController.text != "" && taskType != "") {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .collection("Tasks")
          .add({
        "Task Title": _newtasktitleController.text,
        "Task Type": taskType.toString(),
        "Description": _newtaskdescriptionController.text,
        "Task Status": "notdone"
      });
      tostme("Task added.....", 300);
    } else {
      tostme("fill details.....", 600);
    }
  }

//lable
  Widget lable(String lable) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            lable,
            softWrap: true,
            style: GoogleFonts.ysabeau(
                fontSize: 19,
                letterSpacing: 0.5,
                color: const Color(0xFFf3fafb)),
          ),
        ),
      ],
    );
  }

//reload ever time page opens
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Scaffold(
          body: Container(
            color: const Color(0xFF090a0e),
            child: ListView(
              children: [
                SafeArea(
                    child: Center(
                  child: Column(
                    children: [
                      // top animation part
                      Stack(
                        children: [
                          //todo animation
                          SizedBox(
                              child: Container(
                            padding: const EdgeInsets.only(top: 8),
                            child: Expanded(
                              child: Center(
                                child: Lottie.asset(
                                  'animations/todohome.json',
                                ),
                              ),
                            ),
                          )),

                          //add new taks title
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Add new task...',
                                style: GoogleFonts.carterOne(
                                    fontSize: 30,
                                    color: const Color(0xFFe9e9e9)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //fill the details part
                      lable('Task Title:'),
                      //task title text field
                      const SizedBox(height: 10),
                      MyTextField(
                          controller: _newtasktitleController,
                          hintText: 'task title',
                          enabledme: true,
                          height: 55,
                          maxLines: 1,
                          toptextborder: 0,
                          fillColorhash: 0xFF090a0e,
                          textcolorhash: 0xFFbdbdbd,
                          hintcolorhash: 0xFFa9bae6,
                          bordercolor: 0xFFbdbdbd,
                          obscureText: false),
                      // type of todo(importent or planned)
                      const SizedBox(height: 20),
                      lable("Task Type:"),
                      // type of todo buttons
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: [
                            chipdata("Important", 0xfff9c31f),
                            const SizedBox(width: 25),
                            chipdata("Planned", 0xff1cf4f4),
                          ],
                        ),
                      ),
                      //descreption of task
                      const SizedBox(height: 20),
                      lable('Description:'),
                      //descreption text field
                      const SizedBox(height: 10),
                      MyTextField(
                          controller: _newtaskdescriptionController,
                          hintText: 'Description',
                          enabledme: true,
                          height: 150,
                          maxLines: 6,
                          toptextborder: 20,
                          fillColorhash: 0xFF090a0e,
                          textcolorhash: 0xFFbdbdbd,
                          hintcolorhash: 0xFFa9bae6,
                          bordercolor: 0xFFbdbdbd,
                          obscureText: false),
                      //add task button
                      const SizedBox(height: 50),
                      MyNeuButton(
                        name: 'Add task',
                        onTap: senddatatofirebase,
                        buttonwidth: 414,
                        testcolor: 0xFF090a0e,
                        fillColorhash: 0xFF708cd5, //0xFF141a1d,0xFF708cd5
                        topleftshadowcolor: 0xFF090a0e,
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ));
  }
}
