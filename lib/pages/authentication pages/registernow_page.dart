import 'package:TaskTrek/components/my_neubutton.dart';
import 'package:TaskTrek/components/my_textfield.dart';
import 'package:TaskTrek/components/square_image_neubutton.dart';
import 'package:TaskTrek/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final displayNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  // signup user in method
  void signUserUp() async {
    if (passwordController.text == confirmpasswordController.text) {
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
      //creating user
      try {
        final myUserCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        //update dispalyname
        await myUserCredential.user
            ?.updateDisplayName(displayNameController.text.toString())
            .then((value) {
          Phoenix.rebirth(context);
        });
      } on FirebaseAuthException catch (e) {
        //loading stop
        Navigator.pop(context);
        showErrorMessage(e.message.toString());
      }
    } else {
      showErrorMessage('Password-Don\'t-Match');
    }
  }

  /// errormessage
  void showErrorMessage(String errormessage) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: const Color(0xFF090a0e),
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xFFe6e6e6))),
              icon: const Icon(Icons.error_outline_outlined,
                  color: Color(0xFFff725e)),
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
      body: ListView(
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
                    'images/createaccount2.png',
                    height: 250,
                  ),
                  const SizedBox(height: 10),
                  //Let's Create an account for you...
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      'Let\'s ',
                      style: GoogleFonts.ysabeau(
                        fontSize: 16,
                        letterSpacing: 0.5,
                        color: const Color(0xFFf3fafb),
                        //fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      'Create ',
                      style: GoogleFonts.ysabeau(
                          fontSize: 16,
                          letterSpacing: 0.5,
                          color: const Color(0xFFff725e),
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'an account for you...',
                      style: GoogleFonts.ysabeau(
                        fontSize: 16,
                        letterSpacing: 0.5,
                        color: const Color(0xFFf3fafb),
                      ),
                    ),
                  ]),
                  //Display Name text field
                  const SizedBox(height: 25),
                  MyTextField(
                      controller: displayNameController,
                      hintText: 'Display Name',
                      enabledme: true,
                      height: 55,
                      maxLines: 1,
                      toptextborder: 0,
                      fillColorhash: 0xFF090a0e,
                      textcolorhash: 0xFFbdbdbd,
                      hintcolorhash: 0xFFe4523d,
                      bordercolor: 0xFFbdbdbd,
                      obscureText: false),

                  //email text field
                  const SizedBox(height: 10),
                  MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      enabledme: true,
                      height: 55,
                      maxLines: 1,
                      toptextborder: 0,
                      fillColorhash: 0xFF090a0e,
                      textcolorhash: 0xFFbdbdbd,
                      hintcolorhash: 0xFFe4523d,
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
                      hintcolorhash: 0xFFe4523d,
                      bordercolor: 0xFFbdbdbd,
                      obscureText: true),
                  //Confirm password text feld
                  const SizedBox(height: 10),
                  MyTextField(
                      controller: confirmpasswordController,
                      hintText: 'Confirm Password',
                      enabledme: true,
                      height: 55,
                      maxLines: 1,
                      toptextborder: 0,
                      fillColorhash: 0xFF090a0e,
                      textcolorhash: 0xFFbdbdbd,
                      hintcolorhash: 0xFFe4523d,
                      bordercolor: 0xFFbdbdbd,
                      obscureText: true),
                  //create me - button
                  const SizedBox(height: 30),
                  MyNeuButton(
                    name: 'Create Me',
                    onTap: signUserUp,
                    buttonwidth: 414,
                    testcolor: 0xFF000000,
                    fillColorhash: 0xFFff725e, //0xFFff725e
                    topleftshadowcolor: 0xFF090a0e,
                  ),
                  // or continue with
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Color(0xFFff725e),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: GoogleFonts.ysabeau(
                                fontSize: 16,
                                //letterSpacing: 0.5,
                                color: const Color(0xFFff725e),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Color(0xFFff725e),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //google
                  const SizedBox(height: 20),
                  SquareIMGnewButton(
                      imagePath: 'images/google.png',
                      imagepadding: 18,
                      onTap: () => AuthServices().signineitgoogle(),
                      heightofbox: 65,
                      fillColorhash: 0xFFbdbdbd,
                      borderRadius: 16,
                      topleftshadowcolor: 0xFF090a0e,
                      bottonrightshadowcolor: 0xFF070707,
                      leftshadowspreadRadius: -1.5,
                      rightshadowspreadRadius: 3,
                      blurbeforepressed: 9,
                      offsetbeforepressed: 4,
                      bluronpressed: 6,
                      offsetonpressed: 3),
                  // not a member? register now
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already Have a account?',
                          style: GoogleFonts.ysabeau(
                            fontSize: 16,
                            letterSpacing: 0.5,
                            color: const Color(0xFFff725e),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Sign In',
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
