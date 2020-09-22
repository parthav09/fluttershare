import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/models/user.dart';
import 'package:fluttershare/pages/read_article.dart';

class ActivityTile extends StatelessWidget {
  final String title;
  final String sub;
  final String desc;
  final String userId;

  ActivityTile({this.title, this.sub, this.desc, this.userId});

  buildPostHeader(){
    return FutureBuilder(
      future: Firestore.instance
      .collection('users')
      .document(userId)
      .get(),
      builder: (context, snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        User user = User.fromDocument(snapshot.data);
        return Padding(
          padding: EdgeInsets.only(top: 10, bottom: 2),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(user.photoUrl),
                  ),
                ),
                Text(user.username, style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
          ),
        );
      },
      );
}

  @override
  Widget build(BuildContext context) {
    print(title);
    print("Here");
    return Column(
      children: <Widget>[
        buildPostHeader(),
        GestureDetector(
          onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => ReadArticle(
                    desc: desc,
                    title: title,
                    sub: sub,
                  ))),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(43, 51, 108, 0.6)),
                      padding: EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      height: 130,
//          child: Text("Her"),
                    ),
                  ),
                  Positioned(
                    left: 5,
                    top: 5,
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(225, 225, 225, 0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(title),
                    ),
                  ),
                  Positioned(
                    left: 5,
                    bottom: 5,
                    height: 50,
                    width: (MediaQuery.of(context).size.width - 5) * 0.4,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 60, 120, 0.4),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(sub),
                    ),
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    height: 115,
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(225, 225, 225, 0.4),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(desc),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
