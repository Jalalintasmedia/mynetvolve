import 'package:flutter/material.dart';

import '../../loading/shimmer_widget.dart';

class AktivitasShimmer extends StatelessWidget {
  const AktivitasShimmer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          ShimmerWidget.rectangular(
            height: 14,
            width: 170,
          ),
          SizedBox(height: 10),
          ShimmerWidget.rectangular(
            height: 14,
            width: 140,
          ),
          SizedBox(height: 6),
          ShimmerWidget.rectangular(
            height: 12,
            width: 70,
          ),
          SizedBox(height: 6),
        ],
      ),
    );
  }
}
