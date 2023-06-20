import 'package:flutter/material.dart';
import 'package:mynetvolve/widgets/auth/gradient_background.dart';
import 'package:mynetvolve/widgets/netvolve_logo.dart';

class AuthScreenTemplate extends StatelessWidget {
  final Widget formWidget;
  const AuthScreenTemplate({
    Key? key,
    required this.formWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
            child: Center(
              child: Container(
                // color: Colors.pink,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const NetvolveLogo(padding: 0),
                        const SizedBox(height: 40),
                        formWidget,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //   floatingActionButton: Visibility(
      //     visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
      //     child: const Text(
      //       'Butuh Bantuan?',
      //       style: TextStyle(
      //         color: Colors.white,
      //         fontSize: 12,
      //       ),
      //     ),
      //   ),
    );
  }
}
