import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_3d_obj/flutter_3d_obj.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:the_parker/UI/Resources/APIKeys.dart';

class OfferParkingPage extends StatefulWidget {
  OfferParkingPage({Key key}) : super(key: key);

  _OfferParkingPageState createState() => _OfferParkingPageState();
}

class _OfferParkingPageState extends State<OfferParkingPage>
    with TickerProviderStateMixin {
  LatLng _initialCamera = LatLng(0, 0);

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
            // _add(position);
            _currentPosition = LatLng(position.latitude, position.longitude);

            _animatedMapMove(_currentPosition, 16);
          });
        }
      }).catchError((e) {
        //
      });
  }

  _gotoMyLocation() async {
    _animatedMapMove(
        _currentPosition ?? _lastKnownPosition ?? _initialCamera, 16);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).canvasColor,
        onPressed: () async {
          await _gotoMyLocation();
        },
        child: Icon(Icons.location_searching,
            color: Theme.of(context).textTheme.body1.color),
      ),
      body: buildMap(context),
    );
  }

  Widget buildMap(BuildContext context) {
    return FlutterMap(
      mapController: _controller,
      options: MapOptions(
        center: LatLng(51.5, -0.09),
        zoom: 13.0,
        onTap: (location) {
          print(location);
        },
        interactive: true,
        debug: true,
      ),
      layers: [
        // TileLayerOptions(
        //   // urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
        //   // subdomains: ['a', 'b', 'c'],
        //   urlTemplate: "https://a.tiles.mapbox.com/v4/"
        //       "{id}/{z}/{x}/{y}@2x.png?access_token=${APIKeys.map_box_key}",
        //   additionalOptions: {
        //     'accessToken': '${APIKeys.map_box_key}',
        //     // 'id': 'mapbox.mapbox-terrain-v2',
        //     // 'id': 'mapbox.mapbox-traffic-v1',
        //     // 'id': 'mapbox.mapbox-streets-v7',
        //     // 'id':'mapbox.mapbox-streets-v8',
        //     // 'id': 'mapbox.streets',
        //     'id': 'mapbox.streets-satellite',
        //   },
        // ),
        TileLayerOptions(
          // subdomains: ['0123'],
          // subdomains: ['a', 'b', 'c'],
          urlTemplate: 'http://mt.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
          // additionalOptions: {
          //   'id': '&copy; Google Maps',
          // },
        ),
        MarkerLayerOptions(
          markers: [
            // Marker(
            //   width: 400.0,
            //   height: 400.0,
            //   point: _currentPosition ?? _lastKnownPosition ?? _initialCamera,
            //   builder: (ctx) => Container(
            //     child: Center(
            //       child: Object3D(
            //         size: const Size(400.0, 400.0),
            //         path: "assets/3dModel/Dubai.obj",
            //         asset: true,
            //       ),
            //     ),
            //   ),
            // ),
            Marker(
              width: 30.0,
              height: 30.0,
              point: _currentPosition ?? _lastKnownPosition ?? _initialCamera,
              builder: (ctx) => Container(
                child: Card(
                  elevation: 10,
                  color: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        50,
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
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
          ],
        ),
      ],
    );
  }
}
