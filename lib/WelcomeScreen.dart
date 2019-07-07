import 'package:flutter/material.dart';
import 'package:the_parker/Resources.dart';
import 'Widgets/IntroView/Models/page_view_model.dart';
import 'Widgets/IntroView/intro_views_flutter.dart';

class WelcomeScreen extends StatelessWidget {
  List<PageViewModel> page(BuildContext context) {
    return [
      PageViewModel(
        pageColor: Color(0xff1976D2),
        title: Text(
          Kstrings.screen1_1,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
          ),
        ),
        body: Text(
          Kstrings.screen1_2,
          style: TextStyle(
              color: Colors.white70,
              fontSize: 14.0,
              fontWeight: FontWeight.w400),
        ),
        mainImage: Image.asset(
          Kassets.way,
          width: MediaQuery.of(context).size.width - 60,
          alignment: Alignment.center,
        ),
        textStyle: TextStyle(color: Colors.white),
      ),
      PageViewModel(
        pageColor: Color(0xff40C4FF),
        title: Text(
          Kstrings.screen2_1,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
          ),
        ),
        body: Text(
          Kstrings.screen2_2,
          style: TextStyle(
              color: Colors.white70,
              fontSize: 14.0,
              fontWeight: FontWeight.w400),
        ),
        mainImage: Image.asset(
          Kassets.parking,
          width: MediaQuery.of(context).size.width - 60,
          alignment: Alignment.center,
        ),
        textStyle: TextStyle(color: Colors.white),
      ),
      PageViewModel(
        pageColor: Color(0xffE57373),
        title: Text(
          Kstrings.screen3_1,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
        ),
        body: Text(
          Kstrings.screen3_2,
          style: TextStyle(
              color: Colors.white70,
              fontSize: 14.0,
              fontWeight: FontWeight.w400),
        ),
        mainImage: Image.asset(
          Kassets.userFriendly,
          width: MediaQuery.of(context).size.width - 60,
          alignment: Alignment.center,
        ),
        textStyle: TextStyle(color: Colors.white),
      ),
      PageViewModel(
        pageColor: Color(0xffC51162),
        title: Text(
          Kstrings.screen4_1,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
        ),
        body: Text(
          Kstrings.screen4_2,
          style: TextStyle(
              color: Colors.white70,
              fontSize: 14.0,
              fontWeight: FontWeight.w400),
        ),
        mainImage: Image.asset(
          Kassets.shakeHands,
          width: MediaQuery.of(context).size.width - 60,
          alignment: Alignment.center,
        ),
        textStyle: TextStyle(color: Colors.white),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          IntroViewsFlutter(
            page(context),
            onTapDoneButton: null,
            showNextButton: true,
            showBackButton: true,
            skipText: Text(
              '↠',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            backText: Text(
              '←',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            nextText: Text(
              '→',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            showSkipButton: true,
            doneText: Container(),
            pageButtonsColor: Color.fromARGB(100, 254, 198, 27),
            pageButtonTextStyles: new TextStyle(
              color: Colors.indigo,
              fontSize: 16.0,
            ),
          ),
          Positioned(
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
                  elevation: 10,
                  onPressed: () {},
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
        ],
      ),
    );
  }
}
