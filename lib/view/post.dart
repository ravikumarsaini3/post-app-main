import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:post_app/model_provider/post_provider.dart';
import 'package:post_app/postfunction.dart';
import 'package:post_app/utility/routs/routsname.dart';
import 'package:provider/provider.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    Postfunction postfuncation = Postfunction();
    //  final auth = FirebaseAuth.instance;
    // final User? user = auth.currentUser;

    // final String uid = user!.uid;
    final ref = FirebaseFirestore.instance.collection('posts').snapshots();
    final provider = Provider.of<PostProvider>(context, listen: false);

    return Scaffold(
      // backgroundColor: Colors.white, // Changed background to white
      appBar: AppBar(
        title: const Text(
          'Posts',
          style: TextStyle(
            color: Colors
                .white, // Changed title color to black for professionalism
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0, // Removed shadow for a cleaner look
        //  backgroundColor: Colors.white, // Matches the background color
        actions: [
          IconButton(
            onPressed: () async {
              final auth = FirebaseAuth.instance;
              await auth.signOut();
              Navigator.pushReplacementNamed(context, Routsname.login);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white, // Changed icon color to black
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: ref,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No posts available.'));
          } else {
            final documents = snapshot.data!.docs;

            return Padding(
              padding:
                  const EdgeInsets.all(8.0), // Added padding for better layout
              child: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  var id = snapshot.data!.docs[index].id;
                  var email = snapshot.data!.docs[index]['email'];
                  var password = snapshot.data!.docs[index]['password'];
                  var url = snapshot.data!.docs[index]['url'];

                  return Dismissible(
                      onDismissed: (direction) {
                        provider.delete(id);
                      },
                      background: Container(
                        color: Colors.red,
                        height: 50,
                        child: const Icon(Icons.delete),
                      ),
                      direction: DismissDirection.horizontal,
                      key: Key(id),
                      child: Card(
                        elevation: 2, // Added elevation for cleaner UI
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),

                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(url),
                          ),
                          title: Text(email ?? 'No email'),
                          subtitle: Text(password ?? 'No password'),
                          trailing: PopupMenuButton(
                            onSelected: (value) {
                              switch (value) {
                                case 'delete':
                                  provider.delete(id);
                                  break;
                                case 'update':
                                  postfuncation.updatepost(
                                      context, id, email, password);
                                  break;
                              }
                            },
                            icon: Icon(Icons.more_vert,
                                color: Theme.of(context).iconTheme.color),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, color: Colors.red),
                                    SizedBox(width: 8),
                                    Text('Delete'),
                                  ],
                                ),
                              ),
                              const PopupMenuItem(
                                value: 'update',
                                child: Row(
                                  children: [
                                    Icon(Icons.edit, color: Colors.blue),
                                    SizedBox(width: 8),
                                    Text('Update'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routsname.addpost);
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add), // Changed button color to black
      ),
    );
  }
}
