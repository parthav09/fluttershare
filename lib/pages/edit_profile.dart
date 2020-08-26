import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:fluttershare/pages/timeline.dart';
import '../models/user.dart';

class EditProfile extends StatefulWidget {
  final currentUserId;
  EditProfile(this.currentUserId);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isLoading= false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }
  getUser() async{
    setState(() {
      isLoading= true;
    });
    DocumentSnapshot doc= await fireStore.collection('users').document(widget.currentUserId).get();
    final currentUser = User.fromDocument(doc);
  }
  final _form= GlobalKey<FormState>();
  void saveCreds() async{
    _form.currentState.validate();
    _form.currentState.save();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile"),),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            CircleAvatar(radius: 45,backgroundImage: null,),
            SizedBox(height: 20,),
            Form(
              child: Column(
                children: <Widget>[
                  TextFormField(onSaved: null,
                  decoration: InputDecoration(labelText: "Display Name"),),
                  TextFormField(
                    onSaved: null,
                    decoration: InputDecoration(labelText: "Bio"),
                  ),
                  RaisedButton(child: Text("Update Profile"), onPressed: saveCreds,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
