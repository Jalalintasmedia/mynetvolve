import 'package:flutter/material.dart';

import '../../core/palette.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool useSide;
  final bool useShadow;
  final Color? textColor;
  final Color? bgColor;
  final String? logo;
  final String? fontFamily;
  final double? fontSize;

  const RoundedButton({
    required this.onPressed,
    required this.text,
    required this.useSide,
    required this.useShadow,
    this.bgColor,
    this.textColor,
    this.logo,
    this.fontFamily,
    this.fontSize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(25);

    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (logo != null)
            FittedBox(
              fit: BoxFit.cover,
              child: ImageIcon(
                AssetImage(logo!),
              ),
            ),
          if (logo != null)
            const SizedBox(
              width: 8,
            ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: fontSize ?? 15,
              // fontFamily: fontFamily ?? 'Gotham',
            ),
          ),
        ],
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(bgColor ?? Palette.kToDark),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: useSide
                ? const BorderSide(
                    color: Color.fromRGBO(0, 209, 255, 1),
                  )
                : BorderSide.none,
          ),
        ),
        shadowColor: MaterialStateProperty.all(
            useShadow ? Colors.black : Colors.transparent),
        elevation: MaterialStateProperty.all(
          useShadow ? 10 : 0,
        ),
      ),
    );
  }
}
