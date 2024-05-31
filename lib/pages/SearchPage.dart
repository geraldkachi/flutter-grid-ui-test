import 'package:flutter/material.dart';
import 'package:flutter_ui_text/pages/grid-list.dart';
import 'package:flutter_ui_text/pages/searchbar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.white,
          iconSize: 30.0,
          onPressed: () => {},
        ),
        title: const Center(
            child: Text("Logo",
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
              children: <Widget>[
                GridList()  
              ],
            ),
          ))
        ],
      ),
    );
  }
}
