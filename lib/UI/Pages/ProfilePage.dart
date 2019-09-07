import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:the_parker/UI/Resources/ConstantMethods.dart';
import 'package:the_parker/UI/Resources/Resources.dart';

class ProfilePage extends StatelessWidget {
  final double currentSearchPercent;

  const ProfilePage({Key key, this.currentSearchPercent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height =
        (MediaQuery.of(context).size.height) * 0.75 * currentSearchPercent - 5;
    return currentSearchPercent != 0
        ? Positioned(
            top: 5 * currentSearchPercent,
            left: 5,
            right: 5,
            child: Opacity(
              opacity: currentSearchPercent,
              child: Container(
                height: height > 0 ? height : 0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      35 * currentSearchPercent,
                    ),
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Stack(
                    children: <Widget>[
                      _buildProfileFields(height),
                    ],
                  ),
                ),
              ),
            ),
          )
        : const Padding(
            padding: const EdgeInsets.all(0),
          );
  }

  Widget _buildProfileFields(double height) {
    return Align(
      alignment: Alignment.topCenter,
      child: Card(
        elevation: 2,
        child: ClipPath(
          child: Container(
            height: height * 0.13,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.green,
                  width: 5,
                ),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    height: height * 0.13,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            // color: Colors.red,
                            child: Image.asset(
                              Kassets.userFriendly,
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Positioned(
                          right: -3.5,
                          left: -3.5,
                          bottom: -3.5,
                          child: Container(
                            height: 35 * currentSearchPercent,
                            // width: 45,
                            child: Card(
                              elevation: 0,
                              color: Colors.black12,
                              child: MaterialButton(
                                color: Colors.black12,
                                child: Icon(
                                  EvaIcons.camera,
                                  color: Colors.white70,
                                  // size: 24,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    height: height * 0.13 * 1,
                    // color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Ketan Choyal',
                          style: ktitleStyle.copyWith(
                            fontSize: 20 * currentSearchPercent,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              EvaIcons.phoneOutline,
                              size: 22 * currentSearchPercent,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '+91 8460805353',
                              style: ktitleStyle.copyWith(
                                fontSize: 14 * currentSearchPercent,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              EvaIcons.emailOutline,
                              size: 22 * currentSearchPercent,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Text(
                                'ketanchoyal@gmail.com',
                                style: ktitleStyle.copyWith(
                                  fontSize: 14 * currentSearchPercent,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
      ),
    );
  }
}
