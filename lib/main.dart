import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_parker/UI/Resources/Resources.dart';
import 'package:the_parker/UI/Pages/WelcomeScreen.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'theParker',
      theme: ThemeData(
          fontFamily: 'K2D',
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }),
          primaryColor: Kcolors.primary,
          primaryColorDark: Kcolors.primaryDark,
          primarySwatch: Colors.red,
          accentColor: Kcolors.accent),
      home: WelcomeScreen(),
    );
  }
}
