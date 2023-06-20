import 'package:flutter/material.dart';

import '../../../loading/shimmer_widget.dart';
import 'game_pic_tile_shimmer.dart';

class GameDetailTileShimmer extends StatelessWidget {
  const GameDetailTileShimmer({Key? key}) : super(key: key);

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
          children: [
            Expanded(
              child: Row(
                children: [
                  const GamePicTileShimmer(height: 50),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        ShimmerWidget.rectangular(
                          height: 12,
                          width: 70,
                        ),
                        SizedBox(height: 3),
                        ShimmerWidget.rectangular(
                          height: 12,
                          width: 60,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.add, color: Colors.grey),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                children: const [
                  GamePicTileShimmer(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
