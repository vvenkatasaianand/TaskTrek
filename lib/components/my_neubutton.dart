import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';

class MyNeuButton extends StatefulWidget {
  final Function()? onTap;
  final String name;
  final dynamic fillColorhash;
  final dynamic testcolor;
  final dynamic topleftshadowcolor;
  final double buttonwidth;

  const MyNeuButton({
    super.key,
    required this.onTap,
    required this.name,
    required this.fillColorhash,
    required this.testcolor,
    required this.topleftshadowcolor,
    required this.buttonwidth,
    // required this.buttonpressed,
  });
  @override
  State<MyNeuButton> createState() => _MyNeuButtonState();
}

class _MyNeuButtonState extends State<MyNeuButton> {
  bool buttonpressed = false;

  @override
  Widget build(BuildContext context) {
    Offset distance = buttonpressed ? const Offset(3, 3) : const Offset(4, 4);
    double blur = buttonpressed ? 6 : 9;
    return Listener(
      onPointerUp: (event) => setState(() {
        buttonpressed = false;
      }),
      onPointerDown: (event) => setState(() {
        buttonpressed = true;
      }),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(microseconds: 100),
          height: 50,
          width: widget.buttonwidth,
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              color: Color(widget.fillColorhash), //0xFFbdbdbd
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                //top lft shadow
                BoxShadow(
                    color: Color(widget.topleftshadowcolor),
                    offset: -distance,
                    blurRadius: blur,
                    spreadRadius: -1.5,
                    inset: buttonpressed),
                //bottom right shadow
                BoxShadow(
                    color: const Color.fromARGB(25555, 0, 0, 0),
                    offset: distance,
                    blurRadius: blur,
                    spreadRadius: 3,
                    inset: buttonpressed)
              ]),
          child: Center(
            child: Text(
              widget.name,
              style: GoogleFonts.ysabeau(
                  fontSize: 19,
                  letterSpacing: 0.5,
                  color: Color(widget.testcolor),
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
