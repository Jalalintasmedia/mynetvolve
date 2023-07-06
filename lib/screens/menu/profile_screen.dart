import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mynetvolve/widgets/profile/profile_gradient_container.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/constants.dart';
import '../../providers/auth.dart';
import '../../providers/customer_profile.dart';
import '../../widgets/netvolve_logo_top_left.dart';
import '../../widgets/buttons/gradient_button.dart';
import '../../widgets/profile/pengaturan_list_panel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _version = '';
  XFile? _imageFile;

  void _takeImage(XFile image) async {
    _imageFile = image;
    File _fileImage = File(_imageFile!.path);
    var imageBytes = _fileImage.readAsBytesSync();
    var base64Image = base64Encode(imageBytes);
    print('===== FILE SIZE: ${_fileImage.lengthSync()}');

    try {
      await Provider.of<CustomerProfile>(
        context,
        listen: false,
      ).setProfilePic(base64Image);
      await Provider.of<CustomerProfile>(
        context,
        listen: false,
      ).getUserProfile();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Gagal mengubah foto profil'),
          backgroundColor: Colors.red.shade700,
        ),
      );
    }
  }

  @override
  void initState() {
    getVersionNumber();
    super.initState();
  }

  Future<void> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    String _nama;
    List<Map<String, dynamic>> _pengaturanList = [
      {
        'onTap': () =>
            Navigator.of(context).pushNamed(RouteNames.INFO_AKUN_ROUTE),
        'title': 'Info Akun',
        'icon': 'user.png',
      },
      {
        'onTap': () =>
            Navigator.of(context).pushNamed(RouteNames.GANTI_PASSWORD_ROUTE),
        'title': 'Ganti Password',
        'icon': 'padlock.png',
      },
      {
        'onTap': () =>
            Navigator.of(context).pushNamed(RouteNames.RIWAYAT_ROUTE),
        'title': 'Riwayat',
        'icon': 'invoice.png',
      },
    ];

    List<Map<String, dynamic>> _pengaturanKeamananList = [
      {
        'onTap': () {},
        'title': 'Login Biometrik',
        'icon': 'fingerprint-scan.png',
      },
    ];

    List<Map<String, dynamic>> _bantuanDanLayananList = [
      {
        'onTap': () => Navigator.of(context)
            .pushNamed(RouteNames.BANTUAN_DAN_KONTAK_ROUTE),
        'title': 'Bantuan dan Kontak Kami',
        'icon': 'info.png',
      },
      {
        'onTap': () => Navigator.of(context).pushNamed(RouteNames.KANTOR_ROUTE),
        'title': 'Kantor Bnetfit',
        'icon': 'office.png',
      },
    ];
    // final authData = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              ProfileGradientContainer(
                editable: true,
                imagePickFn: _takeImage,
              ),
              Positioned.fill(
                top: 200 - MediaQuery.of(context).padding.top + 15,
                  left: 0,
                  right: 0,
                  bottom: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      child: Column(
                        children: [
                          PengaturanListPanel(
                            judulSection: 'Pengaturan Akun',
                            pengaturanList: _pengaturanList,
                            context: context,
                          ),
                          const SizedBox(height: 20),
                          PengaturanListPanel(
                            judulSection: 'Pengaturan Keamanan',
                            pengaturanList: _pengaturanKeamananList,
                            context: context,
                          ),
                          const SizedBox(height: 20),
                          PengaturanListPanel(
                            judulSection: 'Bantuan dan Layanan',
                            pengaturanList: _bantuanDanLayananList,
                            context: context,
                          ),
                          const SizedBox(height: 20),
                          logoutButton(context),
                          const SizedBox(height: 5),
                          Text(
                            'v$_version',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GradientButton logoutButton(BuildContext context) {
    return GradientButton(
      buttonHandle: () => Provider.of<Auth>(context, listen: false).logout(),
      text: 'Logout',
      height: 50,
      useBorder: false,
    );
  }

  Widget nameWidget() {
    return Consumer<CustomerProfile>(
      builder: (ctx, custData, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hai,',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w200,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            custData.customer!.accountName,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
