// ignore_for_file: use_build_context_synchronously
import 'package:TaskTrek/components/my_neubutton.dart';
import 'package:TaskTrek/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final youremailController = TextEditingController();

  @override
  void dispose() {
    youremailController.dispose();
    super.dispose();
  }

  Future resetpassword() async {
    //show loding page
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Lottie.asset(
          'animations/loading.json',
          fit: BoxFit.scaleDown,
        ),
      ),
    );
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: youremailController.text.trim());
      //loading stop
      Navigator.pop(context);
      //email-sent message on dispaly
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                backgroundColor: Color(0xFF090a0e),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFFdef7e5))),
                icon: Icon(Icons.mark_email_read_outlined,
                    color: Color(0xFF92e3a9)),
                title: Text(
                  "we have e-mailed your password reset link!!\n(if our e-mail not found: check your SPAM folder)",
                  style: TextStyle(color: Color(0xFFbdbdbd)),
                ),
              ));
    } on FirebaseAuthException catch (e) {
      //loading stop
      Navigator.pop(context);
      showErrorMessage(e.message.toString());
    }
  }

  /// errormessage //////////////////////////
  void showErrorMessage(String errormessage) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: const Color(0xFF090a0e),
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xFFdef7e5))),
              icon: const Icon(Icons.error_outline_outlined,
                  color: Color(0xFFffc727)),
              title: Text(
                errormessage,
                style: const TextStyle(color: Color(0xFFbdbdbd)),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090a0e),
      appBar: AppBar(
        title: Text(
          'Forgot You\'r Password...?',
          style: GoogleFonts.carterOne(color: const Color(0xFFdbdbdb)),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF090a0e),
        elevation: 1.5,
        shadowColor: const Color(0xFFdbdbdb),
      ),
      body: ListView(
        children: [
          SafeArea(
              child: Center(
            child: SizedBox(
              width: 414,
              child: Column(
                children: [
                  const SizedBox(height: 0),
                  //logo
                  Image.asset(
                    'images/forgotpass.png',
                    height: 300,
                  ),
                  //greetings
                  const SizedBox(height: 25),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        'Enter your user account\'s email address and we will send you a password reset link.....',
                        // maxLines: 1,
                        softWrap: true,
                        style: GoogleFonts.ysabeau(
                            fontSize: 19,
                            letterSpacing: 0.5,
                            color: const Color(0xFFf3fafb),
                            fontWeight: FontWeight.w400),
                      ),
                    ))
                  ]),
                  //email text field
                  const SizedBox(height: 25),
                  MyTextField(
                      controller: youremailController,
                      hintText: 'Email',
                      enabledme: true,
                      height: 55,
                      maxLines: 1,
                      toptextborder: 0,
                      fillColorhash: 0xFF090a0e,
                      textcolorhash: 0xFFbdbdbd,
                      hintcolorhash: 0XFFe5b323,
                      bordercolor: 0xFFbdbdbd,
                      obscureText: false),

                  //send reset email
                  const SizedBox(height: 50),
                  MyNeuButton(
                    name: 'Reset password',
                    onTap: resetpassword,
                    buttonwidth: 414,
                    testcolor: 0xFF000000,
                    fillColorhash: 0xFFffc727, //0xFFffc727
                    topleftshadowcolor: 0xFF090a0e,
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
