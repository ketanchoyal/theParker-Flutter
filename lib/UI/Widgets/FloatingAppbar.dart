import 'package:flutter/material.dart';
import 'package:the_parker/UI/Resources/ConstantMethods.dart';

class FloatingAppbar extends StatelessWidget {
  FloatingAppbar({
    this.title,
    this.fontSize = 16,
  });

  final String title;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 5,
      right: 5,
      child: SafeArea(
        child: Row(
          children: <Widget>[
            Hero(
              tag: 'backkk',
              transitionOnUserGestures: true,
              child: Card(
                child: Container(
                  height: 50,
                  width: 50,
                  child: RawMaterialButton(
                    onPressed: () {
                      kbackBtn(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Hero(
                tag: 'titleee',
                // transitionOnUserGestures: true,
                child: Card(
                  child: Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: ksubtitleStyle.copyWith(
                          fontSize: fontSize,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
