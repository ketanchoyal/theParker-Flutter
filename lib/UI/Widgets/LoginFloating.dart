import 'package:flutter/material.dart';

import 'LoginRoundedButton.dart';
import 'ReusableRoundedButton.dart';

class LoginFloatingButtons extends StatelessWidget {
  final Function onPressedLeft;
  final Function onPressedRight;
  final String label;
  final IconData icon;
  const LoginFloatingButtons({
    this.label,
    this.icon,
    this.onPressedLeft,
    this.onPressedRight,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 31),
              child: Hero(
                tag: 'mobile',
                transitionOnUserGestures: true,
                child: ReusableRoundedButton(
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                  // text: 'Mobile',
                  onPressed: onPressedLeft,
                  height: 50,
                  // backgroundColor: Colors.redAccent,
                ),
              ),
            ),
          ),
          LoginRoundedButton(
            label: label,
            onPressed: onPressedRight,
          ),
        ],
      ),
    );
  }
}
