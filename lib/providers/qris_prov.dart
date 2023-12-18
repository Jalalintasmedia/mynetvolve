import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mynetvolve/models/payment.dart';

import '../core/constants.dart';

class QrisProv with ChangeNotifier {
  // List<GeneratedQr>? _qrList;
  Qris? _qris;
  Qris2? _qris2;
  AlfamartPayment? _alfamartPayment;
  VAPayment? _vaPayment;
  CreditCardPayment? _ccPayment;
  AkuLakuPayment? _akuLakuPayment;
  final String? token;
  final String? timeStamp;
  final String? tAccountId;

  QrisProv(
    this.token,
    this.timeStamp,
    this.tAccountId,
    this._qris,
    this._qris2,
    this._alfamartPayment,
    this._vaPayment,
    this._ccPayment,
    this._akuLakuPayment,
  );

  Qris? get qris => _qris;

  Qris2? get qris2 => _qris2;

  AlfamartPayment? get alfamartPayment => _alfamartPayment;

  VAPayment? get vaPayment => _vaPayment;

  CreditCardPayment? get creditCardPayment => _ccPayment;

  AkuLakuPayment? get akuLakuPayment => _akuLakuPayment;

  Future<void> generateQris({
    required String accountNo,
    required String invoiceNo,
    required int amount,
    required String tIspId,
  }) async {
    final url = Uri.parse('$PG_XENDIT_API_URL/qris-netvolve.php');
    print(
      '===== t_account_id: $tAccountId, account_no: $accountNo, invoice_no: $invoiceNo, amount: $amount, tIspId: $tIspId',
    );
    try {
      final response = await http.post(
        url,
        headers: {
          // 'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: json.encode(
          {
            'act': 'generate',
            't_account_id': tAccountId,
            'account_no': accountNo,
            'mod': 'by_invoice',
            'invoiceNo': invoiceNo,
            'amount': amount,
            't_isp_id': tIspId,
          },
        ),
      );
      print('===== ${response.body}');
      final responseData = json.decode(response.body);
      if (responseData['code'] != '0000') {
        if (responseData['code'] == '0005') {
          throw ('Silakan coba beberapa saat lagi');
        }
        throw (responseData['msg']);
      }

      Map<String?, dynamic> qrisMap = responseData['data'];
      _qris2 = Qris2.fromJson(qrisMap);
      print(
          '===== QR ID: ${_qris2!.qrId}, EXTERNAL ID: ${_qris2!.externalId}, QR STRING: ${_qris2!.qrString}');
    } catch (e) {
      print('===== QRIS ERROR: $e');
      rethrow;
    }
  }

  Future<void> generateAlfamartCode({
    required String accountNo,
    required String name,
    required String invoiceNo,
    required int amount,
    required String tIspId,
  }) async {
    print(
      '===== generate alfamart prov CALLED. t_isp_id: $tIspId, tAccountId: $tAccountId, account no: $accountNo, name: $name, invoice no: $invoiceNo, amount: $amount',
    );
    final url = Uri.parse('$PG_XENDIT_API_URL/otc-netvolve.php');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'act': 'generate',
            't_account_id': tAccountId,
            'account_no': accountNo,
            'fullname': name,
            'mod': 'by_invoice',
            'invoiceNo': invoiceNo,
            'amount': amount,
            't_isp_id': tIspId,
          },
        ),
      );
      print('===== ALFAMART: ${response.body}');
      final responseData = json.decode(response.body);
      if (responseData['code'] != '0000') {
        if (responseData['code'] == '0005') {
          throw ('Silakan coba beberapa saat lagi');
        }
        throw (responseData['msg']);
      }

      Map<String?, dynamic> extractedData = responseData['data'];
      _alfamartPayment = AlfamartPayment.fromJson(extractedData);
      print(
          '===== alfamart ID: ${_alfamartPayment!.paymentId}, EXTERNAL ID: ${_alfamartPayment!.externalId}, QR STRING: ${_alfamartPayment!.paymentCode}');
    } catch (e) {
      print('===== ALFAMART ERROR: $e');
      rethrow;
    }
  }

  Future<void> generateVACode({
    required String accountNo,
    required String name,
    required String email,
    required String invoiceNo,
    required int amount,
    required String tIspId,
    required String bankType,
  }) async {
    final url = Uri.parse('$PG_API_URL/va.php');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'act': 'generate',
            't_account_id': tAccountId,
            'account_no': accountNo,
            'mod': 'by_invoice',
            'invoiceNo': invoiceNo,
            'fullname': name,
            't_isp_id': tIspId,
            'amount': amount,
            'bankType': bankType,
            'customerEmail': email,
          },
        ),
      );
      print('===== VA $bankType: ${response.body}');
      final responseData = json.decode(response.body);
      if (responseData['code'] != '0000') {
        if (responseData['code'] == '0005') {
          throw ('Silakan coba beberapa saat lagi');
        }
        throw (responseData['msg']);
      }

      Map<String?, dynamic> extractedData = responseData['data'];
      _vaPayment = VAPayment.fromJson(extractedData);
    } catch (e) {
      print('===== VA $bankType ERROR: $e');
      rethrow;
    }
  }

  Future<void> generateCreditCardPayment({
    required String accountNo,
    required String invoiceNo,
    required String name,
    required String tIspId,
    required int amount,
    required String email,
  }) async {
    final url = Uri.parse('$PG_API_URL/cc-dev.php');
    try {
      print({
        'act': 'generate',
        't_account_id': tAccountId,
        'account_no': accountNo,
        'mod': 'by_invoice',
        'invoiceNo': invoiceNo,
        'fullname': name,
        't_isp_id': tIspId,
        'amount': amount,
        'customerEmail': email,
      });
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'act': 'generate',
            't_account_id': tAccountId,
            'account_no': accountNo,
            'mod': 'by_invoice',
            'invoiceNo': invoiceNo,
            'fullname': name,
            't_isp_id': tIspId,
            'amount': amount,
            'customerEmail': email,
          },
        ),
      );
      print('===== CC PAYMENT: ${response.body}');
      final responseData = json.decode(response.body);
      if (responseData['code'] != '0000') {
        if (responseData['code'] == '0005') {
          throw ('Silakan coba beberapa saat lagi');
        }
        throw (responseData['msg']);
      }

      Map<String?, dynamic> extractedData = responseData['data'];
      _ccPayment = CreditCardPayment.fromJson(extractedData);
    } catch (e) {
      print('===== CC PAYMENT ERROR: $e');
      rethrow;
    }
  }

  Future<void> generateAkuLakuPayment({
    required String accountNo,
    required String invoiceNo,
    required String name,
    required String tIspId,
    required int amount,
    required String email,
    required String phoneNumber,
  }) async {
    final url = Uri.parse('$PG_API_URL/akulaku.php');
    try {
      print({
        'act': 'generate',
        't_account_id': tAccountId,
        'account_no': accountNo,
        'mod': 'by_invoice',
        'invoiceNo': invoiceNo,
        'fullname': name,
        't_isp_id': tIspId,
        'amount': amount,
        'customerEmail': email,
        'phoneNumber': phoneNumber,
      });
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'act': 'generate',
            't_account_id': tAccountId,
            'account_no': accountNo,
            'mod': 'by_invoice',
            'invoiceNo': invoiceNo,
            'fullname': name,
            't_isp_id': tIspId,
            'amount': amount,
            'customerEmail': email,
        'phoneNumber': phoneNumber,
          },
        ),
      );
      print('===== AKULAKU PAYMENT: ${response.body}');
      final responseData = json.decode(response.body);
      if (responseData['code'] != '0000') {
        if (responseData['code'] == '0005') {
          throw ('Silakan coba beberapa saat lagi');
        }
        throw (responseData['msg']);
      }

      Map<String?, dynamic> extractedData = responseData['data'];
      _akuLakuPayment = AkuLakuPayment.fromJson(extractedData);
    } catch (e) {
      print('===== AKULAKU PAYMENT ERROR: $e');
      rethrow;
    }
  }
}
