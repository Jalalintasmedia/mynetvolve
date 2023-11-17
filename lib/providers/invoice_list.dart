import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mynetvolve/models/efaktur.dart';
import 'package:mynetvolve/models/http_exception.dart';
import 'package:mynetvolve/models/payment.dart';

import '../models/invoice.dart';
import '../core/constants.dart';

class InvoiceList with ChangeNotifier {
  List<Invoice>? _invoices;
  List<InvoiceDetail>? _invoiceDetails;
  Payment? _payment;
  Efaktur? _efaktur;
  final String? token;
  final String? timeStamp;
  final String? tAccountId;

  InvoiceList(
    this.token,
    this.timeStamp,
    this.tAccountId,
    this._invoices,
  );

  List<Invoice>? get invoices {
    return _invoices;
  }

  List<InvoiceDetail>? get invoiceDetails {
    return _invoiceDetails;
  }

  Payment? get payment {
    return _payment;
  }

  Efaktur? get efaktur {
    return _efaktur;
  }

  Invoice findById(String id) {
    return _invoices!.firstWhere((invoice) => invoice.tInvoiceId == id);
  }

  Invoice findByNo(String invoiceNo) {
    return _invoices!.firstWhere((invoice) => invoice.invoiceNo == invoiceNo);
  }

  Invoice? latestInvoice() {
    return _invoices![0];
  }

  List<Invoice> unpaidInvoices() {
    if (_invoices!.any((invoice) => invoice.isPaid == 'N')) {
      return (_invoices!.where((invoice) => invoice.isPaid == 'N')).toList();
    } else {
      return [];
    }
  }

  Future<void> getInvoices() async {
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
            "act": "getinvoicelist",
            "time": timeStamp,
            "t_account_id": tAccountId,
          },
        ),
      );

      final List<Invoice> loadedInvoices = [];
      final extractedData = json.decode(response.body)['data'] as List;

      if (extractedData.isEmpty) {
        throw HttpException('Data Null');
      }

      extractedData.map((invoice) {
        var invoiceData = Invoice.fromJson(invoice);
        loadedInvoices.add(invoiceData);
      }).toList();
      _invoices = loadedInvoices.toList();
    } catch (e) {
      _invoices = [];
      rethrow;
    }
  }

  Future<void> getInvoiceInfo(String tInvoiceId) async {
    final url = Uri.parse(IBOSS_API_URL + '/ibossapi');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          "act": "getinvoiceinfo",
          "time": timeStamp,
          "t_account_id": tAccountId,
          "t_invoice_id": tInvoiceId,
        },
      ),
    );
    final List<InvoiceDetail> loadedDetails = [];
    // print('INVOICE DETAIL: ${json.decode(response.body)['data']}');
    final invoiceDetailList =
        json.decode(response.body)['data']['detail'] as List;
    invoiceDetailList.map((detail) {
      loadedDetails.add(InvoiceDetail.fromJson(detail));
    }).toList();
    _invoiceDetails = loadedDetails;

    await getPayment(response.body);
    await getEfaktur(response.body, url);
  }

  Future<void> getPayment(String responseBody) async {
    try {
      Map<String?, dynamic> paymentData =
          json.decode(responseBody)['data']['payment'];
      print(json.decode(responseBody)['data']['payment']);
      _payment = Payment.fromJson(paymentData);
    } catch (e) {
      print('error: $e');
      _payment = Payment(
        tPaymentId: '',
        transactionDate: '',
        trxNo: '',
        paymentChannel: '',
      );
    }
  }

  Future<void> getEfaktur(String responseBody, Uri url) async {
    try {
      Map<String?, dynamic> efakturData =
          json.decode(responseBody)['data']['efaktur'];

      final fileResponse = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            "act": "getfile",
            "time": timeStamp,
            "t_account_id": tAccountId,
            "t_efaktur_id": efakturData['t_efaktur_id'],
            "t_file_id": efakturData['t_file_id'],
            "type": "EFAKTUR",
          },
        ),
      );

      Map<String?, dynamic> efakturFileData =
          json.decode(fileResponse.body)['data'];
      Map<String?, dynamic> combineMap = {};
      combineMap.addAll(efakturData);
      combineMap.addAll(efakturFileData);
      combineMap['name'] = efakturData['name'];

      _efaktur = Efaktur.fromJson(combineMap);
    } catch (e) {
      print('error efaktur: $e');
      _efaktur = Efaktur(
        tEfakturId: '',
        tFileId: '',
        nofa: '',
        name: '',
        releaseDate: '',
        ext: '',
        type: '',
        content: '',
      );
    }
  }

  Future<void> sendInvoiceToEmail(
      List<String> invoicePeriods, String email) async {
    final url = Uri.parse(IBOSS_API_URL + '/invoice');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            "periode": invoicePeriods,
            "time": timeStamp,
            "t_account_id": tAccountId,
            "email": email,
          },
        ),
      );
      print('===== ${response.body}');
    } catch (e) {
      rethrow;
    }
  }
}
