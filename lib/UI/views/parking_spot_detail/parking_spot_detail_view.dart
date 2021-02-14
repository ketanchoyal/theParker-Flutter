import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import './parking_spot_detail_viewmodel.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_parker/UI/Resources/ConstantMethods.dart';
import 'package:the_parker/UI/Resources/Resources.dart';
import 'package:the_parker/UI/Widgets/FloatingAppbar.dart';

class ParkingSpotDetailView extends StatefulWidget {
  ParkingSpotDetailView({Key key}) : super(key: key);

  @override
  _ParkingSpotDetailViewState createState() => _ParkingSpotDetailViewState();
}

class _ParkingSpotDetailViewState extends State<ParkingSpotDetailView> {
  int currentSelectedSegment = 1;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ParkingSpotDetailViewModel>.reactive(
        viewModelBuilder: () => ParkingSpotDetailViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton.extended(
              icon: Icon(
                EvaIcons.arrowForward,
              ),
              label: Text(
                'Next',
                style: ksubtitleStyle,
              ),
              onPressed: () {},
            ),
            body: Stack(
              children: <Widget>[
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.12,
                  left: 15,
                  right: 15,
                  bottom: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Text(
                          "Choose the type of your Parking Spot",
                          style: ksubtitleStyle.copyWith(fontSize: 18),
                        ),
                      ),
                      CupertinoSlidingSegmentedControl<int>(
                        children: <int, Widget>{
                          0: Text(
                            'Car Port',
                            style: ktitleStyle,
                          ),
                          1: Text(
                            'Driveway',
                            style: ktitleStyle,
                          ),
                          2: Text(
                            'Garage',
                            style: ktitleStyle,
                          ),
                          3: Text(
                            'Other',
                            style: ktitleStyle,
                          ),
                        },
                        onValueChanged: (newValue) {
                          setState(() {
                            currentSelectedSegment = newValue;
                          });
                        },
                        groupValue: currentSelectedSegment,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        child: Text(
                          "How many parking spots do you want to rent?",
                          style: ksubtitleStyle.copyWith(fontSize: 18),
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        onChanged: (email) {},
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: "No of parking spots",
                          labelText: "No of parking spots",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        child: Text(
                          "Additional Features:",
                          style: ksubtitleStyle.copyWith(fontSize: 18),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          // Icon(Icons.)
                        ],
                      )
                    ],
                  ),
                ),
                FloatingAppbar(
                  fontSize: 20,
                  title: 'Parking Details',
                ),
              ],
            ),
          );
        });
  }
}
