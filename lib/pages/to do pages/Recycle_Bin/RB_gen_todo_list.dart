import 'package:TaskTrek/pages/to%20do%20pages/Recycle_Bin/RB_view_edit_todo.dart';
import 'package:TaskTrek/pages/to%20do%20pages/create_edit/todo_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

final fb = FirebaseFirestore.instance
    .collection("Users")
    .doc(FirebaseAuth.instance.currentUser!.uid.toString());

class GenRBToDoList extends StatefulWidget {
  const GenRBToDoList({super.key, required this.headingcolor});
  final Color headingcolor;
  @override
  State<GenRBToDoList> createState() => _GenRBToDoListState();
}

class _GenRBToDoListState extends State<GenRBToDoList> {
// to collect todo data from collection to stream
  final Stream<QuerySnapshot> _todostream =
      fb.collection("Recycle_Bin").snapshots();

  //reload ever time page opens
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          'Recycle Bin',
          style: GoogleFonts.carterOne(
            fontSize: 30,
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
                  fit: BoxFit.scaleDown,
                ));
              }
              return ListView.builder(
                  itemCount: (snapshot.data!).docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> taskdata = snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>;
                    return ToDoCard(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RBViewAndEditToDoPage(
                                  dataofthetask: taskdata,
                                  docid: snapshot.data!.docs[index].id),
                            ));
                      },
                      title: taskdata["Task Title"],
                      containercolor: const Color(0xff44312d),
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
                  });
            }),
      ),
    );
  }
}
