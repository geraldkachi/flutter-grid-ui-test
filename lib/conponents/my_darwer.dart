import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // width: MediaQuery.of(context).size.width * 0.9, //<-- SEE HERE
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Column(
                  children: [
                     DrawerHeader(
                      decoration: const BoxDecoration(
                        // color: Colors.grey,
                      ),
                      child: Icon(Icons.favorite, color: Theme.of(context).colorScheme.inversePrimary,)
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.home,
                      ),
                      title: const Text('Home'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.train,
                      ),
                      title: const Text('Flutter Crud'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/crud');
                      },
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(
                  Icons.logout_rounded,
                ),
                title: const Text('Log Out'),
                onTap: () async {
                  // Navigator.pop(context);
                  await FirebaseAuth.instance.signOut();
                },
              ),
            ),
          ]),
    );
  }
}
