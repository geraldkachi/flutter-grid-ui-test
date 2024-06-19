import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_text/conponents/my_darwer.dart';
import 'package:flutter_ui_text/conponents/my_post_button.dart';
import 'package:flutter_ui_text/conponents/my_textfield.dart';
import 'package:flutter_ui_text/database/firestore.dart';

class WallPostPage extends StatelessWidget {
   WallPostPage({super.key});

  // firestore access
  final FirebstoreDatabase database = FirebstoreDatabase();

  final _newPostController = TextEditingController();
  void postMessage() {
    // only post a message if there is something in the field
    if (_newPostController.text.trim().isNotEmpty) {
      String message = _newPostController.text;
      database.addPost(message);
    }
    // clear controller
      _newPostController.clear();
  }

  void editPost(String post) {
    // _newPostController.text = post['text'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('W A L L'),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(child: MyTextField(hintText: "Say something...", obscureText: false, controller: _newPostController, decoration: InputDecoration(
                    labelText: '',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0))),)),
                PostButton(onTap: postMessage)
              ],
            ),
            ),

            //Post list
            StreamBuilder(stream: database.getPostsStream(),
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

              final posts = snapshot.data!.docs;

              // return list of all posts
              return Expanded(
                child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        //post identifier
                        final postId = snapshot.data!.docs[index];
                        // get each individual post 
                        final post = posts[index];
                        // get data from each post 
                        String message = post['postMessage'];
                        String userEmail = post['userEmail'];
                        Timestamp timeStamp = post['timeStamp'];
                        
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Dismissible(
                              key: Key(postId.id),
                              background: Container(
                                padding: EdgeInsets.only(right: 20),
                                color: Colors.redAccent,
                                alignment: Alignment.centerRight,
                                child:Icon(Icons.delete, color: Colors.white,) 
                                ,),
                              onDismissed: (direction) {
                                database.deletePost(postId.id);
                              },
                              direction: DismissDirection.endToStart,
                              child: ListTile(
                                title: Text(message),
                                subtitle: Text(userEmail),
                                // subtitle: Text(posts[index].data()['time']),
                                leading: const Icon(Icons.person),
                                trailing: IconButton(icon: Icon(Icons.delete), 
                                onPressed: () async {
                                     await database.deletePost(postId.id);
                                 },),
                              ),
                            ),
                          ),
                        );
                      },
                ),);

             })
        ],
      ),
    );
  }
}