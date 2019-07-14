import 'package:flutter/material.dart';
import 'package:the_parker/UI/Resources/ConstantMethods.dart';

class ReusableRoundedButton extends StatelessWidget {
  final Function onPressed;
  final double height;
  final Color backgroundColor;
  final Widget child;
  final double elevation;

  const ReusableRoundedButton(
      {@required this.onPressed,
      this.height,
      this.elevation,
      this.backgroundColor,
      @required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor ?? Theme.of(context).primaryColor,
      elevation: elevation ?? 10,
      shape: kRoundedButtonShape,
      child: MaterialButton(
        height: height,
        // minWidth: 300,
        // elevation: 10,
        shape: kRoundedButtonShape,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
