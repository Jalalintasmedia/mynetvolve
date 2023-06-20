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
      effect: SlideEffect(
        activeDotColor: activeDotColor,
        dotColor: dotColor,
        dotHeight: 12,
        dotWidth: 12,
        spacing: 12,
      ),
    );
  }
}
