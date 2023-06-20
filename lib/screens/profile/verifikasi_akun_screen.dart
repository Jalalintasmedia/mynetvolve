import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mynetvolve/core/enums.dart';
import 'package:mynetvolve/core/palette.dart';
import 'package:mynetvolve/helpers/custom_dialog.dart';
import 'package:mynetvolve/providers/customer_profile.dart';
import 'package:mynetvolve/widgets/buttons/gradient_button.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';
import 'package:mynetvolve/widgets/profile/profile_gradient_container.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifikasiAkunScreen extends StatefulWidget {
  const VerifikasiAkunScreen({
    Key? key,
    required this.data,
    required this.type,
    required this.name,
  }) : super(key: key);

  final String data;
  final OTPType type;
  final String name;

  @override
  State<VerifikasiAkunScreen> createState() => _VerifikasiAkunScreenState();
}

class _VerifikasiAkunScreenState extends State<VerifikasiAkunScreen> {
  final errorController = StreamController<ErrorAnimationType>();
  var _inputPin = '';
  var _isPinWrong = false;
  var _isSubmitLoading = false;
  var _isResendLoading = false;

  void _checkPin() async {
    setState(() {
      _isSubmitLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    var otpPin = prefs.getString('otp_pin');
    final _type = widget.type == OTPType.email ? 'email' : 'mobile';

    if (_inputPin == otpPin) {
      switch (widget.type) {
        case OTPType.email:
          await Provider.of<CustomerProfile>(context, listen: false)
              .setEmailVerifiedStatus('Y');
          print('===== CORRECT PIN');
          prefs.remove('otp_pin');
          Navigator.of(context).pop();
          break;
        case OTPType.mobile:
          await Provider.of<CustomerProfile>(context, listen: false)
              .setMobileVerifiedStatus('Y');
          print('===== CORRECT PIN');
          prefs.remove('otp_pin');
          Navigator.of(context).pop();
          break;
        default:
      }

      Fluttertoast.showToast(
        msg: 'Verifikasi $_type berhasil!',
        backgroundColor: Colors.black87,
      );

      setState(() {
        _isPinWrong = false;
      });
    } else {
      errorController.add(ErrorAnimationType.shake);
      setState(() {
        _isPinWrong = true;
      });
    }
    setState(() {
      _isSubmitLoading = false;
    });
  }

  void resendOTP() async {
    setState(() {
      _isResendLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    var rnd = Random();
    var otpPin = rnd.nextInt(9000) + 1000;
    final _type = widget.type == OTPType.email ? 'email' : 'WhatsApp';

    try {
      switch (widget.type) {
        case (OTPType.email):
          await Provider.of<CustomerProfile>(context, listen: false)
              .requestOTP(otpPin.toString(), widget.name, widget.data);
          break;
        case (OTPType.mobile):
          await Provider.of<CustomerProfile>(context, listen: false)
              .requestOTPMobile(otpPin.toString(), widget.name, widget.data);
          break;
        default:
          return;
      }
      prefs.setString('otp_pin', otpPin.toString());
      showSuccessMsg(
          context, 'Kode OTP berhasil dikirim ulang, cek $_type Anda');
    } catch (e) {
      showErrMsg(context, '$e');
      return;
    }
    setState(() {
      _isResendLoading = false;
    });
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(title: 'Verifikasi Akun'),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            // height: MediaQuery.of(context).size.height * 0.75,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'OTP Verfication',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  'We will send you a one time password to ${widget.data}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                PinCodeTextField(
                  appContext: context,
                  length: 4,
                  // obscureText: true,
                  keyboardType: TextInputType.number,
                  useHapticFeedback: true,
                  hapticFeedbackTypes: HapticFeedbackTypes.heavy,
                  animationType: AnimationType.fade,
                  errorAnimationController: errorController,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.circle,
                    selectedColor: const Color.fromRGBO(12, 193, 246, 0.9),
                    inactiveColor: Colors.grey.shade400,
                    activeColor: Palette.kToDark,
                    errorBorderColor: Colors.red.shade700,
                    fieldOuterPadding: const EdgeInsets.all(5),
                    fieldWidth: 45,
                    fieldHeight: 45,
                  ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Tidak mendapat kode OTP?'),
                    if(_isResendLoading) const SizedBox(width: 10),
                    _isResendLoading
                        ? const CircularProgressIndicator()
                        : TextButton(
                            onPressed: _isSubmitLoading ? null : resendOTP,
                            child: const Text('Kirim Ulang'),
                          ),
                  ],
                ),
                const SizedBox(height: 20),
                _isSubmitLoading
                    ? const CircularProgressIndicator()
                    : GradientButton(
                        buttonHandle: _checkPin,
                        text: 'Submit',
                      ),
              ],
            ),
          ),
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
