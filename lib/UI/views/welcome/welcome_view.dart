import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:the_parker/ui/Resources/ConstantMethods.dart';
import 'package:the_parker/ui/Widgets/LiquidSwipe/liquid_swipe.dart';
import 'package:the_parker/ui/views/login/login_view.dart';
import './welcome_viewmodel.dart';
import 'IntroPage.dart';

class WelcomeView extends StatefulWidget {
  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WelcomeViewModel>.reactive(
      viewModelBuilder: () => WelcomeViewModel(),
      builder: (context, model, child) => Scaffold(
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
                    kopenPage(context, LoginView());
                  },
                  color: Colors.white,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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
