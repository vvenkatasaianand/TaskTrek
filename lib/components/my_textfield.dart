import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;
  final dynamic hintcolorhash;
  final dynamic fillColorhash;
  final dynamic textcolorhash;
  final dynamic bordercolor;
  final bool enabledme;
  final int maxLines;
  final double height;
  final double toptextborder;
  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.hintcolorhash,
      required this.fillColorhash,
      required this.textcolorhash,
      required this.bordercolor,
      required this.maxLines,
      required this.height,
      required this.toptextborder,
      required this.enabledme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(fillColorhash),
            border: Border.all(color: Color(bordercolor))),
        child: TextFormField(
          controller: controller,
          enabled: enabledme,
          obscureText: obscureText,
          textAlign: TextAlign.left,
          maxLines: maxLines,
          style: GoogleFonts.ysabeau(
              fontSize: 18, letterSpacing: 0.5, color: Color(textcolorhash)),
          decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(fillColorhash),
              filled: true,
              hintText: hintText,
              hintStyle: GoogleFonts.ysabeau(
                fontSize: 18,
                letterSpacing: 0.5,
                color: Color(hintcolorhash),
              ),
              contentPadding:
                  EdgeInsets.only(left: 20, right: 20, top: toptextborder)),
        ),
      ),
    );
  }
}
