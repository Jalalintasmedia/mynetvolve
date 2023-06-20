import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mynetvolve/widgets/profile/office_list_tile.dart';

import '../../../models/office_locations.dart';

class PetaScreen extends StatefulWidget {
  const PetaScreen({
    Key? key,
    required this.getCurrentLocation,
  }) : super(key: key);

  final Future<Position> Function() getCurrentLocation;

  @override
  State<PetaScreen> createState() => _PetaScreenState();
}

class _PetaScreenState extends State<PetaScreen> {
  double _latitude = 0;
  double _longitude = 0;
  var errMsg = '';
  var nearestOffice = OFFICE_LOCATIONS[0];
  double _distanceinKm = 0;

  final Completer<GoogleMapController> _mapController = Completer();
  static final CameraPosition _kGoogle = CameraPosition(
    target: LatLng(OFFICE_LOCATIONS[0].latitude, OFFICE_LOCATIONS[0].longitude),
    zoom: 14.4746,
  );
  final List<Marker> _markers = <Marker>[];

  @override
  void initState() {
    widget.getCurrentLocation().then((value) async {
      _getNearestOffice(value.latitude, value.longitude);

      setState(() {
        _latitude = nearestOffice.latitude;
        _longitude = nearestOffice.longitude;
      });

      final latlng = LatLng(_latitude, _longitude);
      _markers.add(
        Marker(
          markerId: const MarkerId('1'),
          position: latlng,
          infoWindow: InfoWindow(title: nearestOffice.officeName),
        ),
      );
      final cameraPosition = CameraPosition(
        target: latlng,
        zoom: 15,
      );
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      controller.dispose();
    });
    super.initState();
  }

  void _getNearestOffice(double lat, double lng) {
    var nearestLocDistance = Geolocator.distanceBetween(
      lat,
      lng,
      OFFICE_LOCATIONS[0].latitude,
      OFFICE_LOCATIONS[0].longitude,
    );
    var chosenLoc = OFFICE_LOCATIONS[0];

    for (var loc in OFFICE_LOCATIONS) {
      final distance = Geolocator.distanceBetween(
        lat,
        lng,
        loc.latitude,
        loc.longitude,
      );
      if (distance <= nearestLocDistance) {
        nearestLocDistance = distance;
        chosenLoc = loc;
        print('===== NEAREST LOCATION: ${chosenLoc.officeName} $distance');
      }
    }
    setState(() {
      nearestOffice = chosenLoc;
      _distanceinKm = (nearestLocDistance / 1000);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          // height: 200,
          child: GoogleMap(
            initialCameraPosition: _kGoogle,
            markers: Set<Marker>.of(_markers),
            mapType: MapType.normal,
            myLocationEnabled: true,
            compassEnabled: true,
            onMapCreated: (controller) {
              _mapController.complete(controller);
            },
            myLocationButtonEnabled: false,
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Cabang Terdekat:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    OfficeListTile(
                      officeName: nearestOffice.officeName,
                      address: nearestOffice.address,
                      latitude: nearestOffice.latitude,
                      longitude: nearestOffice.longitude,
                      distance: _distanceinKm,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
