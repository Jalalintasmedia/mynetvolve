import 'package:flutter/material.dart';

import '../widgets/auth/gradient_background.dart';
import '../widgets/netvolve_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(85),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                NetvolveLogo(padding: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
