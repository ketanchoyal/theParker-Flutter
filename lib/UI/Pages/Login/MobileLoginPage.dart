import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:the_parker/UI/Resources/ConstantMethods.dart';
import 'package:the_parker/UI/Resources/Resources.dart';
import 'package:the_parker/UI/Widgets/ReusableRoundedButton.dart';
import 'package:the_parker/UI/Widgets/TopBar.dart';

class MobileLoginPage extends StatefulWidget {
  static String loginTypeSelected = 'S';
  @override
  _MobileLoginPageState createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends State<MobileLoginPage> {
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: TopBar(
        title: Kstrings.mobile,
        child: kBackBtn,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 31),
            child: FloatingActionButton.extended(
                heroTag: 'abc',
                label: Container(),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Icon(EvaIcons.emailOutline),
                )),
          ),
          FloatingActionButton.extended(
              label: Text(
                'Login',
                style: ktitleStyle,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(EvaIcons.logIn)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Hero(
              tag: 'imageee',
              child: Image.asset(
                Kassets.group,
                width: MediaQuery.of(context).size.width - 50,
                alignment: Alignment.center,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      enabled: isEnabled,
                      onChanged: (email) {},
                      keyboardType: TextInputType.number,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: Kstrings.mobile_hint,
                        labelText: Kstrings.mobile_no,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      enabled: !isEnabled,
                      onChanged: (password) {},
                      keyboardType: TextInputType.number,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: Kstrings.otp_hint,
                        labelText: Kstrings.otp,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // Hero(
                    //   tag: 'otpForget',
                    //   child: 
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FloatingActionButton.extended(
                            heroTag: 'needHelp',
                            label: Text(
                              Kstrings.send_otp,
                              style: ktitleStyle,
                            ),
                            // text: "Forgot Pass?",
                            onPressed: () {
                              setState(() {
                                isEnabled = !isEnabled;
                              });
                            },
                            // height: 40,
                          ),
                        ),
                      ),
                    // ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
