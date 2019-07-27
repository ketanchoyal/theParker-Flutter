import 'package:flutter/material.dart';
import 'package:the_parker/UI/Resources/ConstantMethods.dart';
import 'package:the_parker/UI/Widgets/LiquidSwipe/liquid_swipe.dart';

import 'IntroPage.dart';
import 'Login/LoginPage.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        pages: pages(context),
        widget: Positioned(
            bottom: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width,
            // left: MediaQuery.of(context).size.width/2 - 40,
            child: Align(
              alignment: Alignment.center,
              child: Hero(
                tag: 'title',
                transitionOnUserGestures: true,
                child: MaterialButton(
                  height: 50,
                  minWidth: MediaQuery.of(context).size.width - 100,
                  elevation: 0,
                  onPressed: () {
                    kopenPage(context, LoginPage());
                  },
                  color: Colors.white,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }
}
