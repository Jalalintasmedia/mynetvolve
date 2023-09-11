import 'package:flutter/material.dart';

import '../widgets/auth/gradient_background.dart';
import '../widgets/netvolve_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(85),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: NetvolveLogo()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
