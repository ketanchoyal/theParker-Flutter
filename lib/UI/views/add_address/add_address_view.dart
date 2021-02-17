import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:the_parker/ui/resources/APIKeys.dart';
import 'package:the_parker/ui/resources/ConstantMethods.dart';
import 'package:the_parker/ui/views/parking_spot_detail/parking_spot_detail_view.dart';
import 'package:the_parker/ui/widgets/FloatingAppbar.dart';
import './add_address_viewmodel.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:color/color.dart';

class AddAddressView extends StatefulWidget {
  const AddAddressView({
    Key key,
    @required this.location,
    this.address,
  }) : super(key: key);
  final Location location;
  final MapBoxPlace address;

  @override
  _AddAddressViewState createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  StaticImage staticImage = StaticImage(apiKey: APIKeys.map_box_key);
  TextEditingController _addressController;
  TextEditingController _pincodeController;
  TextEditingController _mobileNoController;

  setTextEditingControllers() {
    if (widget.address != null) {
      _addressController =
          TextEditingController(text: widget.address.placeName);
      _pincodeController =
          TextEditingController(text: widget.address.addressNumber);
      _mobileNoController = TextEditingController();
    } else {
      _addressController = TextEditingController();
      _pincodeController = TextEditingController();
      _mobileNoController = TextEditingController();
    }
  }

  String getImageUrl() {
    var color = Colors.black;
    return staticImage.getStaticUrlWithMarker(
      marker: MapBoxMarker(
        markerColor: Color.rgb(color.red, color.green, color.blue),
        markerLetter: MakiIcons.parking.value,
        markerSize: MarkerSize.LARGE,
      ),
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
    return ViewModelBuilder<AddAddressViewModel>.reactive(
        viewModelBuilder: () => AddAddressViewModel(),
        onModelReady: (_) {
          setTextEditingControllers();
        },
        builder: (context, model, child) {
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
                kopenPage(context, ParkingSpotDetailView());
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
                    color: Theme.of(context).primaryColor.withOpacity(0.6),
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
                          controller: _addressController,
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
                          controller: _pincodeController,
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
                          controller: _mobileNoController,
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
        });
  }
}
