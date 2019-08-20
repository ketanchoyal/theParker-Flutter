import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final double currentSearchPercent;

  const ProfilePage({Key key, this.currentSearchPercent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return currentSearchPercent != 0
        ? Positioned(
            top: 5 * currentSearchPercent,
            left: 5,
            right: 5,
            child: Opacity(
              opacity: currentSearchPercent,
              child: Container(
                height: (MediaQuery.of(context).size.height) *
                        0.75 *
                        currentSearchPercent -
                    5,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      35 * currentSearchPercent,
                    ),
                  ),
                ),
              ),
            ),
          )
        : const Padding(
            padding: const EdgeInsets.all(0),
          );
  }
}
