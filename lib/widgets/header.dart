import 'package:flutter/material.dart';

AppBar header(ctx, {bool isAppTitle=false, titletext, removeBackButton =false}) {
  return AppBar(
    automaticallyImplyLeading: removeBackButton? false: true,
    backgroundColor: Theme.of(ctx).accentColor,
    title: Text(isAppTitle?
      "Flutter Share": "Profile",
      style: TextStyle(
        fontFamily:isAppTitle? 'Signatra': "",
        fontSize: isAppTitle?45.0:null,
        color: Colors.white,
      ),
    ),
    centerTitle: true,
  );
}
