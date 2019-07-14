import 'package:flutter/material.dart';
import 'package:the_parker/UI/Widgets/LiquidSwipe/liquid_swipe.dart';

import 'IntroPage.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        pages: pages(context),
      ),
    );
  }
}
