import 'package:flutter/material.dart';
import 'package:mynetvolve/widgets/loading/shimmer_widget.dart';

class GamePicTileShimmer extends StatelessWidget {
  const GamePicTileShimmer({
    Key? key,
    this.width = 80,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget.circular(
      width: width,
      height: height,
      shapeBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
