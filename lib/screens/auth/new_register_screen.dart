import 'package:flutter/material.dart';

import '../../core/constants.dart';
import '../../widgets/auth/auth_screen_template.dart';
import '../../widgets/buttons/gradient_button.dart';

import '../../widgets/auth/register_form_field.dart';

class NewRegisterScreen extends StatefulWidget {
  const NewRegisterScreen({Key? key}) : super(key: key);

  @override
  State<NewRegisterScreen> createState() => _NewRegisterScreenState();
}

class _NewRegisterScreenState extends State<NewRegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var namaLengkap;
  var noHP;
  var noKTP;
  var email;
  final namaLengkapController = TextEditingController();
  final noHPController = TextEditingController();
  final noKTPController = TextEditingController();
  final emailController = TextEditingController();

  void _lanjutRegister() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (ctx) => SubmitLocationScreen(
    //       namaLengkap: namaLengkap,
    //       noHP: noHP,
    //       noKTP: noKTP,
    //       alamatEmail: email,
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreenTemplate(
      formWidget: Column(
        children: [
          registerForm(),
          const SizedBox(height: 25),
          GradientButton(buttonHandle: _lanjutRegister, text: 'Lanjutkan'),
        ],
      ),
    );
  }

  Form registerForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          RegisterFormField(
            cont: namaLengkapController,
            text: 'Nama Lengkap',
            isPassword: false,
            textInputType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Nama Lengkap Harus Diisi';
              }
              return null;
            },
            onSaved: (value) {
              namaLengkap = value!;
              return null;
            },
          ),
          const SizedBox(height: 10),
          RegisterFormField(
            cont: noHPController,
            text: 'Nomor Handphone',
            isPassword: false,
            textInputType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Nomor Handphone Harus Diisi';
              }
              return null;
            },
            onSaved: (value) {
              noHP = value!;
              return null;
            },
          ),
          const SizedBox(height: 10),
          RegisterFormField(
            cont: noKTPController,
            text: 'Nomor KTP',
            isPassword: false,
            textInputType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Nomor KTP Harus Diisi';
              }
              return null;
            },
            onSaved: (value) {
              noKTP = value!;
              return null;
            },
          ),
          const SizedBox(height: 10),
          RegisterFormField(
            cont: emailController,
            text: 'Alamat Email',
            isPassword: false,
            textInputType: TextInputType.emailAddress,
            validator: (value) {
              final bool emailValid = EMAIL_REGEXP.hasMatch(value!);
              if (value.isEmpty) {
                return 'Alamat Email Harus Diisi';
              } else if (!emailValid) {
                return 'Alamat Email Tidak Valid';
              }
              return null;
            },
            onSaved: (value) {
              email = value!;
              return null;
            },
          ),
        ],
      ),
    );
  }
}
