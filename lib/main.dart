import 'package:flutter/material.dart';
import 'package:the_parker/Resources.dart';
import 'package:the_parker/WelcomeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'theParker',
      theme: ThemeData(
        fontFamily: 'K2D',
        primaryColor: Kcolors.primary,
        primaryColorDark: Kcolors.primaryDark,
        primarySwatch: Colors.red,
        accentColor: Kcolors.accent
      ),
      home: WelcomeScreen(),
    );
  }
}
