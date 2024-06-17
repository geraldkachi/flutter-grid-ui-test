import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class CrudFire extends StatefulWidget {
  const CrudFire({super.key});

  @override
  State<CrudFire> createState() => _CrudFireState();
}

class _CrudFireState extends State<CrudFire> {
  final TextEditingController _nameController= TextEditingController();
  final TextEditingController _professionController= TextEditingController();

  // CollectionReference _users = FirebaseFirestore.instance.collection("users")

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: const Text("Firebase Crud"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            TextFormField(
              controller: _nameController,
              // decoration: InputDecoration(labelText: "Enter your name"),
              decoration: InputDecoration(
                    labelText: 'Enter your name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0))),
            ),
            const SizedBox(height: 16,),
            TextFormField(
              controller: _professionController,
              // decoration: InputDecoration(labelText: "Enter your profession"),
              decoration: InputDecoration(
                    labelText: 'Enter your profession',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0))),
            ),
            
          ],),
          )
    );
  }
}