import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class ReadArticle extends StatelessWidget {
  String title;
  String sub;
  String desc;
  ReadArticle({this.title, this.sub, this.desc});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(title,textAlign: TextAlign.left, style: TextStyle(
                fontSize: 28,
                fontStyle: FontStyle.italic,
              ),),
              Divider(),
              Text(sub, textAlign: TextAlign.left, style: TextStyle(
                fontSize: 24,
                fontStyle: FontStyle.normal,
              ),),
              SizedBox(height: 12,),
              Text(desc, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20,),),
            ],
          ),
        ),
      ),
    );
  }
}
