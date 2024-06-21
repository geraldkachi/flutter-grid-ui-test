import 'package:flutter/material.dart';
import 'package:flutter_ui_text/conponents/my_back_button.dart';
import 'package:flutter_ui_text/conponents/my_darwer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Center(
          child: Text(
            "Zidio Project",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
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
            },
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          // Handle errors
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          // Handle loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Check if data is available
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          }

          // Get the list of users
          final users = snapshot.data!.docs;

          return Column(
            children: [
              // const Padding(padding: EdgeInsets.only(top:50, left: 25), 
              // child: Row(
              //   children: [
              //       MyBackButton()
              //   ],
              // ),
              // ),
              // const SizedBox(height: 20,),
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index].data() as Map<String, dynamic>?; // Ensure the data is a Map
                
                    // Safely access the fields with null checks
                    final username = user?['username'] ?? 'No username';
                    final email = user?['email'] ?? 'No email';
                
                    return ListTile(
                      title: Text(username),
                      subtitle: Text(email),
                      leading: const Icon(Icons.person),
                      
                      trailing: IconButton(icon: const Icon(Icons.headphones), 
                      onPressed: () async {
                              // print(index);
                              //  await database.deletePost(index.toString());
                              //  await database.deletePost(message);
                               },
                      )
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
