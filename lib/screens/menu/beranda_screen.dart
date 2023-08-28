// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:mynetvolve/helpers/popups.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const BerandaAppBar(),
      body: Stack(
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
            child: SingleChildScrollView(
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
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: const [
                              // Material(
                              //   color: Colors.white,
                              //   borderRadius: BorderRadius.circular(15),
                              //   child: InkWell(
                              //     onTap: () => Navigator.of(context).pushNamed(RouteNames.SPEED_TEST_ROUTE),
                              //     borderRadius: BorderRadius.circular(15),
                              //     child: Padding(
                              //       padding: const EdgeInsets.symmetric(
                              //         horizontal: 16,
                              //         vertical: 12,
                              //       ),
                              //       child: Row(
                              //         mainAxisAlignment: MainAxisAlignment.center,
                              //         children: const [
                              //           Icon(Icons.wifi, color: Palette.kToDark),
                              //           SizedBox(width: 5),
                              //           Text(
                              //             'Speed Test Your Internet',
                              //             style: TextStyle(fontWeight: FontWeight.bold),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(height: 15),
                              InternetPackageContainer(),
                              SizedBox(height: 15),
                              MyPackagesWidget(),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
