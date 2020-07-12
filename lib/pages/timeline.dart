import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';
import 'package:fluttershare/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final fireStore = Firestore.instance;

class TimeLine extends StatefulWidget {
  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  void initState() {
//    getUsers();
//    addUser();
//    deleteUser();
//    getUserById();
    super.initState();
  }

  getUsers() async {
    final snapshot = await fireStore.collection('users').getDocuments();
  }
  addUser() async{
    final  doc = await fireStore.collection("users").add({
      "username": "parthav09",
      "isAdmin": true,
      "ideasCount": 2,
    });
  }

  updateUser() async {
    final DocumentSnapshot doc = await fireStore
        .collection('users')
        .document("x2V4gDiVgE3tCYXUvmP4")
        .get();
    if (doc.exists) {
      doc.reference.updateData({
        'username': "parthav",
        "isAdmin": true,
        "ideasCount": 4,
      });
    }
  }

  deleteUser() async{
    final DocumentSnapshot doc = await fireStore.collection("users").document("x2V4gDiVgE3tCYXUvmP4").get();
    if(doc.exists){
      doc.reference.delete();
    }
  }

//  getUserById()async{
//    final String id = "x2V4gDiVgE3tCYXUvmP4";
//    final doc = await fireStore.collection('users').document().get();
//    print(doc.documentID);
//    print(doc.exists);
//  }
  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStore.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          final List<Text> usrchildren = snapshot.data.documents
              .map((docdata) => Text(docdata['username']))
              .toList();
          return Container(
            child: ListView(
              children: usrchildren,
            ),
          );
        },
      ),
    );
  }
}
