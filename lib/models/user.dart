import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String photoUrl;
  final String displayname;
  final String bio;

  User(
      {this.id,
      this.username,
      this.displayname,
      this.email,
      this.photoUrl,
      this.bio});

  factory User.fromDocument(DocumentSnapshot doc){
    return User(
      id: doc['id'],
      email: doc['email'],
      bio: doc['bio'],
      displayname: doc['displayname'],
      photoUrl: doc['photoUrl'],
      username: doc['username']
    );
  }
}
