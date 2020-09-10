import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  final String idea;
  final String subIdea;
  final String article;
  Post({this.idea, this.subIdea, this.article});

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              child: Text(
                "Here is my Idea",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
              ),
            ),
            Divider(),
            Container(child: Text("Here is my sub idea"),),
            Text("Paragrapgh")
          ],
        ),
      ),
    );
  }
}
