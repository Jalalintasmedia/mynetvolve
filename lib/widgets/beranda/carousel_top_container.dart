import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../core/constants.dart';
import '../../providers/banners_prov.dart';
import 'images_carousel.dart';

class CarouselTopContainer extends StatelessWidget {
  const CarouselTopContainer({
    Key? key,
    required this.context,
    required this.scanShowcaseKey,
    required this.notifShowcaseKey,
  }) : super(key: key);

  final BuildContext context;
  final GlobalKey<State<StatefulWidget>> scanShowcaseKey;
  final GlobalKey<State<StatefulWidget>> notifShowcaseKey;

  @override
  Widget build(BuildContext context) {
    late final _bannerFuture =
        Provider.of<BannerProvs>(context, listen: false).getCarouselBanners();
    return Stack(
      children: [
        FutureBuilder(
          future: _bannerFuture,
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              print('===== WAITING');
              return ImagesCarousel(
                height: MediaQuery.of(context).size.height * 0.25,
              );
            } else {
              if (dataSnapshot.error != null) {
                print('===== ERROR');
                return ImagesCarousel(
                  height: MediaQuery.of(context).size.height * 0.25,
                );
              } else {
                return Consumer<BannerProvs>(
                  builder: (ctx, bannerData, _) {
                    return ImagesCarousel(
                      height: MediaQuery.of(context).size.height * 0.25,
                      banners: bannerData.carouselBannerUrls,
                      urls: bannerData.carouselLinkUrls,
                    );
                  },
                );
              }
            }
          },
        ),
        // const Positioned(
        //   left: 0,
        //   child: BnetfitLogoTopLeft(),
        // ),
        Positioned(
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(
                // right: 20,
                // top: 20,
                ),
            child: Row(
              children: [
                // scanButton,
                // notifButton,
                Showcase(
                  key: scanShowcaseKey,
                  description: ToolTipString.SCAN_PEGAWAI,
                  child: IconButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(RouteNames.SCAN_QR_ROUTE),
                    icon: const ImageIcon(
                      AssetImage('assets/icons/qr-scan.png'),
                      color: Colors.white,
                    ),
                  ),
                ),
                Showcase(
                  key: notifShowcaseKey,
                  description: ToolTipString.NOTIFIKASI,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(RouteNames.PEMBERITAHUAN_ROUTE);
                    },
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 30,
                    ),
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.maximumDensity,
                      vertical: VisualDensity.maximumDensity,
                    ),
                    // constraints: BoxConstraints(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}