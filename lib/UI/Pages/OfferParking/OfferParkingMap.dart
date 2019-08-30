import 'dart:async';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:the_parker/UI/Resources/ConstantMethods.dart';

class OfferParkingMap extends StatefulWidget {
  OfferParkingMap({Key key}) : super(key: key);

  _OfferParkingMapState createState() => _OfferParkingMapState();
}

class _OfferParkingMapState extends State<OfferParkingMap>
    with TickerProviderStateMixin {
  LatLng _initialCamera = LatLng(51.5, -0.09);

  MapController _controller;

  LatLng _lastKnownPosition;
  LatLng _currentPosition;

  bool androidFusedLocation = true;

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final _latTween = Tween<double>(
        begin: _controller.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: _controller.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: _controller.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      _controller.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  Stream<Position> _realtimeLocationStream() {
    Stream<Position> positionStream =
        Geolocator().getPositionStream().asBroadcastStream();
    positionStream.listen((Position pos) {
      _lastKnownPosition = _currentPosition;
      _currentPosition = LatLng(pos.latitude, pos.longitude);
      return;
    });
    return positionStream;
  }

  StreamController<double> _zoom = StreamController();

  @override
  void dispose() {
    _zoom.close();
    super.dispose();
  }

  @override
  void initState() {
    _controller = MapController();
    super.initState();

    _initLastKnownLocation();
    _initCurrentLocation();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(() {
      _lastKnownPosition = null;
      _currentPosition = null;
    });

    _initLastKnownLocation();
    _initCurrentLocation();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initLastKnownLocation() async {
    Position position;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final Geolocator geolocator = Geolocator()
        ..forceAndroidLocationManager = !androidFusedLocation;
      position = await geolocator.getLastKnownPosition(
          desiredAccuracy: LocationAccuracy.best);
    } on PlatformException {
      position = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(
      () {
        // _add(position);
        _lastKnownPosition = LatLng(
          position.latitude,
          position.longitude,
        );

        _animatedMapMove(_lastKnownPosition, 16);

        // _controller.move(_lastKnownPosition, 16);
      },
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  _initCurrentLocation() async {
    Geolocator()
      ..forceAndroidLocationManager = !androidFusedLocation
      ..getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      ).then((position) {
        if (mounted) {
          setState(() {
            _currentPosition = LatLng(position.latitude, position.longitude);
            _animatedMapMove(_currentPosition, 16);
          });
        }
      }).catchError((e) {
        //
      });
  }

  _gotoMyLocation() async {
    // _initCurrentLocation();
    _animatedMapMove(
        _currentPosition ?? _lastKnownPosition ?? _initialCamera, 17);
  }

  List<Marker> markers = [];

  addMarkerInList(Marker newMarker) {
    markers.clear();
    markers.add(newMarker);
    setState(() {});
  }

  double zoom = 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: markers.length > 0
          ? FloatingActionButton.extended(
              // heroTag: 'sdsa',
              backgroundColor: Theme.of(context).canvasColor,
              onPressed: () async {
                await _gotoMyLocation();
              },
              label: Text(
                'Next',
                style: ktitleStyle,
              ),
              icon: Icon(
                EvaIcons.arrowIosForward,
                color: Theme.of(context).textTheme.body1.color,
              ),
            )
          : FloatingActionButton(
              // heroTag: 'sdsa',
              backgroundColor: Theme.of(context).canvasColor,
              onPressed: () async {
                await _gotoMyLocation();
              },

              isExtended: markers.length > 0,
              child: Icon(
                Icons.location_searching,
                color: Theme.of(context).textTheme.body1.color,
              ),
            ),
      body: Stack(
        children: <Widget>[
          buildMap(context),
          Positioned(
            top: 0,
            left: 5,
            right: 5,
            child: SafeArea(
              child: Row(
                children: <Widget>[
                  Card(
                    child: Container(
                      height: 50,
                      width: 50,
                      child: RawMaterialButton(
                        onPressed: () {
                          kbackBtn(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Text(
                            'Long Tap to select parking Space',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: ksubtitleStyle.copyWith(fontSize: 16),
                          ),
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
    );
  }

  Widget buildMap(BuildContext context) {
    return StreamBuilder<Position>(
        stream: _realtimeLocationStream(),
        builder: (context, snapshot) {
          return StreamBuilder<double>(
              stream: _zoom.stream,
              initialData: 8,
              builder: (context, zoom) {
                this.zoom = zoom.data;
                return FlutterMap(
                  mapController: _controller,
                  options: MapOptions(
                    center: _currentPosition ?? _initialCamera,
                    zoom: 13.0,
                    maxZoom: 22,
                    onLongPress: (location) {
                      markers.clear();
                      setState(() {});
                    },
                    onPositionChanged: (positon, b) {
                      _zoom.add(_controller.zoom);
                    },
                    onTap: (location) {
                      addMarkerInList(
                        _buildLocationMarker(
                          color: Colors.red,
                          colorAccent: Colors.redAccent,
                          location: location,
                        ),
                      );
                    },
                    interactive: true,
                    debug: true,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          'http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                      // urlTemplate: 'http://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                      subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
                      maxZoom: 22,
                      zoomReverse: true,
                    ),
                    MarkerLayerOptions(
                      markers: [
                        _buildLocationMarker(),
                      ],
                    ),
                    MarkerLayerOptions(
                      markers: markers,
                    ),
                  ],
                );
              });
        });
  }

  Marker _buildLocationMarker({
    Color color,
    Color colorAccent,
    LatLng location,
  }) {
    return Marker(
      width: zoom > 8 ? 20 + zoom : 28,
      height: zoom > 8 ? 20 + zoom : 28,
      point:
          location ?? _currentPosition ?? _lastKnownPosition ?? _initialCamera,
      builder: (ctx) => Container(
        // height: 40,
        // width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              50,
            ),
          ),
          gradient: RadialGradient(
            colors: [
              color ?? Colors.blue,
              color == null
                  ? Colors.blue.withOpacity(0.5)
                  : color.withOpacity(0.5),
            ],
            center: Alignment.center,
            tileMode: TileMode.clamp,
          ),
        ),
        child: Container(
          height: 20,
          width: 20,
          padding: EdgeInsets.all(2),
          child: Card(
            elevation: 10,
            color: colorAccent ?? color ?? Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  30,
                ),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: colorAccent ?? color ?? Colors.blueAccent,
                border: Border.all(
                  color: Colors.white,
                  style: BorderStyle.solid,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    50,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
