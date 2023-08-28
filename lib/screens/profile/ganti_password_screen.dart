import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/custom_dialog.dart';
import '../../widgets/profile/akun_form_field.dart';
import '../../providers/customer_profile.dart';
import '../../widgets/buttons/rounded_button.dart';
import '../../widgets/gradient_app_bar.dart';

class GantiPasswordScreen extends StatefulWidget {
  const GantiPasswordScreen({Key? key}) : super(key: key);

  @override
  State<GantiPasswordScreen> createState() => _GantiPasswordScreenState();
}

class _GantiPasswordScreenState extends State<GantiPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late String passwordLama;
  late String _passwordBaru;
  final _passwordLamaCont = TextEditingController();
  final _passwordBaruCont = TextEditingController();
  var _savedPasswordLama = '';

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    try {
      await Provider.of<CustomerProfile>(context, listen: false)
          .changePassword(_passwordBaru);

      var prefs = await SharedPreferences.getInstance();
      final userLoginInfo = json.decode(prefs.getString('userLoginInfo')!)
          as Map<String, dynamic>;
      final savedAccountNo = userLoginInfo['account_no'];
      final newUserLoginInfo = json.encode({
        'account_no': savedAccountNo,
        'password': _passwordBaru,
      });
      prefs.setString('userLoginInfo', newUserLoginInfo);

      Fluttertoast.showToast(
        msg: 'Berhasil Mengubah Password',
        backgroundColor: Colors.black87,
      );
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Gagal Mengubah Password'),
          backgroundColor: Colors.red.shade700,
        ),
      );
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var prefs = await SharedPreferences.getInstance();
      final userLoginInfo = json.decode(prefs.getString('userLoginInfo')!)
          as Map<String, dynamic>;
      _savedPasswordLama = userLoginInfo['password'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var custData = Provider.of<CustomerProfile>(context, listen: false);
    return Scaffold(
      appBar: const GradientAppBar(title: 'Ganti Password'),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 15,
                right: 30,
                left: 30,
                bottom: 80,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                    ),
                    child: const Text(
                      'Perhatian: Mengganti password akan mengubah password pada laman my.bnetfit.com',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 15),
                  AkunFormField(
                    cont: _passwordLamaCont,
                    text: 'Password Lama',
                    textInputType: TextInputType.text,
                    isPassword: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password lama tidak boleh kosong';
                      } else if (value != _savedPasswordLama) {
                        return 'Password salah';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      passwordLama = value!;
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  AkunFormField(
                    cont: _passwordBaruCont,
                    text: 'Password Baru',
                    textInputType: TextInputType.text,
                    isPassword: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password baru tidak boleh kosong';
                      } else if (value.length < 8) {
                        return 'Password minimal terdiri dari 8 karakter';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _passwordBaru = value!;
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        height: 50,
        child: RoundedButton(
          onPressed: custData.customer!.emailVerified == 'Y'
              ? _submit
              : () => showCustomDialog(
                    context: context,
                    title: 'Verifikasi Akun',
                    content:
                        'Akun belum terverifikasi\nSilakan lakukan verifikasi akun anda pada menu profile -> info akun',
                  ),
          text: 'Simpan',
          useSide: true,
          useShadow: false,
        ),
      ),
    );
  }
}
