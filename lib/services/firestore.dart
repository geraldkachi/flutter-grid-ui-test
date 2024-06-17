import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  // get all collection notes
  final CollectionReference notes = FirebaseFirestore.instance.collection("notes");

  // Create a new Firestore
  Future<void> addNote(String note) {
    return notes.add({
      "note": note,
      'timestamp': Timestamp.now() 
    });
  }
  // get note from Firestore
  Stream<QuerySnapshot> getNotesStream(String note) {
    final notesStream = notes.orderBy('timestamp', descending: true).snapshots();
    return notesStream;
  }

// Update notes from Firestore
  Future<void> updateNote(String note, String id) {
    return notes.doc(id).update({
      "note": note,
      'timestamp': Timestamp.now() 
    });
  }

  // Delete note from Firestore
  Future<void> deleteNote(String id) {
    return notes.doc(id).delete();
  }

}