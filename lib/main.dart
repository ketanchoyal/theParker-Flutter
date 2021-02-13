import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UI/Pages/WelcomePage/WelcomeScreen.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}
// TODO: https://www.developerlibs.com/2018/08/flutter-how-can-draw-route-on-google.html?m=1 (Link for Distance and Direction)

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'theParker',
      theme: darkMode
          ? ThemeData(
              fontFamily: 'K2D',
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              }),
              // primaryColor: Kcolors.primary,
              // primaryColorDark: Kcolors.primaryDark,
              // primarySwatch: Colors.deepOrange,
              primaryColor: Colors.black,
              brightness: Brightness.dark,
              accentColor: Colors.black,
              // canvasColor: Colors.white12,
            )
          : ThemeData(
              fontFamily: 'K2D',
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              }),
              // primaryColor: Kcolors.primary,
              // primaryColorDark: Kcolors.primaryDark,
              // primarySwatch: Colors.deepOrange,
              primaryColor: Colors.white,
              brightness: Brightness.light,
              accentColor: Colors.white,
            ),
      // darkTheme: ThemeData(
      //   fontFamily: 'K2D',
      //   pageTransitionsTheme: PageTransitionsTheme(builders: {
      //     TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      //     TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      //   }),
      //   primaryColor: Kcolors.primary,
      //   // primaryColorDark: Kcolors.primaryDark,
      //   // primarySwatch: Colors.deepOrange,
      //   brightness: Brightness.dark,
      //   accentColor: Colors.black,
      //   canvasColor: Colors.black,
      // ),
      home: WelcomeScreen(),
    );
  }
}
