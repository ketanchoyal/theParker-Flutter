import 'package:the_parker/UI/Pages/Home.dart';
import 'package:the_parker/UI/Pages/Login/MobileLoginPage.dart';
import 'package:the_parker/UI/Resources/ConstantMethods.dart';
import 'package:the_parker/UI/Resources/Resources.dart';
import 'package:the_parker/UI/Widgets/LoginFloating.dart';
import 'package:the_parker/UI/Widgets/ReusableRoundedButton.dart';
import 'package:the_parker/UI/Widgets/TopBar.dart';
import 'ForgotPassword.dart';
import 'package:flutter/material.dart';

enum ButtonType { LOGIN, REGISTER }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // String idHint = string.student_id;
  bool isRegistered = false;
  String notYetRegisteringText = Kstrings.not_registered;
  ButtonType buttonType = ButtonType.LOGIN;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: TopBar(
        title: Kstrings.login,
        child: kBackBtn,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      floatingActionButton: LoginFloatingButtons(
        label:
            buttonType == ButtonType.LOGIN ? Kstrings.login : Kstrings.register,
        onPressedLeft: () {
          kopenPageBottom(context, MobileLoginPage());
        },
        icon: Icons.phone,
        onPressedRight: () {
          kopenPage(context, HomePage());
        },
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
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
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          onChanged: (email) {},
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: Kstrings.email_hint,
                            labelText: Kstrings.email,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          obscureText: true,
                          onChanged: (password) {},
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: Kstrings.password_hint,
                            labelText: Kstrings.password,
                          ),
                        ),
                        isRegistered
                            ? SizedBox(
                                height: 15,
                              )
                            : Container(),
                        isRegistered
                            ? TextField(
                                obscureText: true,
                                onChanged: (password) {},
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                                decoration: kTextFieldDecoration.copyWith(
                                  hintText: Kstrings.password_hint,
                                  labelText: Kstrings.confirm_password,
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 15,
                        ),
                        Hero(
                          tag: 'otpForget',
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                ReusableRoundedButton(
                                  child: Text(
                                    notYetRegisteringText,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (buttonType == ButtonType.LOGIN) {
                                        buttonType = ButtonType.REGISTER;
                                      } else {
                                        buttonType = ButtonType.LOGIN;
                                      }
                                      isRegistered = !isRegistered;
                                      notYetRegisteringText = isRegistered
                                          ? Kstrings.registered
                                          : Kstrings.not_registered;
                                    });
                                  },
                                  height: 40,
                                ),
                                ReusableRoundedButton(
                                  child: Text(
                                    Kstrings.need_help,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  onPressed: () {
                                    //Forget Password Logic
                                    kopenPage(context, ForgotPasswordPage());
                                  },
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
