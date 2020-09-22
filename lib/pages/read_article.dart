import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttershare/widgets/header.dart';

class ReadArticle extends StatelessWidget {
  String title;
  String sub;
  String desc;

  ReadArticle({this.title, this.sub, this.desc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, removeBackButton: false, titletext: 'Article'),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 28,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Divider(),
            Text(
              sub,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24,
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              desc,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
