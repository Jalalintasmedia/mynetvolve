import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mynetvolve/core/constants.dart';
import 'package:http/http.dart' as http;
import 'package:mynetvolve/models/tiket.dart';

import '../helpers/get_ip_address.dart';

class TicketProvider with ChangeNotifier {
  List<Tiket>? _tickets;
  final String? tAccountId;

  TicketProvider(this.tAccountId, this._tickets);

  List<Tiket>? get tickets => _tickets;

  Future<void> getTickets() async {
    final url = Uri.parse(IBOSS_API_URL + '/ibossapi');
    final ipAddress = await getIPAddress();
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'act': 'getticketlist',
          't_account_id': tAccountId,
          'ip_address': ipAddress,
        }),
      );
      print(response.body);
      final List<Tiket> loadedTickets = [];
      final extractedData = json.decode(response.body)['data'] as List;
      if(extractedData.isEmpty) {
        _tickets = loadedTickets;
        return;
      }

      extractedData.map((ticket) {
        var ticketData = Tiket.fromJson(ticket);
        loadedTickets.add(ticketData);
      }).toList();

      print(loadedTickets);
      _tickets = loadedTickets;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
