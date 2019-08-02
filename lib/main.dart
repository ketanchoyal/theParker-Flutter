import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_parker/UI/Resources/Resources.dart';
import 'UI/Pages/WelcomePage/WelcomeScreen.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

// TODO: https://www.developerlibs.com/2018/08/flutter-how-can-draw-route-on-google.html?m=1 (Link for Distance and Direction)

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
          // brightness: Brightness.dark,
          accentColor: Kcolors.accent),
      home: WelcomeScreen(),
    );
  }
}
