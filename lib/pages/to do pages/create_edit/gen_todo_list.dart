// ignore_for_file: non_constant_identifier_names

import 'package:TaskTrek/pages/to%20do%20pages/create_edit/todo_card.dart';
import 'package:TaskTrek/pages/to%20do%20pages/create_edit/view_edit_todo_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

final fb = FirebaseFirestore.instance
    .collection("Users")
    .doc(FirebaseAuth.instance.currentUser!.uid.toString());

class GenToDoList extends StatefulWidget {
  const GenToDoList(
      {super.key,
      required this.field_data,
      required this.field_title,
      required this.headingcolor,
      required this.heading});
  final String field_data;
  final String field_title;
  final Color headingcolor;
  final String heading;

  @override
  State<GenToDoList> createState() => _GenToDoListState();
}

class _GenToDoListState extends State<GenToDoList> {
  //reload ever time page opens
  late Stream<QuerySnapshot> _todostream;
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _todostream = fb.collection("Tasks").snapshots();
    return Scaffold(
      backgroundColor: const Color(0xFF090a0e),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 30,
            color: const Color(0xFFe9e9e9)),
        title: Text(
          'Your ${widget.heading} Task\'s',
          style: GoogleFonts.carterOne(
            fontSize: 20,
            letterSpacing: 0.5,
            color: widget.headingcolor,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF090a0e),
        elevation: 1.5,
        shadowColor: widget.headingcolor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
        child: StreamBuilder<QuerySnapshot>(
            stream: _todostream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: Lottie.asset(
                  'animations/loading.json',
                ));
              }
              return ListView.builder(
                  itemCount: (snapshot.data!).docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> taskdata = snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>;
                    if (taskdata[widget.field_title] == widget.field_data ||
                        widget.field_data == "All") {
                      return ToDoCard(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewAndEditToDoPage(
                                    dataofthetask: taskdata,
                                    docid: snapshot.data!.docs[index].id),
                              ));
                        },
                        title: taskdata["Task Title"],
                        containercolor: const Color(0xff2a2e3d),
                        checkmarkbgcolor: taskdata["Task Status"] == "done"
                            ? const Color(0xff6cf8a9)
                            : const Color(0xFF090a0e),
                        checkmarkdata: taskdata["Task Status"] == "done"
                            ? Icons.done
                            : Icons.close,
                        checkmarkcolor: taskdata["Task Status"] == "done"
                            ? const Color(0xFF090a0e)
                            : const Color(0xFFf3fafb),
                        icondata: taskdata["Task Type"] == "Important"
                            ? Icons.star
                            : Icons.star_border,
                        iconcolor: const Color(0xFF090a0e),
                        iconbgcolor: taskdata["Task Type"] == "Important"
                            ? const Color(0xfff9c31f)
                            : const Color(0xff1cf4f4),
                        checkmarkiconsize: 24,
                      );
                    } else {
                      return const SizedBox(height: 0);
                    }
                  });
            }),
      ),
    );
  }
}
