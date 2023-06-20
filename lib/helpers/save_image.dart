import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Uint8List convertBase64(String bas64String) {
  return base64.decode(bas64String.replaceAll(RegExp(r'\s+'), ''));
}

void saveImage({
  required Uint8List base64String,
  required String fileName,
  String? fileType,
}) async {
  final appDir = await getTemporaryDirectory();
  var type = fileType ?? 'jpg';
  File file = File('${appDir.path}/$fileName.$type');

  await file.writeAsBytes(base64String);
  GallerySaver.saveImage(file.path);
}

void shareImage({
  required Uint8List base64String,
  required String fileName,
  String? fileType,
}) async {
  final appDir = await getTemporaryDirectory();
  var type = fileType ?? 'jpg';
  File file = File('${appDir.path}/$fileName.$type');
  XFile xFile = XFile(file.path);

  await file.writeAsBytes(base64String);
  // await Share.share(file.path);
  await Share.shareXFiles(
    [xFile],
    text: 'Share QR Code',
  );
  // await Share.shareFiles(
  //   [file.path],
  //   mimeTypes: ['images/$type'],
  //   text: 'Share QR Code',
  // );
  // Share.shareXFiles([], mim)
}
