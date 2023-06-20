import 'package:flutter/material.dart';

import '../../../loading/shimmer_widget.dart';
import 'game_pic_tile_shimmer.dart';

class ClaimGameTileShimmer extends StatelessWidget {
  const ClaimGameTileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GamePicTileShimmer(
                    height: 80,
                    width: 80,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        ShimmerWidget.rectangular(
                          height: 16,
                          width: 150,
                        ),
                        SizedBox(height: 3),
                        ShimmerWidget.rectangular(
                          height: 12,
                          width: 100,
                        ),
                        SizedBox(height: 10),
                        ShimmerWidget.rectangular(height: 14),
                        SizedBox(height: 3),
                        ShimmerWidget.rectangular(
                          height: 14,
                          width: 130,
                        ),
                      ],
                    ),
                  ),
                  ShimmerWidget.circular(
                    width: 90,
                    height: 38,
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
