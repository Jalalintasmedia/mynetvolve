import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginFAB extends StatelessWidget {
  LoginFAB({
    Key? key,
    // required this.checkFingerprintStatus,
    required this.fingerprintLogin,
    required this.isFingerPrintEnabled,
  }) : super(key: key);

  // final void Function()? checkFingerprintStatus;
  final void Function()? fingerprintLogin;
  bool isFingerPrintEnabled;

  Future<void> _checkFingerprintStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      isFingerPrintEnabled = prefs.getBool('activate_fingerprint')!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(left: 30),
          //   child: FloatingActionButton(
          //     onPressed: _callCS,
          //     child: const ImageIcon(
          //       AssetImage('assets/icons/customer-service.png'),
          //     ),
          //   ),
          // ),
          fingerprintButton(),
        ],
      ),
    );
  }

  FutureBuilder<void> fingerprintButton() {
    return FutureBuilder(
      future: _checkFingerprintStatus(),
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          if (dataSnapshot.error != null) {
            return Container();
          } else {
            if (isFingerPrintEnabled) {
              return FloatingActionButton(
                onPressed: fingerprintLogin,
                child: const ImageIcon(
                  AssetImage('assets/icons/fingerprint-scan.png'),
                ),
              );
            } else {
              return Container();
            }
          }
        }
      },
    );
  }
}
