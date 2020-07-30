import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Idea extends StatefulWidget {
  @override
  _IdeaState createState() => _IdeaState();
}

class _IdeaState extends State<Idea> {
  String title;
  String subtitle;
  String desc;
  final subFocusNode = FocusNode();

  final articleFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();

  void handlesubmission() {
    _form.currentState.validate();
    _form.currentState.save();
    print(title+subtitle+desc);
    setState(() {
      _form.currentState.reset();
    });
    print("It has been submitted");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _form,
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty && value.length < 8) {
                        return "Minimum charater for this field is 10";
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Title', border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Colors.grey))),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(subFocusNode);
                    },
                    onSaved: (value){
                      title=value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty && value.length < 1) {
                        return "Minimum charater for this field is 10";
                      }
                      return null;
                    },
                    focusNode: subFocusNode,
                    decoration:
                        InputDecoration(labelText: 'sub title (3 max lines)', border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Colors.grey))),
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(articleFocusNode);
                    },
                    onSaved: (value){
                      subtitle= value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty && value.length < 5) {
                        return "Minimum charater for this field is 10";
                      }
                      return null;
                    },
                    focusNode: articleFocusNode,
                    decoration: InputDecoration(
                        labelText: 'Enter your article (10 max lines)', border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(
                      color: Colors.grey
                    ))),
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    onSaved: (value){
                      desc=value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: InkWell(
                    onTap: handlesubmission,
                    splashColor: Colors.purple,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Text(
                        "Submit",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
