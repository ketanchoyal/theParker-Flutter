import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final double currentProfilePercent;

  final Function(bool) animateProfile;

  final bool isProfileOpen;

  final Function(DragUpdateDetails) onVerticalDragUpdate;

  final Function() onPanDown;

  const ProfileWidget(
      {Key key,
      this.currentProfilePercent,
      this.animateProfile,
      this.isProfileOpen,
      this.onVerticalDragUpdate,
      this.onPanDown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 25,
      top: (MediaQuery.of(context).size.height) * 0.75 * currentProfilePercent - 0.5,
      child: GestureDetector(
        onTap: () {
          animateProfile(!isProfileOpen);
        },
        onPanDown: (_) => onPanDown,
        onVerticalDragUpdate: onVerticalDragUpdate,
        onVerticalDragEnd: (_) {
          _dispatchProfileOffset();
        },
        child: Container(
          height: 75 - 25 * currentProfilePercent,
          width: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CircleAvatar(
                  child: Icon(
                    EvaIcons.person,
                    semanticLabel: 'Profile',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// dispatch Search state
  ///
  /// handle it by [isProfileOpen] and [currentProfilePercent]
  void _dispatchProfileOffset() {
    if (!isProfileOpen) {
      if (currentProfilePercent < 0.3) {
        animateProfile(false);
      } else {
        animateProfile(true);
      }
    } else {
      if (currentProfilePercent > 0.6) {
        animateProfile(true);
      } else {
        animateProfile(false);
      }
    }
  }
}
