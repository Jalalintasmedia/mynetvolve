import 'package:flutter/material.dart';

import '../../widgets/auth/gradient_background.dart';
import '../../widgets/auth/pin_widget.dart';
import '../../core/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _pinController = PinController();

  void _login(String pin) {
    if (pin == '123456') {
      Navigator.of(context).pushNamedAndRemoveUntil(
        RouteNames.HOME_ROUTE,
        ModalRoute.withName(RouteNames.HOME_ROUTE),
      );
    } else {
      _pinController.notifyWrongInput();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Masukkan Password Anda',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 40,
                ),
                PinWidget(
                  pinLength: 6,
                  controller: _pinController,
                  onCompleted: (pin) {
                    _login(pin);
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: List.generate(
                    9,
                    (index) => numberbutton(index + 1),
                  ),
                ),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      textColor: Colors.white,
                      child: const Icon(
                        Icons.fingerprint,
                        size: 50,
                      ),
                      shape: const CircleBorder(),
                    ),
                    numberbutton(0),
                    MaterialButton(
                      onPressed: () {
                        _pinController.delete();
                      },
                      textColor: Colors.white,
                      child: const Icon(
                        Icons.backspace_rounded,
                        size: 50,
                      ),
                      shape: const CircleBorder(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: double.infinity,
        height: 60,
        color: Colors.black45,
        child: FittedBox(
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'Ganti Akun',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  MaterialButton numberbutton(int input) {
    return MaterialButton(
      onPressed: () {
        _pinController.addInput('$input');
      },
      textColor: Colors.white,
      child: Text(
        '$input',
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: const CircleBorder(),
    );
  }
}
