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

  buildPostHeader() {
    return FutureBuilder(
      future: Firestore.instance.collection('users').document('104487127616899191424').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        User user = User.fromDocument(snapshot.data);
        return Padding(
          padding: EdgeInsets.only(top: 10, bottom: 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              border: Border.all(color: Colors.black45, width: 0.1),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).accentColor.withOpacity(0.4),
                  Theme.of(context).primaryColor.withOpacity(1),
                  // Colors.grey.withOpacity(0.4),
                  // Colors.black.withOpacity(0.2),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
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
                Text(
                  user.username,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
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
              ),
            ),
          ),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).accentColor.withOpacity(0.4),
                            Theme.of(context).primaryColor.withOpacity(1),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        // color: Color.fromRGBO(225, 225, 225, 0.6)
                      ),
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
                          border: Border.all(color: Colors.black45, width: 1),
                          color: Color.fromRGBO(214, 129, 64, 0.8),
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
                          border: Border.all(color: Colors.black45, width: 1),
                          color: Color.fromRGBO(75, 149, 164, 0.9),
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
                          border: Border.all(color: Colors.black45, width: 1),
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
