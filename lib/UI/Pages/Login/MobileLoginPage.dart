import 'package:flutter/material.dart';
import 'package:the_parker/UI/Resources/ConstantMethods.dart';
import 'package:the_parker/UI/Resources/Resources.dart';
import 'package:the_parker/UI/Widgets/LoginFloating.dart';
import 'package:the_parker/UI/Widgets/LoginRoundedButton.dart';
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
      floatingActionButton: LoginFloatingButtons(
        icon: Icons.expand_more,
        label: 'Login',
        onPressedLeft: () {
          Navigator.pop(context);
        },
        onPressedRight: () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Hero(
              tag: 'imageee',
              child: Image.asset(
                Kassets.group,
                // width: MediaQuery.of(context).size.width - 50,
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
                    Hero(
                      tag: 'otpForget',
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ReusableRoundedButton(
                            child: Text(
                              Kstrings.send_otp,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            // text: "Forgot Pass?",
                            onPressed: () {
                              setState(() {
                                isEnabled = !isEnabled;
                              });
                            },
                            height: 40,
                          ),
                        ),
                      ),
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
