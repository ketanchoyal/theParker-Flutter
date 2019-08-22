import 'dart:math';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:the_parker/UI/Pages/ProfilePage.dart';
import 'package:the_parker/UI/Resources/APIKeys.dart';
import 'package:the_parker/UI/Widgets/AnimatedBottomNavigation.dart';
import 'package:the_parker/UI/Widgets/ProfileWidget.dart';
import 'MapPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool isBottomBarOpen = false;
  bool closeCards = false;
  bool searchBarVisible = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double currentBottomBarSearchPercent = 0.0;

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
      body: Stack(
        children: <Widget>[
          MapPage(),
          // _builtSearchBar(),
          CustomBottomNavigationBarAnimated(
            searchWidget: builtSearchBar(),
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
            currentBottomBarSearchPercent: (currentBottomBarSearchPercent) {
              this.currentBottomBarSearchPercent =
                  currentBottomBarSearchPercent;
              print('Search Percentage : ' +
                  currentBottomBarSearchPercent.toString());

              if (currentBottomBarSearchPercent == 0.0) {
                searchBarVisible = false;
              } else {
                searchBarVisible = true;
              }
              setState(() {});
            },
            currentProfilePercentage: currentProfilePercent,
            onTap: (value) => {
              if (value == 0)
                {hideProfile()}
              else if (value == 1)
                {hideProfile()}
              else
                {
                  enableDisableSearchBar()
                  // showPlacePicker(context)
                }
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

  enableDisableSearchBar() {
    setState(() {
      searchBarVisible = !searchBarVisible;
    });
  }

  Widget builtSearchBar() {
    return SearchMapPlaceWidget(
      apiKey: APIKeys.google_map_key,
      strictBounds: false,
      language: 'en',
      // location: LatLng(location.latitude, location.longitude),
      // radius: 100,
      onSelected: (Place place) async {
        print(place.fullJSON.toString());
        place.geolocation.then((onValue) {
          print(onValue.coordinates.toString());
        }).catchError((e) {
          print(e);
        });
        final geolocation = await place.geolocation;
        print(geolocation.fullJSON);
      },
      onSearch: (Place place) async {
        print(place.description);
        final geolocation = await place.geolocation;
        print(geolocation.fullJSON);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    animationControllerProfile?.dispose();
  }
}
