import 'dart:async';
import 'package:TaskTrek/pages/authentication%20pages/check_user_state.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const TheUserState()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090a0e),
      body: Center(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Image.asset("images/splash.png"),
          ),
        ),
      ),
    );
  }
}
