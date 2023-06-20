import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../core/palette.dart';

class OfficeListTile extends StatelessWidget {
  const OfficeListTile({
    Key? key,
    required this.officeName,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.distance,
  }) : super(key: key);

  final String officeName;
  final String address;
  final double latitude;
  final double longitude;
  final double? distance;

  @override
  Widget build(BuildContext context) {
    void openMap(double latitude, double longitude) {
      MapsLauncher.launchCoordinates(latitude, longitude);
    }

    return ListTile(
      title: Text(
        officeName,
        style: const TextStyle(fontSize: 15),
      ),
      subtitle: Text(
        address,
        style: const TextStyle(fontSize: 12),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => openMap(
              latitude,
              longitude,
            ),
            icon: const Icon(
              Icons.directions,
              color: Palette.kToDark,
            ),
            padding: const EdgeInsets.all(0),
            constraints: const BoxConstraints(),
          ),
          distance != null
              ? Text(
                  '${distance!.toStringAsFixed(2)} KM',
                  style: const TextStyle(fontSize: 10),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
