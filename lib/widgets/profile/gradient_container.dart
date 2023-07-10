import 'package:flutter/material.dart';
import 'package:mynetvolve/core/palette.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    Key? key,
    required this.context,
    required this.height,
    required this.borderRadius,
    required this.child,
  }) : super(key: key);

  final BuildContext context;
  final double height;
  final BorderRadius borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              gradient: LinearGradient(
                colors: [Palette.kToDark, Palette.kToDark.shade400],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: LayoutBuilder(builder: (ctx, constraints) {
                return SizedBox(
                  // width: constraints.maxWidth * (3 / 4),
                  // height: 100,
                  child: Image.asset(
                    'assets/images/netvolve-icon-quarter.png',
                    opacity: const AlwaysStoppedAnimation(.7),
                  ),
                );
              }),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
