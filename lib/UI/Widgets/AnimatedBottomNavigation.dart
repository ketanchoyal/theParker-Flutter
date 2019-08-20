import 'dart:math';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:the_parker/UI/Resources/ConstantMethods.dart';
import 'package:the_parker/UI/Widgets/ParallexCardWidet.dart';
import 'package:the_parker/UI/Widgets/ease_in_widget.dart';
import 'package:the_parker/UI/utils/page_transformer.dart';

class CustomBottomNavigationBarAnimated extends StatefulWidget {
  CustomBottomNavigationBarAnimated({
    Key key,
    this.onTap,
    this.currentBottomBarPercent,
    this.currentProfilePercentage,
    // this.closeProfile,
  }) : super(key: key);

  final Function(int) onTap;
  // final Function(bool) closeProfile;
  final Function(double) currentBottomBarPercent;
  final double currentProfilePercentage;

  _CustomBottomNavigationBarAnimatedState createState() =>
      _CustomBottomNavigationBarAnimatedState();
}

class _CustomBottomNavigationBarAnimatedState
    extends State<CustomBottomNavigationBarAnimated>
    with TickerProviderStateMixin {
  AnimationController animationControllerBottomBar;

  var offsetBottomBar = 0.0;
  get currentBottomBarPercent =>
      max(0.0, min(1.0, offsetBottomBar / (300 - 80.0)));
  bool isBottomBarOpen = false;

  CurvedAnimation curve;
  Animation<double> animation;

  void onBottomBarVerticalDragUpdate(details) {
    offsetBottomBar -= details.delta.dy;
    if (offsetBottomBar > 300) {
      offsetBottomBar = 300;
    } else if (offsetBottomBar < 0) {
      offsetBottomBar = 0;
    }
    widget.currentBottomBarPercent(currentBottomBarPercent);
    setState(() {});
  }

  void animateBottomBar(bool open) {
    if (isBottomBarOpen) {
      isBottomBarOpen = false;
    }

    animationControllerBottomBar = AnimationController(
        duration: Duration(
            milliseconds: 1 +
                (800 *
                        (isBottomBarOpen
                            ? currentBottomBarPercent
                            : (1 - currentBottomBarPercent)))
                    .toInt()),
        vsync: this);
    curve = CurvedAnimation(
        parent: animationControllerBottomBar, curve: Curves.ease);
    animation =
        Tween(begin: offsetBottomBar, end: open ? 300.0 : 0.0).animate(curve)
          ..addListener(() {
            setState(() {
              offsetBottomBar = animation.value;
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              isBottomBarOpen = open;
            }
          });
    animationControllerBottomBar.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.currentProfilePercentage > 0.30) {
      if (isBottomBarOpen) {
        animateBottomBar(false);
      }
    }
    return CustomBottomNavigationBar(
      animateBottomBar: animateBottomBar,
      currentBottomBarPercentage: currentBottomBarPercent,
      isBottomBarOpen: isBottomBarOpen,
      onTap: widget.onTap,
      onVerticalDragUpdate: onBottomBarVerticalDragUpdate,
      onPanDown: () => animationControllerBottomBar?.stop(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationControllerBottomBar?.dispose();
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  CustomBottomNavigationBar(
      {Key key,
      this.onTap,
      this.animateBottomBar,
      this.currentBottomBarPercentage,
      this.isBottomBarOpen,
      this.onPanDown,
      this.onVerticalDragUpdate})
      : super(key: key);

  final Function(int) onTap;

  final double currentBottomBarPercentage;

  final Function(bool) animateBottomBar;

  final bool isBottomBarOpen;

  final Function(DragUpdateDetails) onVerticalDragUpdate;

  final Function() onPanDown;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 15,
      right: 15,
      child: Card(
        color: Colors.transparent,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: SizedBox(
          height: 80 + 220 * currentBottomBarPercentage,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 25,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 200 * currentBottomBarPercentage,
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
              ),
              isBottomBarOpen ? _buildParallexCards() : Container(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  height: 55,
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          padding: EdgeInsets.only(right: 35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                EvaIcons.menuArrow,
                                size: 30,
                                // color: Theme.of(context).primaryColor,
                              ),
                              Text(
                                'More',
                                style: ktitleStyle.copyWith(
                                  fontSize: 13,
                                  // color: Theme.of(context).primaryColor,
                                ),
                              )
                            ],
                          ),
                          onPressed: () {
                            onTap(0);
                            print(currentBottomBarPercentage);
                          },
                        ),
                      ),
                      Expanded(
                        child: FlatButton(
                          padding: EdgeInsets.only(left: 35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                EvaIcons.search,
                                size: 30,
                                // color: Theme.of(context).primaryColor,
                              ),
                              Text(
                                'Search',
                                style: ktitleStyle.copyWith(
                                  fontSize: 13,
                                  // color: Theme.of(context).primaryColor,
                                ),
                              )
                            ],
                          ),
                          onPressed: () {
                            onTap(2);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: EaseInWidget(
                    onTap: () {
                      onTap(1);
                      animateBottomBar(!isBottomBarOpen);
                    },
                    child: GestureDetector(
                      onPanDown: (_) => onPanDown,
                      onVerticalDragUpdate: onVerticalDragUpdate,
                      onVerticalDragEnd: (_) {
                        _dispatchBottomBarOffset();
                      },
                      onVerticalDragCancel: () {
                        _dispatchBottomBarOffset();
                      },
                      child: FloatingActionButton(
                        backgroundColor:
                            Theme.of(context).textTheme.body1.color,
                        heroTag: 'adaojd',
                        elevation: 0,
                        onPressed: null,
                        child: Icon(
                          Icons.view_column,
                          color: Theme.of(context).canvasColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final parallaxCardItemsList = <ParallaxCardItem>[
    ParallaxCardItem(
      title: 'Overexposed',
      body: 'Maroon 5',
      marker: Marker(
          markerId: MarkerId('nswtdkaslnnad'),
          position: LatLng(19.017573, 72.856276)),
    ),
    ParallaxCardItem(
      title: 'Blurryface',
      body: 'Twenty One Pilots',
      marker: Marker(
          markerId: MarkerId('nsdkasnnad'),
          position: LatLng(19.017573, 72.856276)),
    ),
    ParallaxCardItem(
      title: 'Free Spirit',
      body: 'Khalid',
      marker: Marker(
          markerId: MarkerId('nsdkasnndswad'),
          position: LatLng(19.077573, 72.856276)),
    ),
  ];

  Widget _buildParallexCards() {
    return Positioned(
      bottom: 35,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.only(bottom: 30.0),
        child: SizedBox.fromSize(
          size: Size.fromHeight(200.0),
          child: PageTransformer(
            pageViewBuilder: (context, visibilityResolver) {
              return PageView.builder(
                controller: PageController(viewportFraction: 0.85),
                itemCount: parallaxCardItemsList.length,
                itemBuilder: (context, index) {
                  final item = parallaxCardItemsList[index];
                  final pageVisibility =
                      visibilityResolver.resolvePageVisibility(index);
                  return ParallaxCardsWidget(
                    item: item,
                    pageVisibility: pageVisibility,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _dispatchBottomBarOffset() {
    if (!isBottomBarOpen) {
      if (currentBottomBarPercentage < 0.3) {
        animateBottomBar(false);
      } else {
        animateBottomBar(true);
      }
    } else {
      if (currentBottomBarPercentage > 0.6) {
        animateBottomBar(true);
      } else {
        animateBottomBar(false);
      }
    }
  }
}
