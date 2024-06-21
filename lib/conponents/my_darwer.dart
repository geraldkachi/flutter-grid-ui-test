import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final User? user = FirebaseAuth.instance.currentUser;
  String? profileImageUrl;
  String? username;
  String? email;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
    _loadUserDetails();
  }

  // Get the logged-in user details
  Future<void> _loadUserDetails() async {
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      final userData = doc.data();
      if (userData != null) {
        setState(() {
          username = userData['username'];
          email = userData['email'];
          profileImageUrl = userData['profileImageUrl'];
        });
      }
    }
  }

  Future<void> _loadProfileImage() async {
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      setState(() {
        profileImageUrl = doc.data()?['profileImageUrl'];
      });
    }
  }

  Future<void> _pickAndUploadImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      String fileName = '${user!.uid}.jpg';
      try {
        UploadTask uploadTask = FirebaseStorage.instance.ref('profile_images/$fileName').putFile(file);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({'profileImageUrl': downloadUrl});
        setState(() {
          profileImageUrl = downloadUrl;
        });
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(username ?? 'Loading...'),
                accountEmail: Text(email ?? 'Loading...'),
                currentAccountPicture: GestureDetector(
                  onTap: (){},
                  // onTap: _pickAndUploadImage,
                  child: CircleAvatar(
                    child: ClipOval(
                      child: profileImageUrl != null
                          ? Image.network(
                              profileImageUrl!,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            )
                          : const Icon(
                              Icons.person,
                              size: 90,
                            ),
                    ),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                    image: NetworkImage('https://cdn.pixabay.com/photo/2023/11/09/19/36/zoo-8378189_1280.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/home');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: const Text('Wall'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/wall');
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(
                Icons.logout_rounded,
              ),
              title: const Text('Log Out'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
