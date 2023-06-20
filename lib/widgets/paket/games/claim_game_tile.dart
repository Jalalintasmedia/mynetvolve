import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mynetvolve/widgets/buttons/gradient_button.dart';
import 'package:mynetvolve/widgets/paket/games/shimmers/game_pic_tile_shimmer.dart';

class ClaimGameTile extends StatelessWidget {
  const ClaimGameTile({
    Key? key,
    required this.gameName,
    required this.info,
    required this.imageUrl,
    required this.description,
    required this.isClaim,
    required this.onPressed,
  }) : super(key: key);

  final String gameName;
  final String info;
  final String imageUrl;
  final String description;
  final bool isClaim;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey
            // width: 2
            ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                    errorWidget: (ctx, exception, stackTrace) =>
                        const GamePicTileShimmer(
                      height: 80,
                      width: 80,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        gameName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        info,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                      Html(data: description),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GradientButton(
            buttonHandle: onPressed,
            text: isClaim ? 'See\nVoucher' : 'Claim',
            height: isClaim ? 45 : 35,
            width: 95,
            useElevation: false,
          ),
        ],
      ),
    );
  }
}
