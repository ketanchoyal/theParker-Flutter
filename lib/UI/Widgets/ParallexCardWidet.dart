import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:the_parker/UI/Resources/APIKeys.dart';
import 'package:the_parker/UI/Resources/ConstantMethods.dart';
import 'package:the_parker/UI/Resources/MapBoxStaticImage.dart';
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
  String mapStaticImageUrl;

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
            color: Colors.white,
            // fontWeight: FontWeight.w600,
            fontSize: 22.0,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );

    var titleText = _applyTextEffects(
      translationFactor: 200.0,
      child: Padding(
        padding: EdgeInsets.all(3.0),
        child: Text(
          widget.item.title,
          style: ksubtitleStyle.copyWith(
            color: Colors.white,
            // fontWeight: FontWeight.w700,
            fontSize: 20.0,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );

    return Positioned(
      // top: 5,
      bottom: 5.0,
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

  String getImageUri({int zoom = 15}) {
    //TODO : Inititate it in locator to use same instance everytime
    MapBoxStaticImage staticImage =
        MapBoxStaticImage(apiKey: APIKeys.map_box_key);
    // mapStaticImageUrl = staticImage.getStaticUrlWithMarker(
    //     center: Location(widget.item.marker.position.latitude,
    //         widget.item.marker.position.longitude),
    //     height: 300,
    //     width: 400,
    //     render2x: false,
    //     zoomLevel: zoom,
    //     style: MapBoxStyle.Mapbox_Streets);
    mapStaticImageUrl = staticImage.getStaticUrlWithPolyline(
      point1: Location(37.77343, -122.46589),
      point2: Location(37.75965, -122.42816),
      pin1: CreatePin(pinColor: Colors.black, pinLetter: 'p', pinSize: 'l'),
      pin2: CreatePin(pinColor: Colors.redAccent, pinLetter: 'q', pinSize: 's'),
      height: 300,
      width: 600,
      zoomLevel: 16,
      style: MapBoxStyle.Mapbox_Streets,
      path: CreatePath(pathColor: Colors.black, pathOpacity: 0.5, pathWidth: 5),
      render2x: true,
    );
    // mapStaticImageUrl =
    //     "https://api.mapbox.com/styles/v1/mapbox/outdoors-v11/static/${widget.item.marker.position.longitude},${widget.item.marker.position.latitude},$zoom,0,20/600x400@2x?access_token=pk.eyJ1IjoicGFya2luZ3N5c3RlbSIsImEiOiJjanpqbW9oZ2owYW5zM2dwZWlyd3RuaHRwIn0.kTF1XSrSe23_N-72xCRV4w";
    // print(mapStaticImageUrl);
    return mapStaticImageUrl;
  }

  @override
  void initState() {
    super.initState();
    _initMarkerLocation();
    // getImageUri();
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

    // var googleMap = GoogleMap(
    //   mapType: MapType.normal,
    //   compassEnabled: true,
    //   myLocationEnabled: true,
    //   myLocationButtonEnabled: false,
    //   initialCameraPosition: _markerPosition ?? _initialCamera,
    //   rotateGesturesEnabled: true,
    //   onMapCreated: (GoogleMapController controller) {
    //     _controller.complete(controller);
    //   },
    //   scrollGesturesEnabled: false,
    //   zoomGesturesEnabled: false,
    //   markers: Set<Marker>.of(markers.values),
    // );

    var centerMarker = Align(
      alignment: Alignment.center,
      child: Icon(
        Icons.location_on,
        color: Colors.red,
        size: 40,
      ),
    );

    var googleMap = Image.network(
      getImageUri(zoom: 17),
      fit: BoxFit.cover,
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
        vertical: 20.0,
        horizontal: 5.0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Material(
          shadowColor: Theme.of(context).accentColor,
          elevation: 10,
          type: MaterialType.card,
          child: Stack(
            fit: StackFit.expand,
            children: [
              googleMap,
              // centerMarker,
              imageOverlayGradient,
              _buildTextContainer(context),
            ],
          ),
        ),
      ),
    );
  }
}
