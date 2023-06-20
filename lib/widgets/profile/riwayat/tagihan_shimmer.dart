import 'package:flutter/material.dart';

import '../../loading/shimmer_widget.dart';

class TagihanShimmer extends StatelessWidget {
  const TagihanShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ShimmerWidget.rectangular(
                height: 15,
                width: 50,
              ),
              SizedBox(height: 4),
              ShimmerWidget.rectangular(
                height: 12,
                width: 100,
              ),
            ],
          ),
          const ShimmerWidget.rectangular(
            height: 12,
            width: 110,
          ),
        ],
      ),
    );
  }
}
