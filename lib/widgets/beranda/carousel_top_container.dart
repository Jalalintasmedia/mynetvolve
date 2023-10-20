import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/banners_prov.dart';
import 'images_carousel.dart';

class CarouselTopContainer extends StatelessWidget {
  const CarouselTopContainer({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    late final _bannerFuture =
        Provider.of<BannerProvs>(context, listen: false).getCarouselBanners();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: FutureBuilder(
        future: _bannerFuture,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            // print('===== WAITING');
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
    );
  }
}