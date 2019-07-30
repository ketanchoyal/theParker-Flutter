import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_parker/UI/Resources/ConstantMethods.dart';
import 'MapPage.dart';

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
          MapPage(),
          CustomNavigationBar(
            onTap: (value) => print(value.toString()),
          ),
        ],
      ),
    );
  }
}

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key key, this.onTap}) : super(key: key);

  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 15,
      right: 15,
      child: Card(
        color: Colors.transparent,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: SizedBox(
          height: 80,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  height: 55,
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          padding: EdgeInsets.only(right: 35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                EvaIcons.menuArrow,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              ),
                              Text(
                                'More',
                                style: ktitleStyle.copyWith(
                                  fontSize: 13,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            ],
                          ),
                          onPressed: () {
                            onTap(0);
                          },
                        ),
                      ),
                      // Expanded(
                      //   child: FlatButton(
                      //     padding: EdgeInsets.only(top: 15),
                      //     child: Icon(EvaIcons.arrowheadDown),
                      //     onPressed: () {},
                      //   ),
                      // ),
                      Expanded(
                        child: FlatButton(
                          padding: EdgeInsets.only(left: 35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                EvaIcons.search,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              ),
                              Text(
                                'Search',
                                style: ktitleStyle.copyWith(
                                  fontSize: 13,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            ],
                          ),
                          onPressed: () {
                            onTap(2);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: FloatingActionButton(
                    heroTag: 'adaojd',
                    // shape: RoundedRectangleBorder(),
                    // highlightElevation: 0,
                    elevation: 0,
                    onPressed: () {
                      onTap(1);
                    },
                    child: Icon(Icons.view_column),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
