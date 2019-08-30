import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  CameraPosition _initialCamera = CameraPosition(
    target: LatLng(0, 0),
    zoom: 4,
  );

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _lastKnownPosition;
  CameraPosition _currentPosition;
  bool androidFusedLocation = true;

  @override
  void initState() {
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
    final GoogleMapController controller = await _controller.future;
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
        _add(position);
        _lastKnownPosition = CameraPosition(
          target: LatLng(
            position.latitude,
            position.longitude,
          ),
          zoom: 16,
        );

        controller.animateCamera(
          CameraUpdate.newCameraPosition(_lastKnownPosition),
        );
      },
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  _initCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    Geolocator()
      ..forceAndroidLocationManager = !androidFusedLocation
      ..getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      ).then((position) {
        if (mounted) {
          setState(() {
            _add(position);
            _currentPosition = CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 16,
            );

            controller.animateCamera(
              CameraUpdate.newCameraPosition(_currentPosition),
            );
          });
        }
      }).catchError((e) {
        //
      });
  }

  _gotoMyLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
          _currentPosition ?? _lastKnownPosition ?? _initialCamera),
    );
  }

  Map<MarkerId, Marker> markers = Map<MarkerId, Marker>();
  MarkerId selectedMarker;
  static final LatLng center = const LatLng(-33.86711, 151.1947171);
  int _markerIdCounter = 1;

  void _onMarkerTapped(MarkerId markerId) {
    final Marker tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        if (markers.containsKey(selectedMarker)) {
          final Marker resetOld = markers[selectedMarker]
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[selectedMarker] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          draggableParam: true,
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;
      });
    }
  }

  void _add(Position position) {
    final int markerCount = markers.length;

    if (markerCount == 12) {
      return;
    }

    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      visible: true,
      markerId: markerId,
      // icon: BitmapDescriptor.,
      position: LatLng(position.latitude, position.longitude
          // center.latitude + sin(_markerIdCounter * pi / 6.0) / 20.0,
          // center.longitude + cos(_markerIdCounter * pi / 6.0) / 20.0,
          ),
      infoWindow: InfoWindow(title: markerIdVal, snippet: 'Hello'),
      onTap: () {
        _onMarkerTapped(markerId);
      },
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: FutureBuilder<GeolocationStatus>(
          future: Geolocator().checkGeolocationPermissionStatus(),
          builder: (BuildContext context,
              AsyncSnapshot<GeolocationStatus> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return Stack(
              children: <Widget>[
                GoogleMap(
                  // gestureRecognizers: Set()
                  //   ..add(Factory<PanGestureRecognizer>(
                  //       () => PanGestureRecognizer()))
                  //   ..add(Factory<ScaleGestureRecognizer>(
                  //       () => ScaleGestureRecognizer()))
                  //   ..add(Factory<TapGestureRecognizer>(
                  //       () => TapGestureRecognizer()))
                  //   ..add(Factory<VerticalDragGestureRecognizer>(
                  //       () => VerticalDragGestureRecognizer())),
                  mapType: MapType.normal,
                  compassEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  initialCameraPosition:
                      _currentPosition ?? _lastKnownPosition ?? _initialCamera,
                  rotateGesturesEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onCameraMove: (CameraPosition position) {
                    CameraUpdate.newCameraPosition(position);
                  },
                  // markers: Set<Marker>.of(markers.values),
                ),

                // _builtSearchBar(),
              ],
            );
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 65),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).canvasColor,
          onPressed: () async {
            await _gotoMyLocation();
          },
          child: Icon(Icons.location_searching,
              color: Theme.of(context).textTheme.body1.color),
        ),
      ),
    );
  }
}
