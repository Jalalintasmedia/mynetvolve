import 'package:flutter/material.dart';

import '../../widgets/netvolve_logo.dart';
import '../../widgets/auth/gradient_background.dart';
import '../../widgets/buttons/rounded_button.dart';
import '../../core/constants.dart';

class PickAuthScreen extends StatelessWidget {
  const PickAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GradientBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(85),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const NetvolveLogo(),
                  const SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: RoundedButton(
                      onPressed: () => Navigator.of(context)
                          .pushNamed(RouteNames.LOGIN_ROUTE),
                      text: 'Masuk',
                      useSide: false,
                      bgColor: Colors.white,
                      textColor: Colors.black,
                      useShadow: true,
                    ),
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // GradientButton(
                  //   buttonHandle: () => Navigator.of(context)
                  //       .pushNamed(RouteNames.REGISTER_ROUTE),
                  //   text: 'Daftar',
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
