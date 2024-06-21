import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_text/conponents/my_darwer.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';



class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Current user
  final User? currentUser = FirebaseAuth.instance.currentUser;
  File? _image;
  // final picker = ImagePicker();

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetail() async {
    if (currentUser == null) {
      throw Exception("User not logged in");
    }

    return await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
  }

  // Future pickImage() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }
  

  // Future uploadImage() async {
  //   if (_image == null) return;

  //   try {
  //     final storageRef = FirebaseStorage.instance
  //         .ref()
  //         .child('profileImages')
  //         .child(currentUser!.uid + '.jpg');
  //     await storageRef.putFile(_image!);

  //     final imageUrl = await storageRef.getDownloadURL();
  //     await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).update({
  //       'profileImageUrl': imageUrl,
  //     });

  //     print('Profile image uploaded and URL saved to Firestore.');
  //   } catch (e) {
  //     print('Failed to upload image: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetail(),
        builder: (context, snapshot) {
          // Handle loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // Handle errors
          else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }
          // Handle data received
          else if (snapshot.hasData) {
            // Extract data
            Map<String, dynamic>? user = snapshot.data!.data();
            if (user == null) {
              return const Center(
                child: Text("No Data Available"),
              );
            }

            // Safely access the fields with null checks
            final username = user['username'] ?? 'No username';
            final email = user['email'] ?? 'No email';
            final profileImageUrl = user['profileImageUrl'] ?? '';

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const SizedBox(height: 20),
                  // _image == null
                  //     ? (profileImageUrl.isNotEmpty
                  //         ? Image.network(profileImageUrl, height: 150)
                  //         : const Icon(Icons.person, size: 100))
                  //     : Image.file(_image!, height: 150),
                  // const SizedBox(height: 20),
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   // onPressed: pickImage,
                  //   child: const Text('Pick Image'),
                  // ),
                  // const SizedBox(height: 20),
                  // ElevatedButton(
                  //   onPressed: (){},
                  //   // onPressed: uploadImage,
                  //   child: const Text('Upload Image'),
                  // ),
                  const Icon(Icons.person, size: 100),
                  const SizedBox(height: 20),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text("No Data Available"),
            );
          }
        },
      ),
    );
  }
}
