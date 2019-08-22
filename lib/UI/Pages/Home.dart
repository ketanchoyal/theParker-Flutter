import 'dart:math';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:the_parker/UI/Pages/ProfilePage.dart';
import 'package:the_parker/UI/Resources/APIKeys.dart';
import 'package:the_parker/UI/Widgets/AnimatedBottomNavigation.dart';
import 'package:the_parker/UI/Widgets/PlacePicker/place_picker.dart';
import 'package:the_parker/UI/Widgets/ProfileWidget.dart';
import 'MapPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool isBottomBarOpen = false;
  bool closeCards = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  AnimationController animationControllerProfile;
  var offsetProfile = 0.0;
  // get currentProfilePercent => max(0.0, min(1.0, offsetProfile / (347 - 68.0)));
  get currentProfilePercent => max(
      0.0,
      min(1.0,
          offsetProfile / (MediaQuery.of(context).size.height * 0.75 - 90.0)));

  double profilePercentage = 0.0;
  bool isProfileOpen = false;

  CurvedAnimation curve;
  Animation<double> animation;

  void onSearchVerticalDragUpdate(details) {
    closeCards = isBottomBarOpen;
    print("Offset : " + offsetProfile.toString());
    print("Offset Height : " +
        ((MediaQuery.of(context).size.height) * 0.75).toString());
    print("Percentage : " + currentProfilePercent.toString());
    offsetProfile += details.delta.dy;
    if (offsetProfile > (MediaQuery.of(context).size.height) * 0.75) {
      offsetProfile = (MediaQuery.of(context).size.height) * 0.75;
    } else if (offsetProfile < 0) {
      offsetProfile = 0;
    }
    setState(() {});
  }

  void animateProfile(bool open) {
    animationControllerProfile = AnimationController(
        duration: Duration(
            milliseconds: 1 +
                (800 *
                        (isProfileOpen
                            ? currentProfilePercent
                            : (1 - currentProfilePercent)))
                    .toInt()),
        vsync: this);
    curve =
        CurvedAnimation(parent: animationControllerProfile, curve: Curves.ease);
    animation = Tween(
            begin: offsetProfile,
            end: open ? (MediaQuery.of(context).size.height) * 0.75 : 0.0)
        .animate(curve)
          ..addListener(() {
            setState(() {
              offsetProfile = animation.value;
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              isProfileOpen = open;
            }
          });
    animationControllerProfile.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // drawer: Stack(
      //   children: <Widget>[
      //     Positioned(
      //       bottom: 0,
      //       left: 0,
      //       // right: 0,
      //       child: Container(
      //         color: Colors.red,
      //         width: MediaQuery.of(context).size.width * 0.80,
      //         height: MediaQuery.of(context).size.width * 0.80,
      //       ),
      //     ),
      //   ],
      // ),
      body: Stack(
        children: <Widget>[
          MapPage(),
          CustomBottomNavigationBarAnimated(
            currentBottomBarParallexPercent: (currentBottomBarParallexPercent) {
              print("Parallex Percentage : " +
                  currentBottomBarParallexPercent.toString());
              if (currentBottomBarParallexPercent > 0.25) {
                if (isProfileOpen) {
                  animateProfile(false);
                }
              }
            },
            currentBottomBarMorePercent: (currentBottomBarMorePercent) {
              print("More Percentage : " +
                  currentBottomBarMorePercent.toString());
              if (currentBottomBarMorePercent > 0.25) {
                if (isProfileOpen) {
                  animateProfile(false);
                }
              }
            },
            currentProfilePercentage: currentProfilePercent,
            onTap: (value) => {
              if (value == 0)
                {hideProfile()}
              else if (value == 1)
                {hideProfile()}
              else
                {showPlacePicker(context)}
            },
            moreButtons: [
              MoreButtonModel(
                icon: MaterialCommunityIcons.wallet,
                label: 'Wallet',
                onTap: () {},
              ),
              MoreButtonModel(
                icon: MaterialCommunityIcons.parking,
                label: 'My Bookings',
                onTap: () {},
              ),
              MoreButtonModel(
                icon: MaterialCommunityIcons.car_multiple,
                label: 'My Cars',
                onTap: () {},
              ),
              MoreButtonModel(
                icon: FontAwesome.book,
                label: 'Transactions',
                onTap: () {},
              ),
              MoreButtonModel(
                icon: MaterialCommunityIcons.home_map_marker,
                label: 'Offer Parking',
                onTap: () {},
              ),
              MoreButtonModel(
                icon: FontAwesome5Regular.user_circle,
                label: 'Profile',
                onTap: () {
                  animateProfile(true);
                },
              ),
              MoreButtonModel(
                icon: EvaIcons.settings,
                label: 'Settings',
                onTap: () {},
              ),
              null,
              null,
            ],
          ),
          ProfilePage(
            currentSearchPercent: currentProfilePercent,
          ),
          ProfileWidget(
            currentProfilePercent: currentProfilePercent,
            isProfileOpen: isProfileOpen,
            animateProfile: animateProfile,
            onVerticalDragUpdate: onSearchVerticalDragUpdate,
            onPanDown: () => animationControllerProfile?.stop(),
          ),
        ],
      ),
    );
  }

  hideProfile() {
    animateProfile(false);
    // setState(() {});
  }

  void showPlacePicker(BuildContext context) async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(APIKeys.google_map_key)));

    // var result =
    //     await LocationPicker.pickLocation(context, APIKeys.google_map_key);

    // Handle the result in your way
    print("Data" + result.toString());
  }

  @override
  void dispose() {
    super.dispose();

    animationControllerProfile?.dispose();
  }
}
