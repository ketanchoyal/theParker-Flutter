import 'dart:math';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:extended_navbar_scaffold/extended_navbar_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
import 'package:the_parker/UI/Pages/OfferParking/OfferParkingMap.dart';
import 'package:the_parker/UI/Pages/ProfilePage.dart';
import 'package:the_parker/UI/Resources/APIKeys.dart';
import 'package:the_parker/UI/Resources/ConstantMethods.dart';
import 'package:the_parker/UI/Widgets/ProfileWidget.dart';
import 'MapPage.dart';
import 'package:color/color.dart';

// class ParallexCardItemssNew extends ParallaxCardItem {
//   ParallexCardItemssNew({
//     this.title,
//     this.body,
//     this.background,
//     this.data,
//   });

//   final String title;
//   final String body;
//   final Widget background;
//   final dynamic data;
// }

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

  StaticImage staticImage = StaticImage(apiKey: APIKeys.map_box_key);

  @override
  build(BuildContext context) {
    return ExtendedNavigationBarScaffold(
      elevation: 0,
      searchWidget: builtSearchBar(),
      // searchWidget: Container(
      //   height: 10,
      //   color: Colors.red,
      // ),
      body: Stack(
        children: <Widget>[
          MapPage(),
          // Container(
          //   color: Colors.blue,
          // ),
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
      currentBottomBarCenterPercent: (currentBottomBarCenterPercent) {
        print("Parallex Percentage : " +
            currentBottomBarCenterPercent.toString());
        if (currentBottomBarCenterPercent > 0.25) {
          if (isProfileOpen) {
            animateProfile(false);
          }
        }
      },
      currentBottomBarMorePercent: (currentBottomBarMorePercent) {
        print("More Percentage : " + currentBottomBarMorePercent.toString());
        if (currentBottomBarMorePercent > 0.25) {
          if (isProfileOpen) {
            animateProfile(false);
          }
        }
      },
      currentBottomBarSearchPercent: (currentBottomBarSearchPercent) {
        this.currentBottomBarSearchPercent = currentBottomBarSearchPercent;
        print(
            'Search Percentage : ' + currentBottomBarSearchPercent.toString());

        if (currentBottomBarSearchPercent == 0.0) {
          searchBarVisible = false;
        } else {
          searchBarVisible = true;
        }
        setState(() {});
      },
      currentExternalAnimationPercentage: currentProfilePercent,
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
          onTap: () {
            kopenPage(
              context,
              OfferParkingMap(),
            );
          },
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
      parallexCardPageTransformer: PageTransformer(
        pageViewBuilder: (context, visibilityResolver) {
          return PageView.builder(
            controller: PageController(viewportFraction: 0.85),
            itemCount: parallaxCardItemsList.length,
            itemBuilder: (context, index) {
              final item = parallaxCardItemsList[index];
              String mapStaticImageUrl = staticImage.getStaticUrlWithPolyline(
                point1: Location(lat: 37.77343, lng: -122.46589),
                point2: Location(lat: 37.75965, lng: -122.42816),
                center: Location(lat: 0.0, lng: 0.0),
                marker1: MapBoxMarker(
                    markerColor: Color.rgb(0, 0, 0),
                    markerLetter: MakiIcons.airport.value,
                    markerSize: MarkerSize.SMALL),
                marker2: MapBoxMarker(
                    markerColor: Color.rgb(244, 67, 54),
                    markerLetter: 'q',
                    markerSize: MarkerSize.SMALL),
                height: 300,
                width: 500,
                style: MapBoxStyle.Streets,
                render2x: true,
                auto: true,
              );
              var background = Image.network(
                mapStaticImageUrl,
                fit: BoxFit.cover,
              );
              final pageVisibility =
                  visibilityResolver.resolvePageVisibility(index);
              return ParallaxCardsWidget(
                item: ParallaxCardItem(
                  body: item.body,
                  background: background,
                  // background: Container(
                  //   color: Colors.red,
                  // ),
                  // background: background,
                  title: item.title,
                ),
                pageVisibility: pageVisibility,
              );
            },
          );
        },
      ),
    );
  }

  final parallaxCardItemsList = <ParallaxCardItem>[
    ParallaxCardItem(
      title: 'Some Random Route 1',
      body: 'Place 1',
      // marker: Marker(
      //   markerId: MarkerId('nswtdkaslnnad'),
      //   position: LatLng(19.017573, 72.856276),
      // ),
    ),
    ParallaxCardItem(
      title: 'Some Random Route 2',
      body: 'Place 2',
      // marker: Marker(
      //     markerId: MarkerId('nsdkasnnad'),
      //     position: LatLng(19.017573, 72.856276)),
    ),
    ParallaxCardItem(
      title: 'Some Random Route 3',
      body: 'Place 1',
      // marker: Marker(
      //     markerId: MarkerId('nsdkasnndswad'),
      //     position: LatLng(19.077573, 72.856276)),
    ),
  ];

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
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: MapBoxPlaceSearchWidget(
        apiKey: APIKeys.map_box_key,
        // limit: 10,
        context: context,
        popOnSelect: false,
        // height: 100,
        height: 290,
        // language: 'en',
        // location: LatLng(location.latitude, location.longitude),
        onSelected: (MapBoxPlace place) async {
          print(place.center);
          // print(place.)
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    animationControllerProfile?.dispose();
  }
}
