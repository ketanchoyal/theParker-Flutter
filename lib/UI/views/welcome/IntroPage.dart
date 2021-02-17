import 'package:flutter/material.dart';
import 'package:the_parker/ui/resources/resources.dart';

List<Container> pages(BuildContext context) {
  return [
    intro(context, Kstrings.screen1_1, Kstrings.screen1_2, Kassets.way,
        Color(0xffFFDA56)),
    intro(context, Kstrings.screen2_1, Kstrings.screen2_1, Kassets.parking,
        Color(0xff2CE7E7)),
    intro(context, Kstrings.screen3_1, Kstrings.screen3_2, Kassets.userFriendly,
        Color(0xff3ABA68)),
    intro(context, Kstrings.screen4_1, Kstrings.screen4_2, Kassets.shakeHands,
        Color(0xffED5575)),
  ];
}

Container intro(BuildContext context, String heading, String subTitle,
    String imageAsset, Color color) {
  return Container(
    child: Scaffold(
      backgroundColor: color,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // SizedBox(height: 10,),
            Container(
              padding:
                  EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 30),
              child: Center(
                child: Text(
                  heading,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Image.asset(
              imageAsset,
              width: MediaQuery.of(context).size.width - 100,
              alignment: Alignment.center,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding:
                  EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 10),
              child: Text(
                subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
