// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:TaskTrek/components/my_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_to_act/slide_to_act.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // to get user details
  final user = FirebaseAuth.instance.currentUser!;

  //constructers
  late TextEditingController _PreDisplayNameController;
  late TextEditingController _NewDisplayNameController;
  late TextEditingController _PreEmailIdController;
  late TextEditingController _NewEmailIdController;

//when page opens
  @override
  void initState() {
    setState(() {});
    super.initState();
    _PreDisplayNameController = TextEditingController(text: user.displayName);
    _PreEmailIdController = TextEditingController(text: user.email);
    _NewDisplayNameController = TextEditingController(text: user.displayName);
    _NewEmailIdController = TextEditingController(text: user.email);
  }

//update details
  void updatedetails() {
    if (pickedfile != null) uploadthhemedia();

    if (_PreDisplayNameController.text != _NewDisplayNameController.text) {
      _NewDisplayNameController.text.length <= 17
          ? user
              .updateDisplayName(_NewDisplayNameController.text)
              .then((value) {
              tostme("display name updated", 600);
              Navigator.pop(context);
            })
          : tostme("Display Name must be less then 18 charectors", 800);
    }
    if (_PreEmailIdController.text != _NewEmailIdController.text) {
      user
          .updateEmail(_NewEmailIdController.text)
          .then((value) => tostme("email updated", 600));
    }
    if (pickedfile == null &&
        _PreDisplayNameController.text == _NewDisplayNameController.text &&
        _PreEmailIdController.text == _NewEmailIdController.text) {
      Navigator.pop(context);
    }
  }

  //=======================================
  //edit profile pic
  PlatformFile? pickedfile;
  Future openmedia() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedfile = result.files.first;
    });
  }

  Future uploadthhemedia() async {
    final pathwheretosave = '${user.uid}/${pickedfile!.name}';
    final filetosave = File(pickedfile!.path!);
    //uploading image to fire storage
    FirebaseStorage.instance
        .ref()
        .child(pathwheretosave)
        .putFile(filetosave)
        .whenComplete(() async {
      //getting uploaded pic url
      final uploadedpropicURL = await FirebaseStorage.instance
          .ref()
          .child(pathwheretosave)
          .getDownloadURL();
      //saving the url to fireAuth
      user.updatePhotoURL(uploadedpropicURL).then((value) {
        tostme("profile pic updated", 600);
        Navigator.pop(context);
      });
    });
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
          'Edit Profile',
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
                  //profile pic
                  InkWell(
                    onTap: openmedia,
                    borderRadius: BorderRadius.circular(50),
                    child: CircleAvatar(
                        backgroundColor: const Color(0xFFf3fafb),
                        radius: 100.7,
                        child: ClipOval(
                            child: pickedfile != null
                                ? Image.file(
                                    File(pickedfile!.path!),
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  )
                                : Image(
                                    image: NetworkImage(user.photoURL ??
                                        'https://firebasestorage.googleapis.com/v0/b/me-student-152db.appspot.com/o/avatar.png?alt=media&token=ba0ba439-c229-4881-ab58-1c8930340db1'),
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ))),
                  ),
                  const SizedBox(height: 30),
                  //display name
                  lable("Display Name:"),
                  const SizedBox(height: 10),
                  MyTextField(
                      controller: _NewDisplayNameController,
                      hintText: 'Display Name',
                      enabledme: true,
                      height: 55,
                      maxLines: 1,
                      toptextborder: 0,
                      fillColorhash: 0xFF090a0e,
                      textcolorhash: 0xfff9c31f,
                      hintcolorhash: 0xff6cf8a9,
                      bordercolor: 0xFFbdbdbd,
                      obscureText: false),

                  const SizedBox(height: 30),
                  //email
                  lable("Email:"),
                  const SizedBox(height: 10),
                  MyTextField(
                      controller: _NewEmailIdController,
                      hintText: 'Email',
                      enabledme: true,
                      height: 55,
                      maxLines: 1,
                      toptextborder: 0,
                      fillColorhash: 0xFF090a0e,
                      textcolorhash: 0xfff9c31f,
                      hintcolorhash: 0xFFa9bae6,
                      bordercolor: 0xFFbdbdbd,
                      obscureText: false),
                  //Logout
                  const SizedBox(height: 50),
                  SlideAction(
                    onSubmit: updatedetails,
                    text: "Slide to Save ➾",
                    height: 60,
                    submittedIcon: const CircularProgressIndicator(
                        backgroundColor: Color(0xff0d0e17),
                        color: Color(0xff6cf8a9)),
                    textStyle: GoogleFonts.ysabeau(
                        fontSize: 20,
                        letterSpacing: 1,
                        color: const Color(0xffcaa32c)),
                    borderRadius: 12,
                    elevation: 1,
                    sliderButtonIconSize: 30,
                    innerColor: const Color(0xff6cf8a9),
                    outerColor: const Color(0xff0d0e17),
                    sliderButtonIcon: const Icon(Icons.edit_note_rounded),
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
