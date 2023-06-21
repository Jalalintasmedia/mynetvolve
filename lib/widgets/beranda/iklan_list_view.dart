import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mynetvolve/screens/promo_detail_screen.dart';
import 'package:mynetvolve/widgets/loading/shimmer_widget.dart';
import 'package:provider/provider.dart';

import '../../providers/banners_prov.dart';

class IklanListView extends StatelessWidget {
  final BuildContext context;

  const IklanListView({
    Key? key,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final _bannersFuture = Provider.of<BannerProvs>(
      context,
      listen: false,
    ).getPromoBanners();
    return FutureBuilder(
      future: _bannersFuture,
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Expanded(
            child: ListView.separated(
              // physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (ctx, i) => const SizedBox(height: 10),
              itemCount: 2,
              itemBuilder: (ctx, i) => ShimmerWidget.circular(
                width: double.infinity,
                height: 180,
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          );
        } else {
          if (dataSnapshot.error != null) {
            return Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade400,
              ),
            );
          } else {
            return Consumer<BannerProvs>(
              builder: (ctx, promoData, _) {
                return Expanded(
                  child: ListView.separated(
                    // physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (ctx, i) => const SizedBox(height: 10),
                    itemCount: promoData.promoBannerImages!.length,
                    itemBuilder: (ctx, i) {
                      return Column(
                        children: [
                          iklanWidget(
                            promoData.promoBannerImages![i],
                            promoData.promoBanners![i].titleInd,
                            promoData.promoBanners![i].descriptionInd,
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            );
          }
        }
      },
    );
  }

  Widget iklanWidget(
    String imageUrl,
    String title,
    String description,
  ) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PromoDetailScreen(
            title: title,
            description: description,
            image: imageUrl,
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 180,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (ctx, url) => ShimmerWidget.circular(
              width: double.infinity,
              height: 180,
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            errorWidget: (context, exception, stackTrace) {
              return Container(
                color: Colors.grey.shade400,
              );
            },
          ),
        ),
      ),
    );
  }
}
