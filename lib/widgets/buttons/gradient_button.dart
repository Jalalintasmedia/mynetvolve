import 'package:flutter/material.dart';
import 'package:mynetvolve/core/palette.dart';

import 'rounded_button.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback? buttonHandle;
  final String text;
  final double? height;
  final double? width;
  final bool useElevation;
  final bool useBorder;
  final List<Color>? gradientColors;
  final Alignment? begin;
  final Alignment? end;

  const GradientButton({
    required this.buttonHandle,
    required this.text,
    this.height,
    this.width,
    this.useElevation = true,
    this.useBorder = true,
    this.gradientColors,
    this.begin,
    this.end,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(25);

    return PhysicalModel(
      elevation: useElevation ? 8 : 0,
      color: Colors.black54,
      borderRadius: borderRadius,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors ??
                [
                  // Color.fromRGBO(0, 171, 247, 1),
                  // Color.fromRGBO(0, 90, 253, 1),
                  Palette.kToDark,
                  Palette.kToDark.shade300
                ],
            begin: begin ?? Alignment.topCenter,
            end: end ?? Alignment.bottomCenter,
            stops: [0.2, 1],
          ),
          borderRadius: borderRadius,
        ),
        child: RoundedButton(
          onPressed: buttonHandle,
          text: text,
          useSide: useBorder,
          textColor: Colors.white,
          bgColor: Colors.transparent,
          useShadow: false,
        ),
      ),
    );
  }
}
