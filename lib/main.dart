// Flutter imports
import 'package:flutter/material.dart';
import 'package:fluttershare/pages/edit_profile.dart';

//Project import
import './pages/home.dart';

//Dart Imports

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.teal,
      ),
      title: 'FlutterShare',
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: {
//        EditProfile.routeName : (context)=> EditProfile(),
      },
    );
  }
}
