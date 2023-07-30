import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:TaskTrek/components/my_neubutton.dart';
import 'package:TaskTrek/components/my_textfield.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  // to get user details
  final user = FirebaseAuth.instance.currentUser!;
  bool currentPasswordcorrect = false;
  //constructers
  final TextEditingController _currentpasswordController =
      TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  final TextEditingController _confirmNewpasswordController =
      TextEditingController();

//when page opens
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

//update details
  Future<void> updatedetails() async {
    currentPasswordcorrect =
        await currentpasswordcheck(_currentpasswordController.text);
    if (currentPasswordcorrect) {
      if (_newpasswordController.text == _confirmNewpasswordController.text) {
        user.updatePassword(_newpasswordController.text).then((value) {
          tostme("Password changed", 600);
          Navigator.pop(context);
        });
      } else {
        tostme("New Password not matched", 900);
      }
    } else {
      tostme("Your Password is Incorrect", 900);
    }
  }

  //=======================================
  // Function to reauthenticate the user with their current password
  Future<bool> currentpasswordcheck(String currentPassword) async {
    AuthCredential credentials = EmailAuthProvider.credential(
        email: user.email!, password: currentPassword);
    try {
      await user.reauthenticateWithCredential(credentials);
      return true;
    } catch (e) {
      return false;
    }
  }
//======================================

//toast message
  void tostme(String message, int time) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: time),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090a0e),
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: GoogleFonts.carterOne(
              fontSize: 25, letterSpacing: 0.5, color: const Color(0xFFff735d)),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF090a0e),
        elevation: .5,
        shadowColor: const Color(0xFFff735d),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  //logo
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: const Expanded(
                      child: Center(
                        child: Image(
                            image: AssetImage('images/changepassword.png'),
                            height: 300,
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  //current passwort
                  lable("Current Password:"),
                  const SizedBox(height: 10),
                  MyTextField(
                      controller: _currentpasswordController,
                      hintText: 'current password',
                      enabledme: true,
                      height: 55,
                      maxLines: 1,
                      toptextborder: 0,
                      fillColorhash: 0xFF090a0e,
                      textcolorhash: 0xfff9c31f,
                      hintcolorhash: 0xffff9e90,
                      bordercolor: 0xFFbdbdbd,
                      obscureText: false),

                  const SizedBox(height: 10),
                  //new passwort and confirm
                  lable("New Password:"),
                  const SizedBox(height: 10),
                  MyTextField(
                      controller: _newpasswordController,
                      hintText: 'new password',
                      enabledme: true,
                      height: 55,
                      maxLines: 1,
                      toptextborder: 0,
                      fillColorhash: 0xFF090a0e,
                      textcolorhash: 0xfff9c31f,
                      hintcolorhash: 0xffff9e90,
                      bordercolor: 0xFFbdbdbd,
                      obscureText: false),
                  const SizedBox(height: 10),
                  MyTextField(
                      controller: _confirmNewpasswordController,
                      hintText: 'confirm password',
                      enabledme: true,
                      height: 55,
                      maxLines: 1,
                      toptextborder: 0,
                      fillColorhash: 0xFF090a0e,
                      textcolorhash: 0xfff9c31f,
                      hintcolorhash: 0xffff9e90,
                      bordercolor: 0xFFbdbdbd,
                      obscureText: false),
                  const SizedBox(height: 10),
                  //change password button
                  const SizedBox(height: 5),
                  MyNeuButton(
                    name: 'Change Password',
                    onTap: updatedetails,
                    buttonwidth: 414,
                    testcolor: 0xFF090a0e,
                    fillColorhash: 0xFFff735d, //0xFF141a1d,0xFF708cd5
                    topleftshadowcolor: 0xFF090a0e,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
              fontSize: 19, letterSpacing: 0.5, color: const Color(0xFFf3fafb)),
        ),
      ),
    ],
  );
}
