import 'package:flutter/material.dart';
import 'package:flutter_ui_text/pages/bottomnav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      title: 'Grid Ui',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
         primaryColor:Colors.white,
        useMaterial3: true,
      ),
      home: const BottomNav(),  
      routes: {
          '/': (context) => const BottomNav(),
      },
    );
  }
}
