import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Idea extends StatelessWidget {
  final subFocusNode = FocusNode();
  final articleFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        color: Colors.grey,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Text(
                    "Inspire",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Signatra'),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(20, 20, 80, 1),
                        Color.fromRGBO(80, 60, 120, 0.8),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(subFocusNode);
                  },
                ),
                TextFormField(
                  focusNode: subFocusNode,
                  decoration:
                      InputDecoration(labelText: 'sub title (3 max lines)'),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(articleFocusNode);
                  },
                ),
                TextFormField(
                  focusNode: articleFocusNode,
                  decoration: InputDecoration(
                      labelText: 'Enter your article (10 max lines)'),
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
