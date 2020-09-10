import 'package:fluttershare/pages/home.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttershare/widgets/progress.dart';
import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttershare/models/idea_item.dart';

class Idea extends StatefulWidget {
  final User currentuser;

  Idea({this.currentuser});

  @override
  _IdeaState createState() => _IdeaState();
}

class _IdeaState extends State<Idea> {
  final _firestore = Firestore.instance;
  String title;
  String subtitle;
  String desc;
  bool _isuploading = false;
  String postId = Uuid().v4();
  final subFocusNode = FocusNode();
  TextEditingController locationController = TextEditingController();

  final articleFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();

  getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    String completeAddress =
        '${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality} ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';
    print(completeAddress);
    String formattedAddress = "${placemark.locality}, ${placemark.country}";
    locationController.text = formattedAddress;
  }

  createIdeaInFireStore(IdeaItem ideaItem) {
    _firestore
        .collection('posts')
        .document(widget.currentuser.id)
        .collection("userposts")
        .document(postId)
        .setData({
      "postId": ideaItem.postId,
      "userId": ideaItem.userId,
      "title": ideaItem.mainIdea,
      "subIdea": ideaItem.sub,
      "body": ideaItem.ans,
      "location": locationController.text,
      "timestamp": ideaItem.timeStamp,
      "likes": {},
    });
    setState(() {
      _form.currentState.reset();
      _isuploading = false;
      postId = Uuid().v4();
    });
  }

  void handleSubmission() {
    setState(() {
      _isuploading = true;
    });
    bool _isValid = _form.currentState.validate();
    if (!_isValid) {
      return;
    }
    _form.currentState.save();
    IdeaItem ideaitem = IdeaItem(
        mainIdea: title,
        sub: subtitle,
        ans: desc,
        likes: {},
        postId: postId,
        timeStamp: timestamp,
        userId: widget.currentuser.id);
    print(title + subtitle + desc);
    createIdeaInFireStore(ideaitem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(231, 202, 182, 1),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.pin_drop),
            onPressed: getUserLocation,
          ),
        ],
        backgroundColor: Color.fromRGBO(231, 202, 182, 1),
        title: Text("Idea Screen"),
        leading: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => setState(() {
                  _form.currentState.reset();
                })),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          elevation: 0,
          color: Color.fromRGBO(231, 202, 182, 1),
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                _isuploading ? linearProgress() : Text(""),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty && value.length < 8) {
                        return "Minimum charater for this field is 10";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(subFocusNode);
                    },
                    onSaved: (value) {
                      title = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty && value.length < 1) {
                        return "Minimum charater for this field is 10";
                      }
                      return null;
                    },
                    focusNode: subFocusNode,
                    decoration: InputDecoration(
                        labelText: 'sub title (3 max lines)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(articleFocusNode);
                    },
                    onSaved: (value) {
                      subtitle = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty && value.length < 5) {
                        return "Minimum charater for this field is 10";
                      }
                      return null;
                    },
                    focusNode: articleFocusNode,
                    decoration: InputDecoration(
                        labelText: 'Enter your article (10 max lines)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    onSaved: (value) {
                      desc = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: InkWell(
                    onTap: _isuploading ? null : () => handleSubmission(),
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
                        "Post",
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
