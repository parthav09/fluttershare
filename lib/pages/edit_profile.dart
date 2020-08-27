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
  String updateName;
  String updatedBio;
  bool _isUploading =false;
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
    setState(() {
      _isUploading= true;
    });
    bool _isValid = _form.currentState.validate();
    if(!_isValid){
      return;
    }
    _form.currentState.save();
    await fireStore.collection('users').document(widget.currentUserId).updateData({
      'username': updateName,
      'bio': updatedBio,
    });
    print(updateName);
    print(updatedBio);
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
              key: _form,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onSaved: (value){
                    updateName=value;
                  },
                    validator: (value){
                      if(value.trim().length<3 || value.isEmpty){
                        return "Please enter a valid username or length should be more than 3 characters";
                      }
                      return null;
                    },
                  decoration: InputDecoration(labelText: "Display Name"),),
                  TextFormField(
                    validator: (value){
                      if(value.trim().length<3 || value.isEmpty){
                        return "Please enter a valid username or length should be more than 3 characters";
                      }
                      return null;
                    },
                    onSaved: (value){
                      updatedBio=value;
                    },
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
