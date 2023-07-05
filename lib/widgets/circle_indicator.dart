import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CircleIndicator extends StatelessWidget {
  const CircleIndicator({
    Key? key,
    required this.activeIndex,
    required this.imagesLength,
    required this.activeDotColor,
    required this.dotColor,
  }) : super(key: key);

  final int activeIndex;
  final int imagesLength;
  final Color activeDotColor;
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: imagesLength,
      effect: const ExpandingDotsEffect(
        dotColor: Colors.white,
        activeDotColor: Colors.white,
        dotHeight: 8,
        dotWidth: 8,
        spacing: 6,
      ),
    );
  }
}
