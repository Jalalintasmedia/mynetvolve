import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mynetvolve/providers/customer_profile.dart';
import 'package:mynetvolve/screens/auth/reset_password/otp_reset_password_screen.dart';
import 'package:mynetvolve/widgets/auth/call_cs_button.dart';
import 'package:mynetvolve/widgets/auth/gradient_background.dart';
import 'package:mynetvolve/widgets/buttons/gradient_button.dart';
import 'package:provider/provider.dart';

import '../../../core/constants.dart';
import '../../../widgets/auth/register_form_field.dart';
import '../../../widgets/netvolve_logo.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailController = TextEditingController();
  final _accountNoController = TextEditingController();
  late String _email;
  late String _accountNo;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    var rnd = Random();
    var otpPin = rnd.nextInt(9000) + 1000;

    final responseMap = await Provider.of<CustomerProfile>(
      context,
      listen: false,
    ).checkCustomer(_accountNo, _email);

    final isAccountValid = responseMap['isValid'];
    final tAccountId = responseMap['tAccountId'];

    print(isAccountValid);
    if (isAccountValid) {
      try {
        await Provider.of<CustomerProfile>(
          context,
          listen: false,
        ).requestOTP(otpPin.toString(), '', _email);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OtpResetPasswordScreen(
              tAccountId: tAccountId,
              email: _email,
              pin: otpPin.toString(),
            ),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Tidak dapat mengirim pin OTP'),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Akun Tidak Valid'),
          backgroundColor: Colors.red.shade700,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const NetvolveLogo(padding: 70),
                    const SizedBox(height: 40),
                    emailForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: const CallCSButton(),
      ),
    );
  }

  Form emailForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reset Password',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w200,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Harap masukkan nomor pelanggan dan alamat email anda. Kode verifikasi akan dikirim ke email anda.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w200,
            ),
          ),
          const Text(
            'Perhatian: Mengganti password akan mengubah password pada laman my.bnetfit.com',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          RegisterFormField(
            cont: _accountNoController,
            isPassword: false,
            textInputType: TextInputType.number,
            text: 'Nomor Pelanggan',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Nomor Pelanggan Harus Diisi';
              }
            },
            onSaved: (value) {
              _accountNo = value!;
            },
          ),
          const SizedBox(height: 10),
          RegisterFormField(
            cont: _emailController,
            isPassword: false,
            textInputType: TextInputType.emailAddress,
            text: 'Email',
            validator: (value) {
              final bool emailValid = EMAIL_REGEXP.hasMatch(value!);
              if (value.isEmpty) {
                return 'Email Harus Diisi';
              } else if (!emailValid) {
                return 'Alamat Email Tidak Valid';
              }
            },
            onSaved: (value) {
              _email = value!;
            },
          ),
          const SizedBox(height: 40),
          GradientButton(
            buttonHandle: _submit,
            text: 'Submit',
          ),
        ],
      ),
    );
  }
}
