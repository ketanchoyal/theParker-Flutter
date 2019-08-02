import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:the_parker/UI/Resources/ConstantMethods.dart';
import 'package:the_parker/UI/utils/page_transformer.dart';

class ParallaxCardItem {
  ParallaxCardItem({this.title, this.body, this.marker, this.userPosition});

  final String title;
  final String body;
  final Marker marker;
  final LatLng userPosition;
}

class ParallaxCardsWidget extends StatefulWidget {
  ParallaxCardsWidget({
    @required this.item,
    @required this.pageVisibility,
  });

  final ParallaxCardItem item;
  final PageVisibility pageVisibility;

  @override
  _ParallaxCardsWidgetState createState() => _ParallaxCardsWidgetState();
}

class _ParallaxCardsWidgetState extends State<ParallaxCardsWidget> {
  final CameraPosition _initialCamera = CameraPosition(
    target: LatLng(0, 0),
    zoom: 4,
  );

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _markerPosition;

  _initMarkerLocation() async {
    final GoogleMapController controller = await _controller.future;
    if (mounted)
      setState(() {
        _markerPosition =
            CameraPosition(target: widget.item.marker.position, zoom: 16);
      });

    controller.animateCamera(CameraUpdate.newCameraPosition(_markerPosition));
  }

  Widget _applyTextEffects({
    @required double translationFactor,
    @required Widget child,
  }) {
    final double xTranslation =
        widget.pageVisibility.pagePosition * translationFactor;

    return Opacity(
      opacity: widget.pageVisibility.visibleFraction,
      child: Transform(
        alignment: FractionalOffset.topLeft,
        transform: Matrix4.translationValues(
          xTranslation,
          0.0,
          0.0,
        ),
        child: child,
      ),
    );
  }

  _buildTextContainer(BuildContext context) {
    var categoryText = _applyTextEffects(
      translationFactor: 300.0,
      child: Padding(
        padding: EdgeInsets.all(3.0),
        child: Text(
          widget.item.body,
          style: ktitleStyle.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 22.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

    var titleText = _applyTextEffects(
      translationFactor: 200.0,
      child: Padding(
        padding: EdgeInsets.all(3.0),
        child: Text(
          widget.item.title,
          style: ktitleStyle.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 20.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Positioned(
      top: 5,
      // bottom: 50.0,
      left: 10.0,
      // right: 10.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          categoryText,
          titleText,
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initMarkerLocation();
  }

  @override
  void didUpdateWidget(ParallaxCardsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initMarkerLocation();
  }

  @override
  Widget build(BuildContext context) {
    Map<MarkerId, Marker> markers = Map<MarkerId, Marker>();
    markers[widget.item.marker.markerId] = widget.item.marker;

    var googleMap = GoogleMap(
      mapType: MapType.normal,
      compassEnabled: true,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      initialCameraPosition: _markerPosition ?? _initialCamera,
      rotateGesturesEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      scrollGesturesEnabled: false,
      zoomGesturesEnabled: false,
      markers: Set<Marker>.of(markers.values),
    );

    var imageOverlayGradient = DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black12,
            // Colors.transparent,
            // Colors.black12,
            // Colors.black26,
            // Colors.black38,
            Colors.black87,
            // Colors.black,
          ],
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 22.0,
        horizontal: 8.0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Material(
          child: Stack(
            fit: StackFit.expand,
            children: [
              googleMap,
              imageOverlayGradient,
              _buildTextContainer(context),
            ],
          ),
        ),
      ),
    );
  }
}
