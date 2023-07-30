import 'package:TaskTrek/components/my_neubutton.dart';
import 'package:TaskTrek/components/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

final fb = FirebaseFirestore.instance
    .collection("Users")
    .doc(FirebaseAuth.instance.currentUser!.uid.toString());

class ViewAndEditToDoPage extends StatefulWidget {
  const ViewAndEditToDoPage(
      {super.key, required this.dataofthetask, required this.docid});
  final Map<String, dynamic> dataofthetask;
  final String docid;
  @override
  State<ViewAndEditToDoPage> createState() => _ViewAndEditToDoPageState();
}

class _ViewAndEditToDoPageState extends State<ViewAndEditToDoPage> {
  final user = FirebaseAuth.instance.currentUser!;

  late TextEditingController _tasktitleController;
  late TextEditingController _taskdescriptionController;
  late String taskType;
  late String taskStatus;
  bool edit = false;

//when page opens
  @override
  void initState() {
    setState(() {});
    super.initState();
    _tasktitleController =
        TextEditingController(text: widget.dataofthetask["Task Title"]);
    _taskdescriptionController =
        TextEditingController(text: widget.dataofthetask["Description"]);
    taskType = widget.dataofthetask["Task Type"];
    taskStatus = widget.dataofthetask["Task Status"];
  }

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
      onTap: edit
          ? () {
              setState(() {
                taskType = lable;
              });
            }
          : null,
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

//update data to firestore
  void updatedatatofirebase() {
    if (_tasktitleController.text != "" && taskType != "") {
      fb.collection("Tasks").doc(widget.docid).update({
        "Task Title": _tasktitleController.text,
        "Task Type": taskType.toString(),
        "Description": _taskdescriptionController.text,
      }).then((value) {
        tostme("Task Updated.....", 500);
        Navigator.pop(context);
      });
    } else {
      tostme("fill details.....", 600);
    }
  }

// update task statues
  void updatetaskstatustofirebase(String taskstatus) {
    fb.collection("Tasks").doc(widget.docid).update({
      "Task Status": taskstatus.toString(),
    }).then((value) {
      tostme("Task Updated.....", 500);
      Navigator.pop(context);
    });
  }

// move tassk to recyclebin
  void movetorecyclebin() {
    // create/copy the task to recyclebin collection
    fb.collection("Recycle_Bin").doc(widget.docid).set({
      "Task Title": _tasktitleController.text,
      "Task Type": taskType.toString(),
      "Description": _taskdescriptionController.text,
      "Task Status": taskStatus.toString(),
    }).then((value) {
      // delete task from todo collectios
      fb.collection("Tasks").doc(widget.docid).delete().then((value) {
        tostme("Moved to Recycle Bin.....", 500);
        Navigator.pop(context);
      });
    });
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
              color: const Color(0xFFf3fafb),
            ),
          ),
        ),
      ],
    );
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
                            padding: edit
                                ? const EdgeInsets.only(top: 8)
                                : const EdgeInsets.only(top: 35),
                            child: Expanded(
                              child: Center(
                                child: Lottie.asset(
                                    edit
                                        ? 'animations/todohome.json'
                                        : 'animations/todo.json',
                                    height: edit ? 350 : 370),
                              ),
                            ),
                          )),

                          //back button
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.arrow_back_ios),
                                  iconSize: 30,
                                  color: const Color(0xFFe9e9e9),
                                )),
                          ),

                          //edit button
                          Padding(
                            padding: const EdgeInsets.only(right: 15, top: 20),
                            child: edit
                                ? const SizedBox()
                                : Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          edit = !edit;
                                        });
                                      },
                                      icon: const Icon(Icons.edit),
                                      iconSize: 30,
                                      color: Colors.lime,
                                    )),
                          ),
                          //view your taks title
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                edit
                                    ? 'Edit Your Task...'
                                    : 'View Your Task...',
                                style: GoogleFonts.carterOne(
                                    fontSize: 30,
                                    color: edit
                                        ? Colors.amber
                                        : const Color(0xFFe9e9e9)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //task status displayer
                      Text(
                        taskStatus == "done"
                            ? '---- TASK ACHIEVED ----'
                            : '-- TASK NOT ACHIEVED --',
                        style: GoogleFonts.ysabeau(
                            fontSize: 20,
                            letterSpacing: 0.5,
                            color: taskStatus == "done"
                                ? Colors.amber
                                : const Color(0xFFF89880),
                            fontWeight: FontWeight.w600),
                      ),
                      //fill the details part
                      const SizedBox(height: 10),

                      lable('Task Title:'),
                      //task title text field
                      const SizedBox(height: 10),
                      MyTextField(
                          controller: _tasktitleController,
                          hintText: 'task title',
                          height: 55,
                          maxLines: 1,
                          toptextborder: 0,
                          enabledme: edit,
                          fillColorhash: 0xFF090a0e,
                          textcolorhash: 0xfff9c31f,
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
                          controller: _taskdescriptionController,
                          hintText: 'Description',
                          height: 150,
                          maxLines: 6,
                          toptextborder: 20,
                          enabledme: edit,
                          fillColorhash: 0xFF090a0e,
                          textcolorhash: 0xfff9c31f,
                          hintcolorhash: 0xFFa9bae6,
                          bordercolor: 0xFFbdbdbd,
                          obscureText: false),

                      //task status button
                      const SizedBox(height: 50),
                      taskStatus == "done"
                          ? MyNeuButton(
                              name: 'Mark As NOT ACHIEVED TASK',
                              onTap: () {
                                updatetaskstatustofirebase("notdone");
                              },
                              buttonwidth: 414,
                              testcolor: 0xFFf3fafb,
                              fillColorhash: 0xff5f6060,
                              topleftshadowcolor: 0xFF090a0e,
                            )
                          : MyNeuButton(
                              name: 'Mark As ACHIEVED TASK',
                              onTap: () {
                                updatetaskstatustofirebase("done");
                              },
                              buttonwidth: 414,
                              testcolor: 0xFF000000,
                              fillColorhash: 0xff6cf8a9,
                              topleftshadowcolor: 0xFF090a0e,
                            ),
                      const SizedBox(height: 40),

                      //update and delete button
                      edit
                          ? MyNeuButton(
                              name: 'Update Task',
                              onTap: updatedatatofirebase,
                              buttonwidth: 414,
                              testcolor: 0xFF000000,
                              fillColorhash: 0xFF708cd5, //0xFF141a1d,
                              topleftshadowcolor: 0xFF090a0e,
                            )
                          : MyNeuButton(
                              name: 'Move to Recycle Bin',
                              onTap: movetorecyclebin,
                              buttonwidth: 414,
                              testcolor: 0xFF000000,
                              fillColorhash: 0xFFd9143b,
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
