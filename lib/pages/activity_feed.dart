import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ActivityFeed extends StatefulWidget {
  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  final firestore= Firestore.instance;

//  Future<List<IdeaItem>> getActivity() async{
//    List<IdeaItem> feed = [];
//    QuerySnapshot postCollection = await Firestore.instance.collectio('posts').getDocuments();
//    postCollection.documents.forEach((element) {
//      if(element.documentID != currentUserId) {
//        //TODO:  Firestore.instance.collection('posts').document(element.documentID).collection('userposts').getDocuments();
//      }
//    })
//  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(


      ),
    );
  }
}

class ActivityFeedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Activity Feed Item');
  }
}





