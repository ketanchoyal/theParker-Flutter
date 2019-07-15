import 'package:flutter/material.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:the_parker/UI/Resources/APIKeys.dart';
import 'package:the_parker/UI/Widgets/TopBar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.red,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: SearchMapPlaceWidget(
                apiKey: APIKeys.google_map_key,
                onSelected: (place) async {
                  print(await place.fullJSON.toString());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
