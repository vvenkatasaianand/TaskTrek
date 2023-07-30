import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class BoxwithContentAtRight extends StatefulWidget {
  final String animationoORimagePATH;
  final dynamic fillColor;
  final Function()? onTap;
  final String heading1;
  final String heading2;
  final String description;
  final double topmargin;
  final double bottommargin;

  const BoxwithContentAtRight({
    super.key,
    required this.animationoORimagePATH,
    required this.fillColor,
    required this.onTap,
    required this.heading1,
    required this.heading2,
    required this.description,
    required this.topmargin,
    required this.bottommargin,
  });

  @override
  State<BoxwithContentAtRight> createState() => _BoxwithContentAtRightState();
}

class _BoxwithContentAtRightState extends State<BoxwithContentAtRight> {
  bool buttonpressed = false;
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: (event) => setState(() {
        buttonpressed = false;
      }),
      onPointerDown: (event) => setState(() {
        buttonpressed = true;
      }),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              // container for aniamtion
              Expanded(
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                      color: Color(widget.fillColor),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        buttonpressed
                            ? const BoxShadow()
                            :
                            //top lft shadow
                            const BoxShadow(
                                color: Colors.white,
                                offset: Offset(-4, -4),
                                blurRadius: 9,
                                spreadRadius: -1.5),
                        //bottom right shadow
                        const BoxShadow(
                            color:
                                Colors.black, // Color.fromARGB(25555, 0, 0, 0),
                            offset: Offset(4, 4),
                            blurRadius: 3,
                            spreadRadius: 3)
                      ]),
                  child: Lottie.asset(
                    widget.animationoORimagePATH,
                  ),
                ),
              ),
              // container for decriptions
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(top: 5),
                height: 130,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(18),
                        bottomRight: Radius.circular(18)),
                    boxShadow: [
                      buttonpressed
                          ? const BoxShadow()
                          :
                          //top lft shadow
                          const BoxShadow(
                              color: Colors.white,
                              offset: Offset(6, -4),
                              blurRadius: 9,
                              spreadRadius: -1.5),
                      //bottom right shadow
                      const BoxShadow(
                        color: Colors.black, // Color.fromARGB(25555, 0, 0, 0),
                        offset: Offset(8, 4),
                        blurRadius: 9,
                        spreadRadius: 5,
                      )
                    ]),
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(
                          top: widget.topmargin, left: 10, right: 10),
                      child: Center(
                          child: RichText(
                              text: TextSpan(
                                  style: GoogleFonts.lobster(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                            TextSpan(
                                text: widget.heading1,
                                style: const TextStyle(
                                    decoration: TextDecoration.underline)),
                            const TextSpan(text: ' '),
                            TextSpan(
                                text: widget.heading2,
                                style: const TextStyle(
                                    decoration: TextDecoration.underline))
                          ]))),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 0,
                            bottom: widget.bottommargin,
                            left: 17,
                            right: 17),
                        // color: Colors.yellow,
                        child: Text(widget.description,
                            style: GoogleFonts.lobster(
                                fontSize: 15, color: Colors.grey.shade500)),
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
