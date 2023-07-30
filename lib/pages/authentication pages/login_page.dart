import 'package:TaskTrek/components/my_neubutton.dart';
import 'package:TaskTrek/components/my_textfield.dart';
import 'package:TaskTrek/components/square_image_neubutton.dart';
import 'package:TaskTrek/pages/authentication%20pages/forgot_password_page.dart';
import 'package:TaskTrek/pages/authentication%20pages/registernow_page.dart';
import 'package:TaskTrek/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  /// errormessage
  void showErrorMessage(String errormessage) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: const Color(0xFF090a0e),
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xFFdef7e5))),
              icon: const Icon(Icons.error_outline_outlined,
                  color: Color(0xFF92e3a9)),
              title: Text(
                errormessage,
                style: const TextStyle(color: Color(0xFFbdbdbd)),
              ),
            ));
  }

  // forgot passowrd user in method
  void forgotpassowrd() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ForgotPasswordPage(),
        )).then((value) => setState(() {}));
  }

  //register
  void registernow() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegisterPage(),
        )).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    // sigin user in method
    void signUserIn() async {
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
      //sign in
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: usernameController.text,
                password: passwordController.text)
            .then((value) {
          Navigator.pop(context);
          Phoenix.rebirth(context);
        });
      } on FirebaseAuthException catch (e) {
        Navigator.of(context).pop();
        //show error
        showErrorMessage(e.message.toString());
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFF090a0e),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SafeArea(
              child: Center(
            child: SizedBox(
              width: 414,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  //logo
                  Image.asset(
                    'images/login.png',
                    height: 250,
                  ),
                  //greetings
                  const SizedBox(height: 10),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      'Hello there it\'s been a while...',
                      style: GoogleFonts.ysabeau(
                        fontSize: 16,
                        letterSpacing: 0.5,
                        color: const Color(0xFFf3fafb),
                      ),
                    ),
                    Text(
                      'WELCOME BACK!!',
                      style: GoogleFonts.ysabeau(
                          fontSize: 16,
                          //letterSpacing: 0.5,
                          color: const Color(0xFF92e3a9),
                          fontWeight: FontWeight.w700),
                    ),
                  ]),
                  //email text field
                  const SizedBox(height: 25),
                  MyTextField(
                      controller: usernameController,
                      hintText: 'Email',
                      enabledme: true,
                      height: 55,
                      maxLines: 1,
                      toptextborder: 0,
                      fillColorhash: 0xFF090a0e,
                      textcolorhash: 0xFFbdbdbd,
                      hintcolorhash: 0XFF71c689,
                      bordercolor: 0xFFbdbdbd,
                      obscureText: false),
                  //password text feld
                  const SizedBox(height: 10),
                  MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      enabledme: true,
                      height: 55,
                      maxLines: 1,
                      toptextborder: 0,
                      fillColorhash: 0xFF090a0e,
                      textcolorhash: 0xFFbdbdbd,
                      hintcolorhash: 0XFF71c689,
                      bordercolor: 0xFFbdbdbd,
                      obscureText: true),
                  //forgot password
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: forgotpassowrd,
                            child: Text(
                              'Forgot Password?',
                              style: GoogleFonts.ysabeau(
                                  fontSize: 16,
                                  //letterSpacing: 0.5,
                                  color: const Color(0xFFf3fafb),
                                  fontWeight: FontWeight.w500),
                            ))
                      ],
                    ),
                  ),
                  //signin
                  const SizedBox(height: 25),
                  MyNeuButton(
                      name: 'Sign In',
                      onTap: signUserIn,
                      buttonwidth: 414,
                      testcolor: 0xFF000000,
                      fillColorhash: 0xFF92e3a9,
                      topleftshadowcolor: 0xFF090a0e),
                  // or continue with
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Color(0xFF92e3a9),
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Or continue with',
                              style: GoogleFonts.ysabeau(
                                  fontSize: 16,
                                  //letterSpacing: 0.5,
                                  color: const Color(0xFF92e3a9),
                                  fontWeight: FontWeight.w600),
                            )),
                        const Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Color(0xFF92e3a9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //google and facebook
                  const SizedBox(height: 20),
                  SquareIMGnewButton(
                      imagePath: 'images/google.png',
                      imagepadding: 18,
                      onTap: () => AuthServices().signineitgoogle(),
                      heightofbox: 65,
                      fillColorhash: 0xFFbdbdbd, // 0xFF141a1d
                      borderRadius: 16,
                      topleftshadowcolor: 0xFF090a0e,
                      leftshadowspreadRadius: -1.5,
                      bottonrightshadowcolor: 0xFF070707,
                      rightshadowspreadRadius: 3,
                      blurbeforepressed: 9,
                      offsetbeforepressed: 4,
                      bluronpressed: 6,
                      offsetonpressed: 3),
                  // not a member? register now
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: registernow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not a member?',
                          style: GoogleFonts.ysabeau(
                            fontSize: 16,
                            letterSpacing: 0.5,
                            color: const Color(0xFF92e3a9),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Register now',
                          style: GoogleFonts.ysabeau(
                              fontSize: 16,
                              letterSpacing: 0.5,
                              color: const Color(0xFFf3fafb),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
