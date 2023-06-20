import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:crypto/crypto.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:mynetvolve/core/constants.dart';
import 'package:mynetvolve/screens/menu/beranda_screen.dart';
import 'package:salesiq_mobilisten/salesiq_mobilisten.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mynetvolve/models/http_exception.dart';

import '../helpers/get_ip_address.dart';

class Auth with ChangeNotifier {
  // Auth(this._token);

  String? _token;
  String? _tAccountId;
  int? _time;
  DateTime? _expiryDate;
  Timer? _authTimer;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get tAccountId {
    return _tAccountId;
  }

  String? get time {
    return _time.toString();
  }

  Future<void> logIn({
    required String accountNo,
    required String password,
  }) async {
    final url = Uri.parse(IBOSS_API_URL + '/ibossapi');
    var clientId = CLIENT_ID_DEV;
    var tAccountId = 66842;
    var timestamp = (DateTime.now()).millisecondsSinceEpoch;
    var str = timestamp.toString() + tAccountId.toString();
    var firebaseToken = await FirebaseMessaging.instance.getToken();
    final ipAddress = await getIPAddress();

    var key = utf8.encode(clientId.toString()); //ClientID
    var bytes = utf8.encode(str);
    var hmacSha256 = Hmac(sha512, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);
    late String deviceOSType;
    late String deviceOSversion;

    //device OS info
    final deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      deviceOSType = 'android';
      deviceOSversion = deviceInfo.version.release!;
    } else if (Platform.isIOS) {
      final deviceInfo = await deviceInfoPlugin.iosInfo;
      deviceOSType = 'iOS';
      deviceOSversion = deviceInfo.systemVersion!;
    }

    print('===== $deviceOSType: $deviceOSversion');
    // print('===== FIREBASE TOKEN: $firebaseToken');
    print('===== IP ADDRESS: $ipAddress');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $digest',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "act": "userlogin",
          "time": timestamp,
          "account_no": accountNo,
          "password": password,
          "t_account_id": tAccountId,
          "device_os_type": deviceOSType,
          "device_os_version": deviceOSversion,
          "device_token": firebaseToken,
          "ip_address": ipAddress,
        }),
      );

      print(response.body);
      final responseData = json.decode(response.body);

      if (responseData['result'] != '00') {
        throw HttpException(responseData['msg']);
      }
      if (responseData['data']['t_isp_id'] != '1') {
        throw HttpException('Tidak dapat login menggunakan akun Bnetfit');
      }

      // new token based on extracted data
      var newTAccountId = responseData['data']['t_account_id'];
      var newStr = timestamp.toString() + newTAccountId.toString();
      var newBytes = utf8.encode(newStr);
      var newToken = hmacSha256.convert(newBytes);
      // print(
      //     'account_no: $accountNo, password: $password, time: $timestamp, t_account_id: $newTAccountId, token: $newToken');

      _token = newToken.toString();
      _tAccountId = newTAccountId;
      _expiryDate = DateTime.now().add(const Duration(hours: 24));
      _time = timestamp;
      // print(
      //     'TOKEN: $newToken, tAccountId: $newTAccountId, timestamp: $timestamp');

      _autoLogout();
      notifyListeners();

      //store data to device
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        't_account_id': _tAccountId,
        'time': _time,
        'expiryDate': _expiryDate!.toIso8601String()
      });
      prefs.setString('userData', userData);
      prefs.setBool('isDisplayed', false);

      // remove networkInfo
      prefs.remove(BerandaScreen.NETWORK_INFO);
    } catch (e) {
      print('===== ERROR: $e');
      rethrow;
    }
  }

  Future loginWithFingerprint() async {
    final localAuth = LocalAuthentication();
    // return await _localAuth.authenticateWi
    final bool isBiometricsAvailable = await localAuth.isDeviceSupported();
    if (!isBiometricsAvailable) {
      return false;
    }

    try {
      return await localAuth.authenticate(
        localizedReason: 'Pindai Sidik Jari Untuk Login ',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: false,
        ),
      );
    } on PlatformException {
      return false;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedUserData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _tAccountId = extractedUserData['t_account_id'];
    // _expiryDate = expiryDate;
    _expiryDate = DateTime.now().add(const Duration(hours: 24));
    _time = extractedUserData['time'];
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    try {
      _token = null;
      _tAccountId = null;
      _expiryDate = null;
      if (_authTimer != null) {
        _authTimer!.cancel();
        _authTimer = null;
      }
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('userData');

      ZohoSalesIQ.unregisterVisitor();

      await ZohoSalesIQ.getChats().then((chatList) {
        chatList.map((element) {
          print(element.id);
        }).toList();
      }).catchError((err) => print(err));
    } catch (e) {
      rethrow;
    }
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(
      Duration(seconds: timeToExpiry),
      logout,
    );
  }
}
