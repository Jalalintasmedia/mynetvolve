import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../core/constants.dart';
import '../models/faq2.dart';

class FaqProvs with ChangeNotifier {
  List<Faq2>? _faqs;

  List<Faq2>? get faqs {
    return _faqs;
  }

  Future<void> getFaq() async {
    final url = Uri.parse(BNETFIT_API_URL + '/faq');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "key": "98294",
          "time": "1672980687",
          "t_account_id": "66842",
        }),
      );

      final List<Faq2> loadedFaqs = [];
      final extractedData = json.decode(response.body)['data'] as List;

      extractedData.map((faq) {
        if (faq['is_active'] == true) {
          var faqData = Faq2.fromJson(faq);
          loadedFaqs.add(faqData);
        }
      }).toList();
      _faqs = loadedFaqs.toList();
    } catch (e) {
      rethrow;
    }
  }
}
