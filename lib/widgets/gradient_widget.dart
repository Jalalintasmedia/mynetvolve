import 'package:flutter/material.dart';

import '../core/palette.dart';

class GradientWidget extends StatelessWidget {
  const GradientWidget({
    Key? key,
    required this.child,
    this.shaderCallback,
  }) : super(key: key);

  final Widget child;
  final Shader Function(Rect)? shaderCallback;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.cover,
      child: ShaderMask(
        shaderCallback: shaderCallback ?? (bounds) {
          return const LinearGradient(
            colors: [
              Palette.kToDark,
              ThemeColors.accentColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(bounds);
        },
        child: child,
      ),
    );
  }
}
