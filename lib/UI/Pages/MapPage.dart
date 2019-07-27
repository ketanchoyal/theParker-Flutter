import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:the_parker/UI/Resources/APIKeys.dart';
import 'package:the_parker/UI/Resources/Resources.dart';
import 'package:the_parker/UI/Widgets/ParallexCardWidet.dart';
import 'package:the_parker/UI/utils/page_transformer.dart';

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

  final parallaxCardItemsList = <ParallaxCardItem>[
    ParallaxCardItem(
      title: 'Blurryface',
      body: 'Twenty One Pilots',
      imagePath: Kassets.group,
    ),
    ParallaxCardItem(
      title: 'Free Spirit',
      body: 'Khalid',
      imagePath: Kassets.shakeHands,
    ),
    ParallaxCardItem(
      title: 'Overexposed',
      body: 'Maroon 5',
      imagePath: Kassets.parking,
    ),
  ];

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
                  mapType: MapType.normal,
                  compassEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: _currentPosition == null
                      ? _lastKnownPosition == null
                          ? _initialCamera
                          : _initialCamera
                      : _currentPosition,
                  rotateGesturesEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onCameraMove: (CameraPosition position) {
                    CameraUpdate.newCameraPosition(position);
                  },
                  markers: Set<Marker>.of(markers.values),
                ),
                _buildParallexCards()
                // _builtSearchBar(),
              ],
            );
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 65),
        child: FloatingActionButton(
          onPressed: () async {
            await _gotoMyLocation();
          },
          child: Icon(Icons.location_searching),
        ),
      ),
    );
  }

  Widget _buildParallexCards() {
    return Positioned(
      bottom: 50,
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

  Widget _builtSearchBar() {
    return Positioned(
      left: 10,
      right: 10,
      top: 10,
      child: SafeArea(
        child: SearchMapPlaceWidget(
          apiKey: APIKeys.google_map_key,
          language: 'en',
          // location: LatLng(location.latitude, location.longitude),
          // radius: 100,
          onSelected: (Place place) async {
            print(place.fullJSON.toString());
            place.geolocation.then((onValue) {
              print(onValue.coordinates.toString());
            });
            // final geolocation = await place.geolocation;

            // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom
            // final GoogleMapController controller =
            //     await _controller.future;
            // controller.animateCamera(
            //     CameraUpdate.newLatLng(geolocation.coordinates));
            // controller.animateCamera(
            //     CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
          },
          onSearch: (Place place) async {
            print(place.description);
            final geolocation = await place.geolocation;

            // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom
            final GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newLatLng(geolocation.coordinates));
            controller.animateCamera(
                CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
          },
        ),
      ),
    );
  }
}
