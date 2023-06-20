import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../../../widgets/auth/auth_screen_template.dart';
import '../../../widgets/buttons/gradient_button.dart';

class SubmitKTPScreen extends StatefulWidget {
  final String namaLengkap;
  final String noHP;
  final String noKTP;
  final String alamatEmail;
  final String alamat;
  final double latitude;
  final double longitude;
  final String residentialStatus;
  final String residentialType;

  const SubmitKTPScreen({
    Key? key,
    required this.namaLengkap,
    required this.noHP,
    required this.noKTP,
    required this.alamatEmail,
    required this.alamat,
    required this.latitude,
    required this.longitude,
    required this.residentialStatus,
    required this.residentialType,
  }) : super(key: key);

  @override
  State<SubmitKTPScreen> createState() => _SubmitKTPScreenState();
}

class _SubmitKTPScreenState extends State<SubmitKTPScreen> {
  File? _pickedKTPImage;
  File? _pickedSelfieImage;
  var _showImageError = false;

  Future<void> _takeKTPPicture() async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    setState(() {
      _pickedKTPImage = File(image.path);
    });
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    _pickedKTPImage = await File(image.path).copy('${appDir.path}/$fileName');

    setState(() {
      _showImageError = false;
    });
  }

  Future<void> _takeSelfiePicture() async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    setState(() {
      _pickedSelfieImage = File(image.path);
    });
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    _pickedSelfieImage = await File(image.path).copy('${appDir.path}/$fileName');

    setState(() {
      _showImageError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreenTemplate(
      formWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Upload Dokumen',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
          ),
          const SizedBox(height: 25),
          takePicSection('KTP', _pickedKTPImage, _takeKTPPicture),
          const SizedBox(height: 25),
          takePicSection('Selfie dengan KTP', _pickedSelfieImage, _takeSelfiePicture),
          const SizedBox(height: 25),
          GradientButton(buttonHandle: (){}, text: 'Daftar'),
        ],
      ),
    );
  }

  Widget takePicSection(String title, File? image, Function()? takePicFunc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: takePicFunc,
            child: DottedBorder(
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: image == null
                    ? null
                    : Image.file(
                        image,
                        fit: BoxFit.cover,
                      ),
              ),
              color: Colors.white,
              strokeWidth: 2,
              dashPattern: [5, 5],
            ),
          ),
      ],
    );
  }
}
