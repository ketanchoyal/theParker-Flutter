import 'package:flutter/material.dart';
import 'package:the_parker/UI/Widgets/FloatingAppbar.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.red,
          ),
          FloatingAppbar(
            fontSize: 20,
            title: 'Address',
          ),
        ],
      ),
    );
  }
}
