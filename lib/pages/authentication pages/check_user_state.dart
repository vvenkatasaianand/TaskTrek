import 'package:TaskTrek/pages/navigationbar/Bot_Nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class TheUserState extends StatelessWidget {
  const TheUserState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x00000000),
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // if user is logged in
            if (snapshot.hasData) {
              return const BotNavigationbar();
            }
            // if user is not logged in
            else {
              return const LogInPage();
            }
          }),
    );
  }
}
