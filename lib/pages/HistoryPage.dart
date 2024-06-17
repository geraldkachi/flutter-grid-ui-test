import 'package:flutter/material.dart';
import 'package:flutter_ui_text/conponents/my_darwer.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

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
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              padding: const EdgeInsets.all(25),
              child: const Icon(Icons.person),
            ),
            Text('History'),
          ],
        ));
  }
}
