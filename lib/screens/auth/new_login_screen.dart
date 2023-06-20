import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';

import '../../providers/auth.dart';
import '../../widgets/auth/call_cs_button.dart';
import '../../widgets/netvolve_logo.dart';
import '../../widgets/auth/gradient_background.dart';
import '../../widgets/buttons/gradient_button.dart';
import '../../widgets/auth/register_form_field.dart';
import '../../core/constants.dart';

class NewLoginScreen extends StatefulWidget {
  const NewLoginScreen({Key? key}) : super(key: key);

  @override
  State<NewLoginScreen> createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late String _nomorPelanggan;
  late String _password;
  final _noPelangganController = TextEditingController();
  final _passwordController = TextEditingController();
  var _isFingerPrintEnabled = false;
  var _isLoading = false;
  var _isBiometricFaceId = false;
  LocalAuthentication auth = LocalAuthentication();

  void _showErrMsg(String errMsg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errMsg),
        backgroundColor: Colors.red.shade700,
      ),
    );
  }

  Future<void> _masuk() async {
    var _fingerprintStatus = true;
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false).logIn(
        accountNo: _nomorPelanggan,
        password: _password,
      );

      //store data for fingerprint login
      final prefs = await SharedPreferences.getInstance();
      final userLoginInfo = json.encode({
        'account_no': _nomorPelanggan,
        'password': _password,
      });
      prefs.setString('userLoginInfo', userLoginInfo);

      // check activate_fingerprint availability
      if (prefs.containsKey('activate_fingerprint')) {
        _fingerprintStatus = prefs.getBool('activate_fingerprint')!;
      }
      prefs.setBool('activate_fingerprint', _fingerprintStatus);

      print('logging in....');
      TextInput.finishAutofillContext(shouldSave: true);

      Navigator.of(context).pop();
    } catch (err) {
      var errMsg = 'Log In Gagal\nHarap periksa koneksi internet Anda.';
      print(err.toString().contains('INVALID USERLOGIN'));
      print('====== $err');

      if (err.toString().contains('INVALID USERLOGIN') ||
          err.toString().contains('INVALID ACCOUNT-NO or MOBILE PHONE')) {
        errMsg = 'No Pelanggan atau Passsword Salah';
      }
      _showErrMsg(errMsg);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _fingerprintLogin() async {
    final _authProvider = Provider.of<Auth>(context, listen: false);
    var errorMsg = '';
    var noPelanggan;
    var pass;
    final prefs = await SharedPreferences.getInstance();
    bool isAuthenticated = await _authProvider.loginWithFingerprint();

    setState(() {
      _isLoading = true;
    });
    try {
      if (isAuthenticated) {
        if (!prefs.containsKey('userLoginInfo')) {
          errorMsg =
              'Belum dapat melakukan login biometrik.\nLogin dahulu lalu coba lagi';
          _showErrMsg(errorMsg);
        } else {
          final userLoginInfo = json.decode(prefs.getString('userLoginInfo')!)
              as Map<String, dynamic>;
          noPelanggan = userLoginInfo['account_no'];
          pass = userLoginInfo['password'];

          await _authProvider.logIn(
            accountNo: noPelanggan,
            password: pass,
          );
          Navigator.of(context).pop();
        }
      } else {
        _showErrMsg('Tidak dapat menggunakan Fingerprint');
      }
    } catch (err) {
      if (err.toString().contains('INVALID USERLOGIN') ||
          err.toString().contains('INVALID ACCOUNT-NO or MOBILE PHONE')) {
        _showErrMsg('No Pelanggan atau Passsword Salah');
      }
      _showErrMsg('Log In Gagal');
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _checkFingerprintStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isFingerPrintEnabled = prefs.getBool('activate_fingerprint')!;

      final localAuth = LocalAuthentication();
      final List<BiometricType> availableBiometrics =
          await localAuth.getAvailableBiometrics();
      if (availableBiometrics.contains(BiometricType.face)) {
        _isBiometricFaceId = true;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: GradientBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const NetvolveLogo(padding: 70),
                      const SizedBox(height: 40),
                      loginForm(),
                      const SizedBox(height: 20),
                      _isLoading
                          ? Container(
                              padding: const EdgeInsets.all(5),
                              height: 60,
                              width: 60,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : GradientButton(
                              buttonHandle: _masuk,
                              text: 'Masuk',
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: floatingActionButtonRow(),
      ),
    );
  }

  Widget loginForm() {
    return AutofillGroup(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            RegisterFormField(
              cont: _noPelangganController,
              text: 'Nomor Pelanggan',
              isPassword: false,
              textInputType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Nomor Pelanggan Harus Diisi';
                }
              },
              onSaved: (value) {
                _nomorPelanggan = value!;
              },
              autofillHints: const [AutofillHints.username],
            ),
            const SizedBox(height: 10),
            RegisterFormField(
              cont: _passwordController,
              text: 'Password',
              isPassword: true,
              textInputType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password Harus Diisi';
                }
              },
              onSaved: (value) {
                _password = value!;
              },
              autofillHints: const [AutofillHints.password],
            ),
            const SizedBox(height: 8),
            lupaPasswordButton(),
          ],
        ),
      ),
    );
  }

  Row lupaPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () =>
              Navigator.of(context).pushNamed(RouteNames.RESET_PASSWORD_ROUTE),
          child: const Text(
            'Lupa Password',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w200,
              fontSize: 12,
            ),
          ),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(50, 30),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }

  Widget floatingActionButtonRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.bottomLeft,
            child: CallCSButton(),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: fingerprintButton(),
          ),
        ],
      ),
    );
  }

  FutureBuilder<void> fingerprintButton() {
    return FutureBuilder(
      future: _checkFingerprintStatus(),
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        } else {
          if (dataSnapshot.error != null) {
            return const SizedBox();
          } else {
            if (_isFingerPrintEnabled) {
              final icon = _isBiometricFaceId ? 'face-id' : 'fingerprint-scan';
              return FloatingActionButton(
                heroTag: 'fingerprintButton',
                onPressed: _isLoading ? null : _fingerprintLogin,
                child: ImageIcon(
                  AssetImage('assets/icons/$icon.png'),
                ),
              );
            } else {
              return const SizedBox();
            }
          }
        }
      },
    );
  }
}
