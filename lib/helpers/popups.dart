import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/customer_profile.dart';
import 'custom_dialog.dart';

void showEmailVerificationPopUp(BuildContext context) async {
  final isEmailVerified = Provider.of<CustomerProfile>(context, listen: false)
      .customer!
      .emailVerified;
  var prefs = await SharedPreferences.getInstance();

  if (prefs.getBool('isDisplayed') == false) {
    if (isEmailVerified != 'Y') {
      await _showPopup(context);
    }
    await prefs.setBool('isDisplayed', true);
  }
  // _showPopup();
}

_showPopup(BuildContext context) async {
  var prefs = await SharedPreferences.getInstance();
  showCustomDialog(
    context: context,
    title: 'Verifikasi',
    content:
        'Akun belum terverifikasi\nSilakan lakukan verifikasi akun anda pada menu profile -> info akun',
  );
  await prefs.setBool('isDisplayed', true);
}
