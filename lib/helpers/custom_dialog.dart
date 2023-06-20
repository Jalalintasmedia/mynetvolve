import 'package:flutter/material.dart';

import '../core/palette.dart';
import '../widgets/buttons/gradient_button.dart';

void showCustomDialog({
  required BuildContext context,
  required String title,
  required String content,
  Widget? customButton,
}) {
  final width = MediaQuery.of(context).size.width / 1.2;
  showDialog(
    context: context,
    builder: (ctx) => Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: width,
        // height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: const BoxDecoration(
                color: Palette.kToDark,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 20),
            customButton ?? GradientButton(
              buttonHandle: () => Navigator.of(context).pop(),
              text: 'Ok',
              height: 40,
              width: 80,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
}

void showErrMsg(BuildContext context, String errMsg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errMsg),
      backgroundColor: Colors.red.shade700,
      duration: const Duration(seconds: 3),
    ),
  );
}

void showSuccessMsg(BuildContext context, String errMsg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errMsg),
      backgroundColor: Colors.green.shade700,
      duration: const Duration(seconds: 3),
    ),
  );
}

void waitDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => const Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    ),
  );
}
