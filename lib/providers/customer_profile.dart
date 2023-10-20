import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mynetvolve/models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart' as qscs;

import '../helpers/get_ip_address.dart';
import '../models/customer.dart';
import '../core/constants.dart';

class CustomerProfile with ChangeNotifier {
  CustomerSummary? _customer;
  final String? token;
  final String? timeStamp;
  final String? tAccountId;

  CustomerProfile(
    this.token,
    this.timeStamp,
    this.tAccountId,
    this._customer,
  );

  CustomerSummary? get customer {
    return _customer;
  }

  bool? get custFingerprintActive {
    return _customer!.activateFingerprint;
  }

  Future<void> getUserProfile() async {
    final url = Uri.parse(IBOSS_API_URL + '/ibossapi');
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            "act": "getcustomersmry",
            "time": timeStamp,
            "t_account_id": tAccountId,
          },
        ),
      );
      Map<String?, dynamic> customerMap = jsonDecode(response.body);
      // print(customerMap);

      if (customerMap['result'] != '00' ||
          customerMap['data'][0]['invoice_no'] == null) {
        _customer = CustomerSummary(
          accountNo: '',
          accountName: '',
          accountEmail: '',
          accountHp: '',
          accountAddress1: '',
          accountAddress2: '',
          emailVerified: 'N',
          mobilePhoneVerified: 'N',
          accountStatus: '',
          accountBlockDate: '',
          invoiceNo: '',
          currentBalance: '',
          description: '',
          dueDate: '',
          periodEndDate: '',
          periodStartDate: '',
          statementDate: '',
          profileFileId: '',
          pictExt: '',
          pictType: '',
          pictContent: '',
          activateFingerprint: false,
          tIspId: '',
        );
        throw HttpException(customerMap['msg']);
      }

      var customerData = customerMap['data'][0];
      final prefs = await SharedPreferences.getInstance();
      bool active;
      if (!prefs.containsKey('activate_fingerprint')) {
        active = true;
      } else {
        active = prefs.getBool('activate_fingerprint')!;
      }
      _customer = CustomerSummary.fromJson(customerData, active);
      print(
          '===== ${_customer!.accountNo}, $tAccountId, ${_customer!.accountName} - ${_customer!.accountNo}');

      // // QISCUS DATA
      // final qiscus = qscs.QiscusSDK();
      // final cust = _customer!;
      // await qiscus.setUser(
      //   userId: cust.accountNo,
      //   userKey: '$tAccountId',
      //   username: '${cust.accountName} - ${cust.accountNo}',
      // );
      
      notifyListeners();
    } catch (e) {
      print('===== $e');
      _customer = CustomerSummary(
        accountNo: '',
        accountName: '',
        accountEmail: '',
        accountHp: '',
        accountAddress1: '',
        accountAddress2: '',
        emailVerified: 'N',
        mobilePhoneVerified: 'N',
        accountStatus: '',
        accountBlockDate: '',
        invoiceNo: '',
        currentBalance: '',
        description: '',
        dueDate: '',
        periodEndDate: '',
        periodStartDate: '',
        statementDate: '',
        profileFileId: '',
        pictExt: '',
        pictType: '',
        pictContent: '',
        activateFingerprint: false,
        tIspId: '',
      );
      rethrow;
    }
  }

  Future<void> setFingerprintBool(bool newValue) async {
    customer!.activateFingerprint = newValue;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('activate_fingerprint', newValue);
    notifyListeners();
  }

  Future<void> requestOTP(String otpPin, String name, String email) async {
    final url = Uri.parse(IBOSS_API_URL + '/otp');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            "otp": otpPin,
            "name": name,
            "email": email,
            "key": "92989",
            "t_account_id": tAccountId,
          },
        ),
      );

      final responseData = json.decode(response.body);

      if (responseData['status'] != 200) {
        throw HttpException(responseData['msg']);
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> requestOTPMobile(String otpPin, String name, String noHp) async {
    final url = Uri.parse(IBOSS_API_URL + '/otp/phone');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            "otp": otpPin,
            "name": name,
            "number": noHp,
            "key": "92989",
            "t_account_id": tAccountId,
          },
        ),
      );

      final responseData = json.decode(response.body);
      // print(responseData['status']);
      if (responseData['status'] != 200) {
        throw HttpException(responseData['msg']);
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setEmailVerifiedStatus(String isVerified) async {
    final url = Uri.parse(IBOSS_API_URL + '/ibossapi');
    final ipAddress = await getIPAddress();
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            "act": 'userset',
            "t_account_id": tAccountId,
            "email_verified": isVerified,
            "ip_address": ipAddress,
          },
        ),
      );

      final responseData = json.decode(response.body);
      if (responseData['result'] != '00') {
        throw HttpException(responseData['msg']);
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setMobileVerifiedStatus(String isVerified) async {
    final url = Uri.parse(IBOSS_API_URL + '/ibossapi');
    final ipAddress = await getIPAddress();
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            "act": 'userset',
            "t_account_id": tAccountId,
            "mobile_phone_verified": isVerified,
            "ip_address": ipAddress,
          },
        ),
      );

      final responseData = json.decode(response.body);
      if (responseData['result'] != '00') {
        throw HttpException(responseData['msg']);
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changePassword(String newPass) async {
    final url = Uri.parse(IBOSS_API_URL + '/ibossapi');
    final ipAddress = await getIPAddress();
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "act": 'userset',
          "t_account_id": tAccountId,
          "password": newPass,
          "ip_address": ipAddress,
        }),
      );

      final responseData = json.decode(response.body);
      if (responseData['result'] != '00') {
        throw HttpException(responseData['msg']);
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changeEmail(String newEmail) async {
    final url = Uri.parse(IBOSS_API_URL + '/ibossapi');
    final ipAddress = await getIPAddress();
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            "act": 'userset',
            "t_account_id": tAccountId,
            "email": newEmail,
            "email_verified": "N",
            "ip_address": ipAddress,
          },
        ),
      );

      final responseData = json.decode(response.body);
      if (responseData['result'] != '00') {
        throw HttpException(responseData['msg']);
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> checkCustomer(
      String accountNo, String email) async {
    final url = Uri.parse(IBOSS_API_URL + '/ibossapi');
    final ipAddress = await getIPAddress();
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            "act": 'usercheck',
            "account_no": accountNo,
            "email": email,
            "ip_address": ipAddress,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['result'] != '00') {
        return {
          'isValid': false,
          'tAccountId': '',
        };
      }
      return {
        'isValid': true,
        'tAccountId': responseData['data']['t_account_id'],
      };
    } catch (e) {
      print(e);
      return {
        'isValid': false,
        'tAccountId': '',
      };
    }
  }

  Future<void> resetPassword(String accountNo, String newPass) async {
    final url = Uri.parse(IBOSS_API_URL + '/ibossapi');
    final ipAddress = await getIPAddress();
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "act": 'userset',
          "t_account_id": accountNo,
          "password": newPass,
          "email_verified": 'Y',
          "ip_address": ipAddress,
        }),
      );
      final responseData = json.decode(response.body);
      print('RESET PASSWORD: $responseData');
      if (responseData['result'] != '00') {
        throw HttpException(responseData['msg']);
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setProfilePic(String base64Img) async {
    final url = Uri.parse(IBOSS_API_URL + '/ibossapi');
    final ipAddress = await getIPAddress();
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "act": 'userset',
          "t_account_id": tAccountId,
          "pict": base64Img,
          "ip_address": ipAddress,
        }),
      );

      final responseData = json.decode(response.body);
      if (responseData['result'] != '00') {
        throw HttpException(responseData['msg']);
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
