import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/models/idea_item.dart';
import 'package:fluttershare/models/user.dart';
import 'package:fluttershare/pages/edit_profile.dart';
import 'package:fluttershare/pages/home.dart';
import 'package:fluttershare/widgets/idea_tile.dart';
import 'package:fluttershare/widgets/progress.dart';

class Profile extends StatefulWidget {
  final String profileId;

  Profile({this.profileId});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String currentUserId = currentUser?.id;
  bool isLoading = false;
  int postCount = 0;
  String title;
  String sub;
  String desc;

  Column buildCountColumn(String label, int count) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 22,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  void initState() {
    super.initState();
    getProfilePosts();
  }

  Future<List<IdeaItem>> getProfilePosts() async {
    List<IdeaItem> ideaitems = [];
    QuerySnapshot snapshot = await firestore
        .collection('posts')
        .document(currentUserId)
        .collection('userposts').orderBy('timestamp', descending: true)
        .getDocuments();
    snapshot.documents.forEach((element) {
      ideaitems.add(IdeaItem.fromDocument(element.data));
    });
    setState(() {
      postCount=snapshot.documents.length;
    });
    return ideaitems;
  }

  buildProfileHeader() {
    return FutureBuilder(
      future: Firestore.instance
          .collection('users')
          .document(widget.profileId)
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        User user = User.fromDocument(snapshot.data);
        return Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(user.photoUrl),
              ),
              Text(
                user.username,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              Text(
                user.displayname,
                textAlign: TextAlign.start,
              ),
              Text(
                user.bio,
                textAlign: TextAlign.start,
              ),
              Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        buildCountColumn("article", postCount),
                        buildCountColumn("readers", 1),
                        buildCountColumn("following", 2),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildUserIdea(String title, String sub, String desc) {
    return IdeaTile(
      title: title,
      sub: sub,
      desc: desc,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              bool isProfileOwner = currentUserId == widget.profileId;
              if (isProfileOwner) {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) =>
                        EditProfile(currentUserId, currentUser),
                  ),
                );
              }
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          buildProfileHeader(),
          Expanded(
            child: FutureBuilder(
              future: getProfilePosts(),
              builder: (context, snapshot) {
                if (isLoading) {
                  return CircularProgressIndicator();
                }
                return ListView.builder(
                  itemBuilder: (context, index) =>
                      buildUserIdea(snapshot.data[index].mainIdea, snapshot.data[index].sub, snapshot.data[index].ans),
                  itemCount: snapshot.data.length,
                );
//                buildUserIdea(snapshot.data['title'], "subidea", "desc");
              },
            ),
          )
        ],
      ),
    );
  }
}
