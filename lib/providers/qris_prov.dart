import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../core/constants.dart';
import '../models/qris.dart';

class QrisProv with ChangeNotifier {
  // List<GeneratedQr>? _qrList;
  Qris? _qris;
  Qris2? _qris2;
  AlfamartPayment? _alfamartPayment;
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
  );

  Qris? get qris => _qris;

  Qris2? get qris2 => _qris2;

  AlfamartPayment? get alfamartPayment => _alfamartPayment;

  Future<void> generateNewQris() async {
    final url = Uri.parse(IBOSS_API_URL + '/qrisapi');
    try {
      // List<GeneratedQr>? _qrList = await _getQristList();
      // if ((_qrList![0].qrId == _qris!.qrId) &&
      //     (_qrList[0].status == 'GENERATE')) {
      //   _qris = _qris;
      // } else {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            "act": "generate",
            "t_account_id": tAccountId,
            "mod": 'by_invoice',
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['code'] != '0000') {
        if (responseData['code'] == '0005') {
          throw ('Silakan coba beberapa saat lagi');
        }
        // else if (responseData['code'] == '0041') {
        //   throw
        // }
        throw (responseData['msg']);
      }

      var expiryTime = DateTime.now().add(const Duration(hours: 1));

      Map<String?, dynamic> qrisMap = responseData['data'];
      _qris = Qris.fromJson(qrisMap, expiryTime);
      // }
    } catch (e) {
      _qris = Qris(
        amount: 0,
        merchantType: '',
        idPel: '',
        productId: '',
        qrText: '',
        qrId: '',
        billAmount: 0,
        admin: 0,
        img: '',
        rc: '',
        status: '',
        expiryTime: DateTime.now(),
      );
      rethrow;
    }
  }

  Future<void> generateQris({
    required String accountNo,
    required String invoiceNo,
    required int amount,
  }) async {
    final url = Uri.parse(PG_API_URL + '/qris.php');
    print(
        '===== t_account_id: $tAccountId, account_no: $accountNo, invoice_no: $invoiceNo, amount: $amount');
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

  // Future<List<GeneratedQr>?> getQristList() async {
  //   final url = Uri.parse(IBOSS_API_URL + '/qrisapi');
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //       body: json.encode(
  //         {
  //           "act": "getqrlist",
  //           "time": timeStamp,
  //           "t_account_id": tAccountId,
  //         },
  //       ),
  //     );

  //     final List<GeneratedQr> loadedQrList = [];
  //     final extractedData = json.decode(response.body)['data'] as List;

  //     extractedData.map((qris) {
  //       var qrisData = GeneratedQr.fromJson(qris);
  //       loadedQrList.add(qrisData);
  //     }).toList();
  //     return loadedQrList;
  //   } catch (e) {
  //     return [];
  //   }
  // }

  Future<void> generateAlfamartCode({
    required String accountNo,
    required String name,
    required String invoiceNo,
    required int amount,
    required String tIspId,
  }) async {
    print('===== generate alfamart prov CALLED. t_isp_id: $tIspId');
    final url = Uri.parse(PG_API_URL + '/otc.php');
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
            't_isp_id': 2,
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
          '===== QR ID: ${_alfamartPayment!.paymentId}, EXTERNAL ID: ${_alfamartPayment!.externalId}, QR STRING: ${_alfamartPayment!.paymentCode}');
    } catch (e) {
      print('===== QRIS ERROR: $e');
      rethrow;
    }
  }
}
