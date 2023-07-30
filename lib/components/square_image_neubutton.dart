import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class SquareIMGnewButton extends StatefulWidget {
  final String imagePath;
  final dynamic fillColorhash;
  final Function()? onTap;
  final dynamic topleftshadowcolor;
  final dynamic bottonrightshadowcolor;
  final double leftshadowspreadRadius;
  final double rightshadowspreadRadius;
  final double offsetonpressed;
  final double offsetbeforepressed;
  final double bluronpressed;
  final double blurbeforepressed;
  final double heightofbox;
  final double imagepadding;
  final double borderRadius;

  const SquareIMGnewButton({
    super.key,
    required this.imagePath,
    required this.onTap,
    required this.fillColorhash,
    required this.topleftshadowcolor,
    required this.bottonrightshadowcolor,
    required this.heightofbox,
    required this.imagepadding,
    required this.borderRadius,
    required this.leftshadowspreadRadius,
    required this.rightshadowspreadRadius,
    required this.offsetonpressed,
    required this.offsetbeforepressed,
    required this.bluronpressed,
    required this.blurbeforepressed,
  });

  @override
  State<SquareIMGnewButton> createState() => _SquareIMGnewButtonState();
}

class _SquareIMGnewButtonState extends State<SquareIMGnewButton> {
  bool buttonpressed = false;
  @override
  Widget build(BuildContext context) {
    Offset distance = buttonpressed
        ? Offset(widget.offsetonpressed, widget.offsetonpressed)
        : Offset(widget.offsetbeforepressed, widget.offsetbeforepressed);
    double blur =
        buttonpressed ? widget.bluronpressed : widget.blurbeforepressed;
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
            duration: const Duration(milliseconds: 100),
            height: widget.heightofbox,
            padding: EdgeInsets.all(widget.imagepadding),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                color: Color(widget.fillColorhash),
                // Colors.grey.shade400
                boxShadow: [
                  //top lft shadow
                  BoxShadow(
                      color: Color(widget.topleftshadowcolor),
                      offset: -distance,
                      blurRadius: blur,
                      spreadRadius: widget.leftshadowspreadRadius,
                      inset: buttonpressed),
                  //bottom right shadow
                  BoxShadow(
                      color: Color(widget
                          .bottonrightshadowcolor), // Color.fromARGB(25555, 0, 0, 0),
                      offset: distance,
                      blurRadius: blur,
                      spreadRadius: widget.rightshadowspreadRadius,
                      inset: buttonpressed)
                ]),
            child: Image.asset(
              widget.imagePath,
              // height: 10,
            ),
          )),
    );
  }
}
