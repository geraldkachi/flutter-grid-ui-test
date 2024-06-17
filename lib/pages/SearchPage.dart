import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ui_text/conponents/my_darwer.dart';
import 'package:flutter_ui_text/pages/grid-list.dart';
import 'package:flutter_ui_text/pages/searchbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        iconTheme: IconThemeData(color: Colors.white),

        // leading: IconButton(
        //   icon: const Icon(Icons.menu),
        //   color: Colors.white,
        //   iconSize: 30.0,
        //   onPressed: () {
        //     _key.currentState!.openDrawer(); //<-- SEE HERE
        //     Scaffold.of(context).openDrawer();
        //     print('help');

        //   },
        // ),
        title: const Center(
            child: Text("Zidio Authentication",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ))),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.notifications_none_outlined),
              color: Colors.white,
              iconSize: 30.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Container()),
                );
              }),
        ],
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: <Widget>[
          const SearchComp(),
          Expanded(
              child: Container(
            height: 500.0,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: const Column(
              children: <Widget>[GridList()],
            ),
          ))
        ],
      ),
    );
  }
}
