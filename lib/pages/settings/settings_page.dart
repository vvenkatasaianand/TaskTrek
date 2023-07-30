import 'package:TaskTrek/pages/authentication%20pages/change_password_page.dart';
import 'package:TaskTrek/pages/authentication%20pages/edit_profile_page.dart';
import 'package:TaskTrek/pages/to%20do%20pages/Recycle_Bin/RB_gen_todo_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_to_act/slide_to_act.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // to get user details
  final user = FirebaseAuth.instance.currentUser!;
//boot to display profile pic larger
  bool pplarrge = false;
//to open profille pic in full
  void profilepicZOOM() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090a0e),
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.carterOne(
              fontSize: 25, letterSpacing: 0.5, color: const Color(0xFFe9e9e9)),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF090a0e),
        elevation: .5,
        shadowColor: const Color(0xFFdbdbdb),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  //profile pic circular and zoomed version
                  pplarrge
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              pplarrge = false;
                            });
                          },
                          child: Container(
                              width: 310,
                              height: 310,
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  image: DecorationImage(
                                      image: NetworkImage(user.photoURL ??
                                          'https://firebasestorage.googleapis.com/v0/b/me-student-152db.appspot.com/o/avatar.png?alt=media&token=ba0ba439-c229-4881-ab58-1c8930340db1'),
                                      fit: BoxFit.cover))),
                        )
                      : InkWell(
                          onLongPress: () {
                            setState(() {
                              pplarrge = true;
                            });
                          },
                          borderRadius: BorderRadius.circular(100),
                          child: CircleAvatar(
                              backgroundImage:
                                  const AssetImage('images/avatar.png'),
                              backgroundColor: const Color(0xFFf3fafb),
                              radius: 100.7,
                              child: ClipOval(
                                  child: Image(
                                image: NetworkImage(user.photoURL ??
                                    'https://firebasestorage.googleapis.com/v0/b/me-student-152db.appspot.com/o/avatar.png?alt=media&token=ba0ba439-c229-4881-ab58-1c8930340db1'),
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                              )))),
                  //container
                  // Display Name and email
                  Stack(children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(user.displayName.toString(),
                          maxLines: 1,
                          style: GoogleFonts.carterOne(
                              fontSize: 35, color: const Color(0xFFf3fafb))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 45.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(user.email.toString(),
                            style: GoogleFonts.ysabeau(
                                fontSize: 20,
                                letterSpacing: 0,
                                color:
                                    const Color.fromARGB(183, 243, 250, 251))),
                      ),
                    ),
                  ]),

                  const SizedBox(height: 50),
                  //Edit Profile
                  iconwithtext(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfilePage()));
                  }, "Edit Profile", Icons.edit_note_rounded,
                      const Color(0xFF708cd5)),
                  const SizedBox(height: 20),
                  //change password
                  iconwithtext(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChangePasswordPage()));
                  }, "Change Password", Icons.lock_outline_rounded,
                      const Color(0xFFffc727)),
                  //Recycle Bin
                  const SizedBox(height: 20),
                  iconwithtext(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GenRBToDoList(
                                headingcolor: Color(0xFFd9143b))));
                  }, "Recycle Bin", Icons.delete_rounded,
                      const Color(0xFFd9143b)),
                  //Logout
                  const SizedBox(height: 50),
                  SlideAction(
                    onSubmit: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                    text: "Slide to LOGOUT ➾",
                    height: 60,
                    textStyle: GoogleFonts.ysabeau(
                        fontSize: 20,
                        letterSpacing: 1,
                        color: const Color(0xff6cf8a9)),
                    borderRadius: 12,
                    elevation: 10,
                    sliderButtonIconSize: 30,
                    innerColor: const Color(0xff6cf8a9),
                    outerColor: const Color(0xff0d0e17),
                    sliderButtonIcon: const Icon(Icons.person_outline_rounded),
                    sliderButtonIconPadding: 13.7,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//function

Padding iconwithtext(
    Function()? onTap, String lable, IconData iconData, Color iconcolor) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(iconData, color: iconcolor, size: 35),
        const SizedBox(width: 10),
        InkWell(
          onTap: onTap,
          child: Text(lable,
              style: GoogleFonts.ysabeau(
                  fontSize: 27,
                  letterSpacing: 1,
                  color: const Color(0xFFf3fafb))),
        ),
      ],
    ),
  );
}
