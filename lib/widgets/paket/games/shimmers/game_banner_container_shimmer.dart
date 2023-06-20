import 'package:flutter/material.dart';
import 'package:mynetvolve/widgets/loading/shimmer_widget.dart';

class GameBannerContainerShimmer extends StatelessWidget {
  const GameBannerContainerShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget.circular(
      width: double.infinity,
      height: 150,
      shapeBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
    );
  }
}
