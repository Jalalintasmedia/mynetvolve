import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mynetvolve/screens/auth/reset_password/input_new_password.dart';
import 'package:mynetvolve/widgets/buttons/gradient_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../widgets/auth/gradient_background.dart';

class OtpResetPasswordScreen extends StatefulWidget {
  const OtpResetPasswordScreen({
    Key? key,
    required this.tAccountId,
    required this.email,
    required this.pin,
  }) : super(key: key);

  final String tAccountId;
  final String email;
  final String pin;

  @override
  State<OtpResetPasswordScreen> createState() => _OtpResetPasswordScreenState();
}

class _OtpResetPasswordScreenState extends State<OtpResetPasswordScreen> {
  final errorController = StreamController<ErrorAnimationType>();
  var _inputPin = '';
  var _isPinWrong = false;

  void _checkPin() {
    if (_inputPin == widget.pin) {
      setState(() {
        _isPinWrong = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => InputNewPassword(
            tAccountId: widget.tAccountId,
          ),
        ),
      );
    } else {
      errorController.add(ErrorAnimationType.shake);
      setState(() {
        _isPinWrong = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Stack(
          children: [
            Container(
              color: Colors.black54,
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text(
                          'Kode Verifikasi',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Kami telah mengirimkan kode untuk verifikasi ke email ${widget.email}\nMohon masukkan kode yang Anda terima',
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 40),
                        PinCodeTextField(
                          appContext: context,
                          length: 4,
                          keyboardType: TextInputType.number,
                          useHapticFeedback: true,
                          hapticFeedbackTypes: HapticFeedbackTypes.heavy,
                          animationType: AnimationType.fade,
                          errorAnimationController: errorController,
                          textStyle: const TextStyle(color: Colors.white),
                          pinTheme: PinTheme(
                              shape: PinCodeFieldShape.circle,
                              selectedColor: Colors.white,
                              inactiveColor: Colors.white,
                              activeColor: Colors.white,
                              errorBorderColor: Colors.red.shade700,
                              fieldOuterPadding: const EdgeInsets.all(5),
                              fieldWidth: 50,
                              fieldHeight: 50,
                              selectedFillColor: Colors.amber),
                          onChanged: (value) {
                            _inputPin = value;
                          },
                          onCompleted: (value) => _inputPin = value,
                          beforeTextPaste: (text) {
                            if (text!.length != 4) {
                              return false;
                            }
                            return true;
                          },
                        ),
                        if (_isPinWrong) pinWrongMsg(),
                        const SizedBox(height: 50),
                        GradientButton(
                          buttonHandle: _checkPin,
                          text: 'Submit',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column pinWrongMsg() {
    return Column(
      children: [
        const SizedBox(height: 15),
        Text(
          'Pin Salah!',
          style: TextStyle(color: Colors.red.shade700),
        ),
      ],
    );
  }
}
