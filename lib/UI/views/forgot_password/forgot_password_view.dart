import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:the_parker/ui/Resources/ConstantMethods.dart';
import 'package:the_parker/ui/Resources/Resources.dart';
import 'package:the_parker/ui/Widgets/TopBar.dart';
import './forgot_password_viewmodel.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: TopBar(
          child: kBackBtn,
          onPressed: () {
            kbackBtn(context);
          },
          title: Kstrings.forgot_password,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
              bottom: 25.0, left: 25.0, right: 25.0, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 5.0,
                  right: 5.0,
                ),
                child: Text(
                  Kstrings.enter_registered_email,
                  // textAlign: TextAlign.center,
                  style: ktitleStyle,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                obscureText: true,
                onChanged: (email) {},
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                decoration: kTextFieldDecoration.copyWith(
                  hintText: Kstrings.email_hint,
                  labelText: Kstrings.email,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    FloatingActionButton.extended(
                      heroTag: 'needHelp',
                      label: Text(
                        Kstrings.send_recovery_mail,
                        style: ktitleStyle,
                      ),
                      onPressed: () {
                        //Forget Password Logic
                        // kopenPage(context, ForgotPasswordPage());
                      },
                      // height: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => ForgotPasswordViewModel(),
    );
  }
}
