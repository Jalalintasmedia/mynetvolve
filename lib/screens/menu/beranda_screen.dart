// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:advanced_in_app_review/advanced_in_app_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:mynetvolve/helpers/custom_dialog.dart';
import 'package:mynetvolve/models/network_info.dart';
import 'package:mynetvolve/providers/network_info_prov.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:upgrader/upgrader.dart';

import '../../core/constants.dart';
import '../../helpers/popups.dart';
import '../../widgets/beranda/carousel_top_container.dart';
import '../../widgets/beranda/status_koneksi_container.dart';
import '/providers/customer_profile.dart';
import '/widgets/beranda/floating_info_container.dart';
import '/widgets/beranda/iklan_list_view.dart';

class BerandaScreen extends StatefulWidget {
  static const PREFERENCES_IS_FIRST_LAUNCH_STRING =
      "PREFERENCES_IS_FIRST_LAUNCH_STRING";
  static const NETWORK_INFO = 'NETWORK_INFO';
  const BerandaScreen({Key? key}) : super(key: key);

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  final _keyOne = GlobalKey();
  final _keyTwo = GlobalKey();
  final _keyThree = GlobalKey();
  final _keyFour = GlobalKey();
  final _keyFive = GlobalKey();
  var networkInfo = NetworkInfo(accountStatus: '...', deviceState: '...');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      fetchNetworkInfo();
      // showShowcase();
      // showEmailVerificationPopUp(context);
      showInAppReview();
      _isFirstLaunch().then((result) {
        if (result) {
          showShowcase();
        } else {
          showEmailVerificationPopUp(context);
        }
      });
    });
  }

  Future<bool> _isFirstLaunch() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = sharedPreferences
            .getBool(BerandaScreen.PREFERENCES_IS_FIRST_LAUNCH_STRING) ??
        true;

    if (isFirstLaunch) {
      sharedPreferences.setBool(
          BerandaScreen.PREFERENCES_IS_FIRST_LAUNCH_STRING, false);
    }

    return isFirstLaunch;
  }

  void showShowcase() async {
    // _isFirstLaunch().then((result) {
    //   if (result) {
    ShowCaseWidget.of(context).startShowCase([
      _keyOne,
      _keyTwo,
      _keyThree,
      _keyFour,
      _keyFive,
    ]);
    //   }
    // });
  }

  // void showEmailVerificationPopUp() async {
  //   final isEmailVerified = Provider.of<CustomerProfile>(context, listen: false)
  //       .customer!
  //       .emailVerified;
  //   var prefs = await SharedPreferences.getInstance();

  //   if (prefs.getBool('isDisplayed') == false) {
  //     if (isEmailVerified != 'Y') {
  //       await _showPopup();
  //     }
  //     await prefs.setBool('isDisplayed', true);
  //   }
  //   // _showPopup();
  // }

  void fetchNetworkInfo() async {
    var prefs = await SharedPreferences.getInstance();
    print(
        '===== CACHE AVAILABLE? ${prefs.containsKey(BerandaScreen.NETWORK_INFO)}');
    if (prefs.containsKey(BerandaScreen.NETWORK_INFO)) {
      var fetchedNetworkInfo =
          json.decode(prefs.getString(BerandaScreen.NETWORK_INFO)!);
      print('===== USING CACHE DATA');
      setState(() {
        networkInfo = NetworkInfo.fromJson(fetchedNetworkInfo);
      });
      return;
    }

    final fetchedNetworkInfo = await Provider.of<NetworkInfoProv>(
      context,
      listen: false,
    ).getNetworkInfo();
    print('===== FETCH DATA FROM SERVER');
    setState(() {
      networkInfo = fetchedNetworkInfo;
    });
    prefs.setString(
        BerandaScreen.NETWORK_INFO, json.encode(fetchedNetworkInfo));
  }

  void refreshNetworkInfo() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(BerandaScreen.NETWORK_INFO);
    setState(() {
      networkInfo = NetworkInfo(accountStatus: '...', deviceState: '...');
    });
    fetchNetworkInfo();
  }

  void showInAppReview() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      AdvancedInAppReview()
        ..setMinDaysBeforeRemind(7)
        ..setMinDaysAfterInstall(7)
        ..setMinLaunchTimes(2)
        ..setMinSecondsBeforeShowDialog(3)
        ..monitor();
    }
  }

  // _showPopup() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   showCustomDialog(
  //     context: context,
  //     title: 'Verifikasi',
  //     content:
  //         'Akun belum terverifikasi\nSilakan lakukan verifikasi akun anda pada menu profile -> info akun',
  //   );
  //   await prefs.setBool('isDisplayed', true);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: UpgradeAlert(
          upgrader: Upgrader(
            durationUntilAlertAgain: const Duration(days: 1),
            dialogStyle: Platform.isIOS
                ? UpgradeDialogStyle.cupertino
                : UpgradeDialogStyle.material,
          ),
          child: Center(
            child: SizedBox(
              height: double.infinity,
              child: SafeArea(
                child: Stack(
                  // kalau mau scrollable satu page, bungkus pakai SingleChilScrollView
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                    ),
                    CarouselTopContainer(
                      context: context,
                      scanShowcaseKey: _keyOne,
                      notifShowcaseKey: _keyTwo,
                    ),
                    Positioned.fill(
                      top: MediaQuery.of(context).size.height * 0.22,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Showcase(
                              key: _keyThree,
                              description: ToolTipString.FLOATING_INFO_CONTAINER,
                              child: FloatingInfoContainer(
                                context: context,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Showcase(
                              key: _keyFour,
                              description: ToolTipString.STATUS_KONEKSI,
                              child: StatusKoneksiContainer(
                                deviceState: networkInfo.deviceState,
                                showcaseKey: _keyFive,
                                refreshNetworkInfo: refreshNetworkInfo,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Apa yang baru?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            IklanListView(context: context),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // IconButton scanButton(BuildContext context) {
  //   return IconButton(
  //     tooltip: ToolTipString.SCAN_PEGAWAI,
  //     onPressed: () =>
  //         Navigator.of(context).pushNamed(RouteNames.SCAN_QR_ROUTE),
  //     icon: const ImageIcon(
  //       AssetImage('assets/icons/qr-scan.png'),
  //       color: Colors.white,
  //     ),
  //   );
  // }

  // IconButton notifButton(BuildContext context) {
  //   return IconButton(
  //     tooltip: ToolTipString.NOTIFIKASI,
  //     onPressed: () {
  //       Navigator.of(context).pushNamed(RouteNames.PEMBERITAHUAN_ROUTE);
  //     },
  //     icon: const Icon(
  //       Icons.notifications,
  //       color: Colors.white,
  //       size: 30,
  //     ),
  //     visualDensity: const VisualDensity(
  //       horizontal: VisualDensity.maximumDensity,
  //       vertical: VisualDensity.maximumDensity,
  //     ),
  //     // constraints: BoxConstraints(),
  //   );
  // }
}
