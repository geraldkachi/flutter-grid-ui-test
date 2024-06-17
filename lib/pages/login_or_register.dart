import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_text/pages/bottomnav.dart';
import 'package:flutter_ui_text/pages/loginPage.dart';
import 'package:flutter_ui_text/pages/registerPage.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginInPage = true;

  void togglePages() {
    setState(() {
      showLoginInPage = !showLoginInPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginInPage) {
      return LoginScreen(onTap: togglePages);
    } else {
      return RegisterScreen(onTap: togglePages);
    }
    // return StreamBuilder<User?>(
    //     stream: FirebaseAuth.instance.authStateChanges(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return CircularProgressIndicator();
    //       }
    //       if (snapshot.hasData) {
    //         return BottomNav();
    //       }
    //       return LoginScreen();
    //     });
  }
}
