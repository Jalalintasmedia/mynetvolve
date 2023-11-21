// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mynetvolve/helpers/popups.dart';
import 'package:mynetvolve/providers/customer_profile.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';

import '../../core/palette.dart';
import '../../widgets/beranda/carousel_top_container.dart';
import '../../widgets/beranda/my_packages_widget.dart';
import '../../providers/products.dart';
import '../../widgets/beranda/beranda_app_bar.dart';
import '../../widgets/beranda/internet_package_container.dart';

class BerandaScreen extends StatefulWidget {
  static const PREFERENCES_IS_FIRST_LAUNCH_STRING =
      "PREFERENCES_IS_FIRST_LAUNCH_STRING";
  const BerandaScreen({Key? key}) : super(key: key);

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  late final _productsFuture = Provider.of<Products>(
    context,
    listen: false,
  ).getCustProducts();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showEmailVerificationPopUp(context);
    });
  }

  Future<void> _refresh() {
    return Future(() async {
      print('===== REFRESHED');
      await Provider.of<CustomerProfile>(
        context,
        listen: false,
      ).getUserProfile();
      await Provider.of<Products>(
        context,
        listen: false,
      ).getCustProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const BerandaAppBar(),
      body: UpgradeAlert(
        upgrader: Upgrader(
            durationUntilAlertAgain: const Duration(days: 1),
            dialogStyle: Platform.isIOS
                ? UpgradeDialogStyle.cupertino
                : UpgradeDialogStyle.material),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Palette.kToDark.shade400,
                    Palette.kToLight,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            SafeArea(
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      // const BerandaAppBar(),
                      const SizedBox(height: 20),
                      const CarouselTopContainer(),
                      const SizedBox(height: 20),
                      FutureBuilder(
                          future: _productsFuture,
                          builder: (ctx, dataSnapshot) {
                            if (dataSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (dataSnapshot.hasError) {
                              return Text(
                                  'An error occured: ${dataSnapshot.error}');
                            }
                            return const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  InternetPackageContainer(),
                                  SizedBox(height: 15),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: MyPackagesWidget(),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
