import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToDoCard extends StatelessWidget {
  const ToDoCard(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.icondata,
      required this.iconcolor,
      required this.iconbgcolor,
      required this.checkmarkdata,
      required this.checkmarkcolor,
      required this.checkmarkbgcolor,
      required this.checkmarkiconsize,
      required this.containercolor})
      : super(key: key);
  final Function()? onTap;
  final String title;
  final IconData icondata;
  final Color iconcolor;
  final Color iconbgcolor;
  final IconData checkmarkdata;
  final Color checkmarkcolor;
  final Color checkmarkbgcolor;
  final double checkmarkiconsize;
  final Color containercolor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 75,
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        color: containercolor,
                        child: Row(
                          children: [
                            const SizedBox(width: 15),
                            Container(
                              height: 33,
                              width: 36,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: iconbgcolor),
                              child: Icon(icondata, color: iconcolor),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                title, //Josefin Sans  ysabeau
                                style: GoogleFonts.ysabeau(
                                    fontSize: 18,
                                    letterSpacing: 0.5,
                                    color: const Color(0xFFf3fafb),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Container(
                              height: 33,
                              width: 36,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: checkmarkbgcolor),
                              child: Center(
                                child: Icon(checkmarkdata,
                                    color: checkmarkcolor,
                                    size: checkmarkiconsize),
                              ),
                            ),
                            const SizedBox(width: 15)
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15)
        ],
      ),
    );
  }
}
