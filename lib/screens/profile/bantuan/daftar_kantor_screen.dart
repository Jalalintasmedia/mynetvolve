import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mynetvolve/models/office_locations.dart';

import '../../../widgets/profile/office_list_tile.dart';

class DaftarKantorScreen extends StatefulWidget {
  const DaftarKantorScreen({
    Key? key,
    required this.getCurrentLocation,
  }) : super(key: key);

  final Future<Position> Function() getCurrentLocation;

  @override
  State<DaftarKantorScreen> createState() => _DaftarKantorScreenState();
}

class _DaftarKantorScreenState extends State<DaftarKantorScreen> {
  Map<double, OfficeLocation> mapWithDistance = {
    -1: OFFICE_LOCATIONS[0],
    -2: OFFICE_LOCATIONS[1],
    -3: OFFICE_LOCATIONS[2],
    -4: OFFICE_LOCATIONS[3],
    -5: OFFICE_LOCATIONS[4],
    -6: OFFICE_LOCATIONS[5],
    -7: OFFICE_LOCATIONS[6],
    -8: OFFICE_LOCATIONS[7],
  };
  @override
  void initState() {
    widget.getCurrentLocation().then((value) async {
      for (var loc in OFFICE_LOCATIONS) {
        final distance = Geolocator.distanceBetween(
          value.latitude,
          value.longitude,
          loc.latitude,
          loc.longitude,
        );
        print('===== ${loc.officeName}: ${distance / 1000} KM');
        final map = {distance / 1000: loc};
        setState(() {
          mapWithDistance.removeWhere((key, value) => value == loc);
          mapWithDistance.addAll(map);
        });
      }
      var sortedByKeyMap = Map.fromEntries(
          mapWithDistance.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));
      mapWithDistance = sortedByKeyMap;
      print('===== $mapWithDistance');
      print('===== ${mapWithDistance.length}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: mapWithDistance.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: mapWithDistance.length,
              separatorBuilder: (ctx, i) => const Divider(color: Colors.grey),
              itemBuilder: (ctx, i) {
                final distance = mapWithDistance.keys.elementAt(i);
                final location = mapWithDistance[distance]!;
                return OfficeListTile(
                  officeName: location.officeName,
                  address: location.address,
                  latitude: location.latitude,
                  longitude: location.longitude,
                  distance: distance < 0 ? null : distance,
                );
              },
            ),
    );
  }
}
