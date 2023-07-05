import 'package:flutter/material.dart';
import 'package:mynetvolve/core/palette.dart';
import 'package:mynetvolve/widgets/beranda/carousel_top_container.dart';

import '../../widgets/beranda/beranda_app_bar.dart';
import '../../widgets/beranda/internet_package_container.dart';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({Key? key}) : super(key: key);

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const BerandaAppBar(),
                  const SizedBox(height: 20),
                  const CarouselTopContainer(),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          child: InkWell(
                            onTap: (){},
                            borderRadius: BorderRadius.circular(15),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.wifi, color: Palette.kToDark),
                                  SizedBox(width: 5),
                                  Text(
                                    'Speed Test Your Internet',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        InternetPackageContainer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
