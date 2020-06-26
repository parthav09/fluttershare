import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String username;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  void submit() {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();
      SnackBar snackbar = SnackBar(
        content: Text("Welcome $username!"),
      );
      _scaffoldKey.currentState.showSnackBar(snackbar);
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context, username);
      });
    }
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: _scaffoldKey,
      appBar:
          header(context, isAppTitle: false, titletext: "Set Up your profile", removeBackButton: true),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      "Create a username",
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Form(
                    autovalidate: true,
                    key: _formKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value.trim().length < 3 || value.isEmpty) {
                          return "Username is too short";
                        } else if (value.trim().length > 12) {
                          return "USername too long";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Username",
                      ),
                      onSaved: (value) {
                        username = value;
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: 60,
                    width: 350,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onTap: submit,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
