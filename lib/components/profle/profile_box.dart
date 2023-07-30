import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class ProfileBox extends StatefulWidget {
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
  final double widthofbox;
  final double imagepadding;
  final double borderRadius;
  final String text;

  const ProfileBox({
    super.key,
    required this.onTap,
    required this.text,
    required this.fillColorhash,
    required this.topleftshadowcolor,
    required this.bottonrightshadowcolor,
    required this.heightofbox,
    required this.widthofbox,
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
  State<ProfileBox> createState() => _ProfileBoxState();
}

class _ProfileBoxState extends State<ProfileBox> {
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
      child: Center(
          child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: widget.heightofbox,
        width: widget.widthofbox,
        alignment: Alignment.center,
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
        child: Row(
          children: [
            const Icon(Icons.person_rounded, color: Color(0xFFe9e9e9)),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  widget.text,
                  style: const TextStyle(
                      color: Color(0xFFe9e9e9),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
