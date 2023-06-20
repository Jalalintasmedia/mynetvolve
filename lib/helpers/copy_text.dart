import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void copyText({
  required String copiedData,
  String? copyType,
}) async {
  try {
    await Clipboard.setData(
      ClipboardData(text: copiedData),
    );
    Fluttertoast.showToast(
      msg: copyType == null
          ? 'Berhasil Disalin!'
          : '$copyType Berhasil Disalin!',
      backgroundColor: Colors.black87,
    );
  } catch (e) {
    return;
  }
}
