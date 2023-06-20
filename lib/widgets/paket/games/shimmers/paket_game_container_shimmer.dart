import 'package:flutter/material.dart';

import '../../../loading/shimmer_widget.dart';
import 'game_pic_tile_shimmer.dart';

class PaketGameContainerShimmer extends StatelessWidget {
  const PaketGameContainerShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 2),
                    ShimmerWidget.rectangular(height: 15, width: 70),
                    SizedBox(height: 6),
                    ShimmerWidget.rectangular(height: 15, width: 110),
                  ],
                ),
                ShimmerWidget.circular(
                  width: 130,
                  height: 38,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            const ShimmerWidget.rectangular(height: 13, width: 90),
            const SizedBox(height: 8),
            SizedBox(
              height: 50,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (ctx, i) => const SizedBox(width: 5),
                itemCount: 5,
                itemBuilder: (ctx, i) => const GamePicTileShimmer(height: 50),
              ),
            ),
            const SizedBox(height: 11),
            const ShimmerWidget.rectangular(height: 13, width: 90),
            const SizedBox(height: 6),
            SizedBox(
              height: 50,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (ctx, i) => const SizedBox(width: 5),
                itemCount: 5,
                itemBuilder: (ctx, i) => const GamePicTileShimmer(height: 50),
              ),
            ),
            // const SizedBox(height: 1),
          ],
        ),
      ),
    );
  }
}
