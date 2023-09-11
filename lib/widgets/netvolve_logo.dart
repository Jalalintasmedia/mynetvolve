import 'package:flutter/material.dart';

class NetvolveLogo extends StatelessWidget {
  const NetvolveLogo({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 60,
      child: Image(
        image: AssetImage('assets/images/netvolve_white.png'),
      ),
    );
  }
}
