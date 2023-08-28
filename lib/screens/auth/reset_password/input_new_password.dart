import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../providers/customer_profile.dart';
import '../../../widgets/auth/gradient_background.dart';
import '../../../widgets/auth/register_form_field.dart';
import '../../../widgets/buttons/gradient_button.dart';

class InputNewPassword extends StatefulWidget {
  const InputNewPassword({
    Key? key,
    required this.tAccountId,
  }) : super(key: key);

  final String tAccountId;

  @override
  State<InputNewPassword> createState() => _InputNewPasswordState();
}

class _InputNewPasswordState extends State<InputNewPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  final _ulangiPassController = TextEditingController();
  late String _password;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    print(_password);

    try {
      await Provider.of<CustomerProfile>(
        context,
        listen: false,
      ).resetPassword(widget.tAccountId, _password);

      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Fluttertoast.showToast(
        msg: 'Reset Password Berhasil!',
        backgroundColor: Colors.black87,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e'),
          backgroundColor: Colors.red.shade700,
        ),
      );
    }
    // Navigator.of(context).pop();
    //   Navigator.of(context).pop();
    //   Navigator.of(context).pop();
    //   Fluttertoast.showToast(
    //     msg: 'Reset Password Berhasil!',
    //     backgroundColor: Colors.black87,
    //   );
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const Text(
                            'Reset Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Password yang Anda masukkan juga akan berlaku pada laman my.bnetfit.com',
                            style: TextStyle(
                              color: Colors.white,
                              // fontWeight: FontWeight.w200,
                            ),
                          ),
                          const SizedBox(height: 10),
                          RegisterFormField(
                            text: 'Password Baru',
                            cont: _passwordController,
                            isPassword: true,
                            textInputType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password Baru Harus Diisi';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _password = value!;
                              return null;
                            },
                            onSaved: (value) {
                              _password = value!;
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          RegisterFormField(
                            text: 'Ulangi Password',
                            cont: _ulangiPassController,
                            isPassword: true,
                            textInputType: TextInputType.text,
                            validator: (value) {
                              if (value != _password) {
                                return 'Password Tidak Sama!';
                              }
                              return null;
                            },
                            onSaved: (_) => null,
                          ),
                          const SizedBox(height: 40),
                          GradientButton(
                            buttonHandle: _submit,
                            text: 'Submit',
                          ),
                        ],
                      ),
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
}
