import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mynetvolve/screens/profile/bantuan/daftar_kantor_screen.dart';
import 'package:mynetvolve/screens/profile/bantuan/peta_screen.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';
import 'package:mynetvolve/widgets/profile/profile_gradient_container.dart';

import '../../../core/palette.dart';

class KantorScreen extends StatefulWidget {
  const KantorScreen({Key? key}) : super(key: key);

  @override
  State<KantorScreen> createState() => _KantorScreenState();
}

class _KantorScreenState extends State<KantorScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Future<Position> getCurrentLocation() async {
    await Geolocator.getCurrentPosition()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(title: 'Kantor Netvolve'),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            color: Palette.kToDark.shade300,
            // decoration: const BoxDecoration(
            //   gradient: LinearGradient(
            //     colors: [
            //       ThemeColors.accentColor,
            //       Palette.kToDark,
            //     ],
            //   ),
            // ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorWeight: 4,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              tabs: const [
                Tab(text: 'Peta'),
                Tab(text: 'Daftar'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                PetaScreen(getCurrentLocation: getCurrentLocation),
                DaftarKantorScreen(getCurrentLocation: getCurrentLocation),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
