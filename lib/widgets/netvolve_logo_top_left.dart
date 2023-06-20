import 'package:flutter/material.dart';

class NetvolveLogoTopLeft extends StatelessWidget {
  const NetvolveLogoTopLeft({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(left: 20, right: 28, top: 0, bottom: 0),
      width: 150,
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Image.asset(
        'assets/images/netvolve_main.png',
        // scale: 0.8,
        fit: BoxFit.contain,
      ),
    );
  }
}