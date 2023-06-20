import 'package:flutter/material.dart';
import 'package:mynetvolve/core/palette.dart';
import 'package:mynetvolve/widgets/paket/games/shimmers/game_detail_tile_shimmer.dart';

import 'game_pic_tile.dart';

class GameDetailTile extends StatelessWidget {
  const GameDetailTile({
    Key? key,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? ThemeColors.accentColor : Colors.grey,
                width: isSelected ? 2 : 1,
                // width: 2
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const GamePicTile(height: 50),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '10 Diamond',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '20 Combo',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.add, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Row(
                    children: const [
                      GamePicTile(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // const Positioned(
        //   top: 5,
        //   right: 5,
        //   child: Icon(Icons.favorite_border_outlined),
        // ),
      ],
    );
  }
}
