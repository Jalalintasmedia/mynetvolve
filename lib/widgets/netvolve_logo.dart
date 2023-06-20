import 'package:flutter/material.dart';

class NetvolveLogo extends StatelessWidget {
  final double padding;

  const NetvolveLogo({
    Key? key,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: const Image(
        image: AssetImage('assets/images/netvolve_white.png'),
      ),
    );
  }
}
