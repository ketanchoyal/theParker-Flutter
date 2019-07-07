import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

kbackBtn(BuildContext context) {
  Navigator.of(context).pop();
}

kopenPage(BuildContext context, Widget page) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => page,
    ),
  );
}

Widget kBackBtn = Icon(
  Icons.arrow_back_ios,
  // color: Colors.black54,
);

var kTextFieldDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  hintStyle: TextStyle(height: 1.5, fontWeight: FontWeight.w300),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
);

TextStyle ktitleStyle = TextStyle(fontWeight: FontWeight.w800);
TextStyle ksubtitleStyle = TextStyle(fontWeight: FontWeight.w600);

kopenPageBottom(BuildContext context, Widget page) {
  Navigator.of(context).push(
    CupertinoPageRoute<bool>(
      fullscreenDialog: true,
      builder: (BuildContext context) => page,
    ),
  );
}

SnackBar ksnackBar(BuildContext context, String message) {
  return SnackBar(
    content: Text(
      message,
      textAlign: TextAlign.center,
    ),
    backgroundColor: Theme.of(context).primaryColor,
  );
}

ShapeBorder kRoundedButtonShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(50)),
);

ShapeBorder kBackButtonShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(30),
  ),
);