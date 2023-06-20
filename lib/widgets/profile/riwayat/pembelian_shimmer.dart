import 'package:flutter/material.dart';

import '../../loading/shimmer_widget.dart';

class PembelianShimmer extends StatelessWidget {
  const PembelianShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          ShimmerWidget.rectangular(
            height: 12,
            width: 100,
          ),
          SizedBox(height: 6),
          ShimmerWidget.rectangular(
            height: 12,
            width: 250,
          ),
          SizedBox(height: 6),
          ShimmerWidget.rectangular(
            height: 12,
            width: 120,
          ),
          SizedBox(height: 6),
          ShimmerWidget.rectangular(
            height: 12,
            width: 130,
          ),
          SizedBox(height: 6),
        ],
      ),
    );
  }
}
