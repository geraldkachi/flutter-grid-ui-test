import 'package:flutter/material.dart';
import 'package:flutter_ui_text/auth/auth.dart';
import 'package:flutter_ui_text/pages/bottomnav.dart';
import 'package:flutter_ui_text/pages/crud.dart';
import 'package:flutter_ui_text/pages/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_ui_text/pages/wallPostPage.dart';
import 'package:flutter_ui_text/theme/dark-mode.dart';
import 'package:flutter_ui_text/theme/light-mode.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/lg',
      title: 'Grid Ui',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //    primaryColor:Colors.white,
      //    secondaryHeaderColor:Colors.blue,
      //   useMaterial3: true,
      // ),
      theme: lightMode,
      darkTheme: darkMode,
       home: const LoginScreen(),
      routes: {
        '/lg': (context) => const AuthPage(),
        '/crud': (context) => const CrudFire(),
        // '/login': (context) => LoginScreen(),
        // '/register': (context) => RegisterScreen(),
        '/home': (context) => const BottomNav(),
        '/wall': (context) => WallPostPage(),
      }, 

      // home: const BottomNav(),  
      // routes: {
      //     '/home': (context) => const BottomNav(),
      // },
    );
  }
}
