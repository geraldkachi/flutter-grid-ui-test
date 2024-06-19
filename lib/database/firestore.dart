

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebstoreDatabase {
  // current login user
    User? user = FirebaseAuth.instance.currentUser;

  // get collection of posts from firestore
  final CollectionReference posts = FirebaseFirestore.instance.collection("posts");
  //post a message 

  Future<void> addPost(String post) async {
    // await posts.add(post.toJson());
    await posts.add({
      "userEmail": user!.email,
      "postMessage": post,
      "timeStamp": Timestamp.now()
    });
  }

  // read post from database
  Stream<QuerySnapshot<Map<String, dynamic>>> getPostsStream() {
    final postsStream =  FirebaseFirestore.instance
    .collection('posts')
    .orderBy('timeStamp', descending: true)
    .snapshots();
    return postsStream;
  }

  // delete a post
  Future<void> deletePost(String documentId) async {
    await posts.doc(documentId).delete();
  }
}