import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mynetvolve/core/constants.dart';
import 'package:mynetvolve/core/enums.dart';
import 'package:mynetvolve/screens/profile/verifikasi_akun_screen.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/custom_dialog.dart';
import '../../providers/customer_profile.dart';
import '../../widgets/buttons/rounded_button.dart';
import '../../widgets/profile/akun_form_field.dart';

class InfoAkunScreen extends StatefulWidget {
  const InfoAkunScreen({Key? key}) : super(key: key);

  @override
  State<InfoAkunScreen> createState() => _InfoAkunScreenState();
}

class _InfoAkunScreenState extends State<InfoAkunScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _emailVerified = '';
  var _mobileVerified = '';
  var _oldEmail = '';
  late String _email;
  final _namaLengkapCont = TextEditingController();
  final _alamatCont = TextEditingController();
  final _emailCont = TextEditingController();
  final _mobileCont = TextEditingController();

  Future<void> _sendOTPPin(OTPType type, String data, String name) async {
    final prefs = await SharedPreferences.getInstance();
    var rnd = Random();
    var otpPin = rnd.nextInt(9000) + 1000;

    prefs.setString('otp_pin', otpPin.toString());

    try {
      switch (type) {
        case (OTPType.email):
          await Provider.of<CustomerProfile>(context, listen: false)
              .requestOTP(otpPin.toString(), name, data);
          break;
        case (OTPType.mobile):
          await Provider.of<CustomerProfile>(context, listen: false)
              .requestOTPMobile(otpPin.toString(), name, data);
          break;
        default:
          return;
      }
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => VerifikasiAkunScreen(
            data: data,
            type: type,
            name: name,
          ),
        ),
      ).then((value) => setState(() {}));
    } catch (e) {
      showErrMsg(context, '$e');
      return;
    }
  }

  void _submitChange() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    if (_email == _oldEmail) {
      return;
    }

    try {
      await Provider.of<CustomerProfile>(context, listen: false)
          .changeEmail(_email);
      Fluttertoast.showToast(
        msg: 'Berhasil Mengubah Email',
        backgroundColor: Colors.black87,
      );
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Gagal Mengubah Email'),
          backgroundColor: Colors.red.shade700,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // var custData = Provider.of<CustomerProfile>(context, listen: false);
    return Scaffold(
      appBar: const GradientAppBar(title: 'Info Akun'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: Provider.of<CustomerProfile>(context, listen: false)
                .getUserProfile(),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Center(child: CircularProgressIndicator()),
                );
              } else {
                if (dataSnapshot.error != null) {
                  return const Center(
                    child: Text('an error has occured'),
                  );
                } else {
                  return Consumer<CustomerProfile>(
                    builder: (ctx, custData, _) {
                      _namaLengkapCont.text = custData.customer!.accountName;
                      _alamatCont.text = custData.customer!.accountAddress1;
                      _emailCont.text = custData.customer!.accountEmail;
                      _mobileCont.text = custData.customer!.accountHp;
                      _emailVerified = custData.customer!.emailVerified;
                      _mobileVerified = custData.customer!.mobilePhoneVerified;
                      _oldEmail = custData.customer!.accountEmail;
                      return Form(
                        key: _formKey,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                            top: 30,
                            right: 30,
                            left: 30,
                            bottom: 80,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AkunFormField(
                                cont: _namaLengkapCont,
                                text: 'Nama Lengkap',
                                textInputType: TextInputType.name,
                                readOnly: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Nama tidak boleh kosong';
                                  }
                                },
                                onSaved: (value) {},
                              ),
                              const SizedBox(height: 10),
                              AkunFormField(
                                cont: _alamatCont,
                                text: 'Alamat',
                                textInputType: TextInputType.streetAddress,
                                readOnly: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Alamat tidak boleh kosong';
                                  }
                                },
                                onSaved: (value) {},
                              ),
                              const SizedBox(height: 10),
                              AkunFormField(
                                  cont: _emailCont,
                                  text: 'Email',
                                  textInputType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email tidak boleh kosong';
                                    }
                                  },
                                  onSaved: (value) {
                                    _email = value!;
                                  },
                                  additionalInfo: _oldEmail != ''
                                      ? _emailVerified == 'Y'
                                          ? const Icon(
                                              Icons.verified,
                                              color: Colors.green,
                                            )
                                          : verifyButton(
                                              OTPType.email,
                                              custData.customer!.accountEmail,
                                              custData.customer!.accountName,
                                            )
                                      : null),
                              const SizedBox(height: 10),
                              AkunFormField(
                                cont: _mobileCont,
                                text: 'Mobile',
                                textInputType: TextInputType.number,
                                readOnly: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Mobile tidak boleh kosong';
                                  }
                                },
                                onSaved: (value) {},
                                additionalInfo: _mobileVerified == 'Y'
                                    ? const Icon(
                                        Icons.verified,
                                        color: Colors.green,
                                      )
                                    : verifyButton(
                                        OTPType.mobile,
                                        custData.customer!.accountHp,
                                        custData.customer!.accountName,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        height: 50,
        child: RoundedButton(
          onPressed: () {
            if (_emailVerified == 'Y') {
              _submitChange();
            } else {
              showCustomDialog(
                context: context,
                title: 'Error',
                content: 'Anda belum dapat mengubah data akun anda',
              );
            }
          },
          text: 'Simpan',
          useSide: true,
          useShadow: false,
        ),
      ),
    );
  }

  TextButton verifyButton(OTPType type, String data, String name) {
    var text = '';
    switch (type) {
      case (OTPType.email):
        text = 'Verifikasi melalui email, klik di sini';
        break;
      case (OTPType.mobile):
        text = 'Verifikasi melalui WhatsApp, klik di sini';
        break;
      default:
    }
    return TextButton(
      onPressed: () => _sendOTPPin(type, data, name),
      child: Text(
        text,
        textAlign: TextAlign.end,
        style: const TextStyle(
          color: Colors.amber,
          fontSize: 13,
          fontStyle: FontStyle.italic,
        ),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(50, 30),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerRight,
      ),
    );
  }
}
