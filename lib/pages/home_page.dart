import 'package:TaskTrek/pages/navigationbar/Task_Nav_Bar.dart';
import 'package:TaskTrek/pages/to%20do%20pages/create_edit/todo_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class MyHomepage extends StatefulWidget {
  const MyHomepage({super.key});

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
// to get user details
  final user = FirebaseAuth.instance.currentUser!;
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
      body: Container(
        color: Colors.black,
        // container to hold my home page
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // container of animation and welcome text
                Container(
                    color: Colors.black,
                    height: 310,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Lottie.asset(
                            'animations/hello.json',
                            height: 300,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Column(
                              children: [
                                const SizedBox(height: 60),
                                SizedBox(
                                  width: 400,
                                  // color: Colors.purple,
                                  child: Text(
                                    'welcome back,',
                                    style: GoogleFonts.ysabeau(
                                        fontSize: 20,
                                        letterSpacing: 0.5,
                                        color: const Color(0xffffe600),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                      width: 300,
                                      child: Text(
                                        user.displayName
                                            .toString()
                                            .toUpperCase(),
                                        style: GoogleFonts.carterOne(
                                            fontSize: 30,
                                            color: const Color(0xFFf3fafb)),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),

                // container of to do list
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color(0xFF090a0e),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      //devider
                      const Divider(
                        thickness: 0.4,
                        color: Colors.yellow,
                      ),
                      const SizedBox(height: 1),
                      //'It always seems IMPOSSIBLE until it\'s DONE',
                      RichText(
                          text: TextSpan(
                              //tektur Ysabeau Infant
                              style: GoogleFonts.ysabeau(
                                  fontSize: 15.578,
                                  letterSpacing: 0.1,
                                  color: const Color(0xFFf3fafb),
                                  fontWeight: FontWeight.w600),
                              children: [
                            const TextSpan(text: 'It always seems  '),
                            TextSpan(
                                text: 'IMPOSSIBLE',
                                style: GoogleFonts.ysabeau(
                                  color: Colors.red.shade300,
                                )),
                            const TextSpan(text: '  until it\'s '),
                            TextSpan(
                                text: ' DONE! ',
                                style: GoogleFonts.ysabeau(
                                    color: Colors.yellow.shade300)),
                          ])),
                      const SizedBox(height: 1),
                      //devider
                      const Divider(
                        thickness: 0.2,
                        color: Colors.yellow,
                      ),

                      // your tasks title
                      RichText(
                          text: TextSpan(
                              style: GoogleFonts.carterOne(
                                fontSize: 40,
                              ),
                              children: const [
                            TextSpan(
                                text: 'Your',
                                style: TextStyle(
                                  color: Color(0xFFf3fafb),
                                  decoration: TextDecoration.underline,
                                )),
                            TextSpan(text: ' '),
                            TextSpan(
                                text: 'Tasks',
                                style: TextStyle(
                                    color: Color(0xff1cf4f4),
                                    decoration: TextDecoration.underline)),
                          ])),
                      const SizedBox(height: 20),
                      // todo card list
                      ToDoCard(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TaskNavigationbar(
                                            openedindex: 0)));
                          },
                          title: 'All Task\'s',
                          containercolor: const Color(0xff2a2e3d),
                          checkmarkdata: Icons.arrow_right_rounded,
                          checkmarkcolor: const Color(0xFFf3fafb),
                          checkmarkbgcolor: const Color(0xff2a2e3d),
                          checkmarkiconsize: 35,
                          icondata: Icons.star_half,
                          iconcolor: const Color(0xFF090a0e),
                          iconbgcolor: const Color(0xffD1CC46)),
                      ToDoCard(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TaskNavigationbar(
                                            openedindex: 1)));
                          },
                          title: 'Important Task\'s',
                          containercolor: const Color(0xff2a2e3d),
                          checkmarkdata: Icons.arrow_right_rounded,
                          checkmarkcolor: const Color(0xFFf3fafb),
                          checkmarkbgcolor: const Color(0xff2a2e3d),
                          checkmarkiconsize: 35,
                          icondata: Icons.star,
                          iconcolor: const Color(0xFF090a0e),
                          iconbgcolor: const Color(0xfff9c31f)),
                      ToDoCard(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TaskNavigationbar(
                                            openedindex: 2)));
                          },
                          title: 'Planned Task\'s',
                          containercolor: const Color(0xff2a2e3d),
                          checkmarkdata: Icons.arrow_right_rounded,
                          checkmarkcolor: const Color(0xFFf3fafb),
                          checkmarkbgcolor: const Color(0xff2a2e3d),
                          checkmarkiconsize: 35,
                          icondata: Icons.star_border,
                          iconcolor: const Color(0xFF090a0e),
                          iconbgcolor: const Color(0xff1cf4f4)),

                      ToDoCard(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TaskNavigationbar(
                                            openedindex: 3)));
                          },
                          title: 'Achieved Task\'s',
                          containercolor: const Color(0xff2a2e3d),
                          checkmarkdata: Icons.arrow_right_rounded,
                          checkmarkcolor: const Color(0xFFf3fafb),
                          checkmarkbgcolor: const Color(0xff2a2e3d),
                          checkmarkiconsize: 35,
                          icondata: Icons.done_all,
                          iconcolor: const Color(0xFF090a0e),
                          iconbgcolor: const Color(0xff6cf8a9)),

                      ToDoCard(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TaskNavigationbar(
                                            openedindex: 4)));
                          },
                          title: 'Not Achieved Task\'s',
                          containercolor: const Color(0xff2a2e3d),
                          checkmarkdata: Icons.arrow_right_rounded,
                          checkmarkcolor: const Color(0xFFf3fafb),
                          checkmarkbgcolor: const Color(0xff2a2e3d),
                          checkmarkiconsize: 35,
                          icondata: Icons.close,
                          iconcolor: const Color(0xFFf3fafb),
                          iconbgcolor: const Color(0xFF090a0e)),
                      //------------------------------------
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
