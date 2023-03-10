import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:employee/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapScreen extends StatefulWidget {
  final int? id;
  final String? title;

  const GoogleMapScreen({Key? key, this.id, this.title}) : super(key: key);
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  Set<Marker> _marker = {};
  GoogleMapController? mapcontroller;
  final Location location = Location();
  void onMapCreated(GoogleMapController controller) {
    // setState(() {
    mapcontroller = controller;
    getPosition();
    // });
  }

  @override
  void initState() {
    super.initState();
  }

  void getAddress(double lati, double long) {}
  getPosition() async {
    var p = await location.getLocation();
    //_address =
    latitude = p.latitude;
    longitude = p.longitude;
    log("getPosition---->$latitude");
    mapcontroller!.animateCamera(CameraUpdate.newLatLng(
      LatLng(latitude, longitude),
    ));
    setState(() {
      _marker.add(
          Marker(markerId: MarkerId('id-1'), position: LatLng(latitude, longitude), infoWindow: InfoWindow(title: "")));
      CameraPosition(target: LatLng(latitude, longitude), zoom: 20);
    });
  }

  String? _address;

  var longitude, latitude;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          "Please select your shop location",
          style: TextStyle(fontSize: 16),
          maxLines: 1,
          maxFontSize: 16,
          minFontSize: 15,
        ),
        leadingWidth: 0,
        leading: Text(""),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: MaterialButton(
              minWidth: 60,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              onPressed: () {
                log("kai kai---->");
                Navigator.pop(context, {
                  "lat": latitude,
                  "long": longitude,
                });
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => VendorForm(
                //               id: widget.id,
                //               title: widget.title,
                //               lat: latitude,
                //               long: longitude,
                //             )));
              },
              child: Text(
                "Done",
                style: TextStyle(color: ColorPrimary, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: GoogleMap(
            mapType: MapType.normal,
            buildingsEnabled: true,
            myLocationEnabled: true,
            onTap: (latlng) {
              latitude = latlng.latitude;
              longitude = latlng.longitude;
              log("$latitude");
              log("$longitude");
              setState(() {
                _marker.add(Marker(
                    markerId: MarkerId('id-1'),
                    position: LatLng(latitude, longitude),
                    infoWindow: InfoWindow(title: "")));
                CameraPosition(target: LatLng(latitude, longitude), zoom: 10);
              });
            },
            onMapCreated: onMapCreated,
            markers: _marker,
            initialCameraPosition: CameraPosition(target: LatLng(22.7196, 75.8577), zoom: 20)),
      ),
    );
  }
}
