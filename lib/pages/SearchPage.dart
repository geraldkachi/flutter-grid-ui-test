import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      drawer: Drawer(
        // width: MediaQuery.of(context).size.width * 0.9, //<-- SEE HERE
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Text('Drawer Header'),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Column(
                  children: [
                     ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: const Text('Page 1'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.train,
                ),
                title: const Text('Page 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
                  ],
                 ),
              
              
              ListTile(
                leading: const Icon(
                  Icons.logout_rounded,
                ),
                title: const Text('Log Out'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
                ],
              ),
            )
          ],
        ),
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
              children: <Widget>[GridList()],
            ),
          ))
        ],
      ),
    );
  }
}
