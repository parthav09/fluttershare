import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/models/idea_item.dart';
import 'package:fluttershare/pages/home.dart';
import 'package:fluttershare/widgets/activity_tile.dart';

class ActivityFeed extends StatefulWidget {
  @override
  _ActivityFeedState createState() => _ActivityFeedState();
  final String myUserId;
  ActivityFeed(this.myUserId);
}

class _ActivityFeedState extends State<ActivityFeed> {
  final firestore = Firestore.instance;
  String title;
  String sub;
  String desc;
  final String _currentUserId = currentUser?.id;

  initState() {
    super.initState();
    getActivity();
  }

  Future<List<IdeaItem>> getActivity() async {
    print(widget.myUserId);
    List<IdeaItem> feed = [];
    QuerySnapshot postcollection = await firestore
        .collection('posts')
        .document(
        widget.myUserId)
            .collection('userposts').orderBy('timestamp', descending: true)
        .getDocuments();
    print(postcollection.documents.length);
    postcollection.documents.forEach((element) {
      feed.add(IdeaItem.fromDocument(element.data));
    });
    return feed;
//    List<IdeaItem> feed = [];
//    QuerySnapshot postCollection = await firestore.collection('posts').getDocuments();
//    print(postCollection.documents.length);
//    await Future.forEach(postCollection.documents, (element) async{
//      print(element.documentId);
//      if(element.documentID != widget.myUserId) {
//       QuerySnapshot snap= await Firestore.instance.collection('posts').document(element.documentID).collection('userposts').getDocuments();
//       snap.documents.forEach((element) {
//         feed.add(IdeaItem.fromDocument(element.data));
//       });
//      }
//    });
//    print(feed);
//    return feed;
  }

  Widget buildUserIdea(String title, String sub, String desc) {
    return ActivityTile(
      title: title,
      sub: sub,
      desc: desc,
      userId: widget.myUserId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity Feed"),
      ),
      body: Container(
        child: FutureBuilder(
          future: getActivity(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => buildUserIdea(
                snapshot.data[index].mainIdea,
                snapshot.data[index].sub,
                snapshot.data[index].ans,
              ),
            );
          },
        ),
      ),
    );
  }
}

//class ActivityFeedItem extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Text('Activity Feed Item');
//  }
//}
