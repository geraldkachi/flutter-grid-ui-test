import 'package:flutter/material.dart';
import 'package:flutter_ui_text/conponents/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CrudFire extends StatefulWidget {
  const CrudFire({super.key});

  @override
  State<CrudFire> createState() => _CrudFireState();
}

class _CrudFireState extends State<CrudFire> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();

  final CollectionReference _staffs = FirebaseFirestore.instance.collection("staffs");

  void addStaff() {
    _staffs.add({
      "name": _nameController.text,
      "profession": _professionController.text,
    }).then((value) {
      _nameController.clear();
      _professionController.clear();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Staff Added"),
      ));
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
      ));
    });
  }

  void editStaff(DocumentSnapshot staff) async {
    _nameController.text = staff['name'];
    _professionController.text = staff['profession'];
    showDialog(context: context, builder: (context){
        return AlertDialog(
          title: const Text("Edit staff"),
          content: Column(children: [
            TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelText: 'Enter your name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0))),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _professionController,
                  // decoration: InputDecoration(labelText: "Enter your profession"),
                  decoration: InputDecoration(
                      labelText: 'Enter your profession',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0))),
                ),
          ],),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel",  style: TextStyle(color: Colors.red),)),
            TextButton(
                  child: Text('Update', style: TextStyle(color: Colors.black),),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _updateStaff(staff.id); 
                      Navigator.pop(context);
                    }
                  },),
          ],
        );
    });
  }
  void _updateStaff(String staffId) async {
    _staffs.doc(staffId).update({
      'name' : _nameController.text,
      'profession': _professionController.text,
    }).then((value) {
      _nameController.clear();
      _professionController.clear();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Staff Added"),
      ));
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
      ));
    });
  }

  void deleteStaff(String staffId) async {
    await _staffs.doc(staffId).delete().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Staff Deleted"),
      ));
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Firebase Crud"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  // decoration: InputDecoration(labelText: "Enter your name"),
                  decoration: InputDecoration(
                      labelText: 'Enter your name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0))),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _professionController,
                  // decoration: InputDecoration(labelText: "Enter your profession"),
                  decoration: InputDecoration(
                      labelText: 'Enter your profession',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0))),
                ),
                const SizedBox(height: 20),
                MyButton(
                  text: 'Add Staff',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      addStaff();
                    }
                  },
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: StreamBuilder(
                        stream: _staffs.snapshots(),
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
                          final staffs = snapshot.data!.docs;

                          return ListView.builder(
                              itemCount: staffs.length,
                              itemBuilder: (context, index) {
                                                        
                                final staffItem = snapshot.data!.docs[index];
                                final staff = staffs[index].data() as Map<String, dynamic>?; // Ensure the data is a Map
                                // Safely access the fields with null checks
                                final name = staff?['name'] ?? 'No Name';
                                final profession = staff?['profession'] ?? 'No profession';

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.primary,
                                      borderRadius: BorderRadius.circular(12)
                                    ),
                                    child: Dismissible(
                                      key: Key(staffItem.id),
                                      background: Container(
                                        padding: const EdgeInsets.only(right: 20),
                                        color: Colors.redAccent,
                                        alignment: Alignment.centerRight,
                                        child:const Icon(Icons.delete, color: Colors.white,) 
                                        ,),
                                      onDismissed: (direction) {
                                        deleteStaff(staffItem.id);
                                      },
                                      direction: DismissDirection.endToStart,
                                      child: ListTile(
                                          title: Text(name),
                                          subtitle: Text(profession),
                                          leading: const Icon(Icons.person),
                                          trailing: Column(
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.edit),
                                                onPressed: () async {
                                                  editStaff(staffItem);
                                                },
                                              ),
                                              // IconButton(
                                              //   icon: const Icon(Icons.delete),
                                              //   onPressed: () async {
                                              //     print(index);
                                              //     deleteStaff(id);
                                              //   },
                                              // ),
                                            ],
                                          )),
                                    ),
                                  ),
                                );
                              });
                        }))
              ],
            ),
          ),
        ));
  }
}
