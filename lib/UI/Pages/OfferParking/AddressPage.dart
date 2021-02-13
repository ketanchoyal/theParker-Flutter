import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:the_parker/UI/Pages/OfferParking/ParkingSpotDetailPage.dart';
import 'package:the_parker/UI/Resources/APIKeys.dart';
import 'package:the_parker/UI/Resources/ConstantMethods.dart';
import 'package:the_parker/UI/Widgets/FloatingAppbar.dart';
import 'package:color/color.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({
    Key key,
    @required this.location,
  }) : super(key: key);
  final Location location;

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  StaticImage staticImage = StaticImage(apiKey: APIKeys.map_box_key);

  String getImageUrl() {
    var color = Colors.black;
    return staticImage.getStaticUrlWithMarker(
      marker: MapBoxMarker(
          markerColor: Color.rgb(color.red, color.green, color.blue),
          markerLetter: 'p',
          markerSize: MarkerSize.LARGE),
      center: widget.location,
      height: 900,
      width: 600,
      zoomLevel: 15,
      style: MapBoxStyle.Outdoors,
      render2x: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          EvaIcons.arrowForward,
        ),
        label: Text(
          'Next',
          style: ksubtitleStyle,
        ),
        onPressed: () {
          kopenPage(context, ParkingSpotDetailsPage());
        },
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              // color: Colors.red,
              child: Image.network(
                getImageUrl(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              color: Theme.of(context).primaryColor.withOpacity(0.7),
            ),
          ),
          Positioned(
            // top: MediaQuery.of(context).size.height * 0.15,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).size.height * 0.1,
            child: Container(
              // color: Colors.red,
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.multiline,
                    style: ktitleStyle.copyWith(
                      fontSize: 18,
                    ),
                    maxLines: 4,
                    minLines: 2,
                    enableInteractiveSelection: true,
                    textInputAction: TextInputAction.unspecified,
                    decoration: kTextFieldDecorationAddress.copyWith(
                      labelText: 'Address',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    style: ktitleStyle.copyWith(
                      fontSize: 18,
                    ),
                    enableInteractiveSelection: true,
                    textInputAction: TextInputAction.done,
                    decoration: kTextFieldDecorationAddress.copyWith(
                      labelText: 'Pincode',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType: TextInputType.phone,
                    style: ktitleStyle.copyWith(
                      fontSize: 18,
                    ),
                    enableInteractiveSelection: true,
                    textInputAction: TextInputAction.done,
                    decoration: kTextFieldDecorationAddress.copyWith(
                      labelText: 'Mobile No.',
                    ),
                  ),
                ],
              ),
            ),
          ),
          FloatingAppbar(
            fontSize: 20,
            title: 'Address',
          ),
        ],
      ),
    );
  }
}
