import 'package:flutter/material.dart';
import 'package:mynetvolve/core/constants.dart';
import 'package:mynetvolve/core/palette.dart';
import 'package:mynetvolve/helpers/custom_dialog.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';
import 'package:mynetvolve/widgets/paket/addon_grid_view.dart';
import 'package:provider/provider.dart';

import '../../helpers/check_if_tablet.dart';
import '../../widgets/paket/paket_aktif_card.dart';
import '../../widgets/paket/paket_card_button.dart';
import '../../widgets/paket_info_widget.dart';
import '../../providers/products.dart';

class PaketScreen extends StatelessWidget {
  const PaketScreen({Key? key}) : super(key: key);

  void fiturTidakTersedia(BuildContext context) {
    showCustomDialog(
      context: context,
      title: 'Fitur Tidak Tersedia',
      content:
          'Mohon maaf saat ini fitur belum tersedia, silahkan menghubungi operator kami.',
    );
  }

  @override
  Widget build(BuildContext context) {
    late final _productsFuture =
        Provider.of<Products>(context, listen: false).getCustProducts();

    final List<Map<String, dynamic>> addOnList = [
      {'name': 'Games', 'routeName': RouteNames.GAMES_ROUTE},
      {'name': 'IPTV', 'routeName': ''},
      {'name': 'Spotify', 'routeName': ''},
      {'name': 'Netflix', 'routeName': ''},
      {'name': 'YT Music', 'routeName': ''},
      {'name': 'HBO', 'routeName': ''},
    ];

    return Scaffold(
      appBar: const GradientAppBar(title: 'Paket'),
      body: FutureBuilder(
        future: _productsFuture,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              return const Center(
                child: Text('an error has occured'),
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Paket Aktif',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const PaketAktifCard(),
                      const Divider(color: Colors.grey),
                      const Text(
                        'Paket Addon',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      AddonGridView(list: addOnList),
                    ],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
