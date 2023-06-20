import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:mynetvolve/helpers/call_cs.dart';
import 'package:mynetvolve/helpers/custom_dialog.dart';
import 'package:mynetvolve/screens/scan_code/scan_qr_result_screen.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';

import '../../widgets/buttons/gradient_button.dart';

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({Key? key}) : super(key: key);

  @override
  State<ScanQRScreen> createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  final cameraController = MobileScannerController();
  var _screenOpened = false;

  void _foundBarcode(Barcode barcode, MobileScannerArguments? args) {
    if (!_screenOpened) {
      final code = barcode.rawValue ?? '---';
      print('=== Barcode found! $code');
      _screenOpened = true;
      final isBarcodeValid = code.contains('jlm.net.id/dt_team');

      if (!isBarcodeValid) {
        // Navigator.of(context).pop();
        showCustomDialog(
          context: context,
          title: 'Peringatan!',
          content: 'Petugas tidak terdaftar\nLaporkan?',
          customButton: GradientButton(
            buttonHandle: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              callCS();
            },
            text: 'Kontak Kami',
            height: 40,
            width: 200,
          ),
        );
        return;
      }
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => ScanQRResultScreen(
            value: code,
            screenClosed: _screenWasClosed,
          ),
        ),
      );
    }
  }

  void _screenWasClosed() {
    _screenOpened = false;
  }

  @override
  Widget build(BuildContext context) {
    print('=== SCREEN OPENED? $_screenOpened');
    return Scaffold(
      appBar: GradientAppBar(
        title: 'Scan QR Code Pegawai Bnetfit',
        actions: [
          IconButton(
            // color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (ctx, state, _) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (ctx, state, _) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        allowDuplicates: true,
        controller: cameraController,
        onDetect: _foundBarcode,
      ),
    );
  }
}
