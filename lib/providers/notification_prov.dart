import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../core/constants.dart';
import '../models/notification.dart';

class NotificationProv with ChangeNotifier {
  List<CustNotification>? _notifications;
  final String? token;
  final String? timeStamp;
  final String? tAccountId;

  NotificationProv(
    this.token,
    this.timeStamp,
    this.tAccountId,
    this._notifications,
  );

  List<CustNotification>? get notifications {
    return _notifications;
  }

  Future<void> getNotifications() async {
    final url = Uri.parse(IBOSS_API_URL+'/ibossapi');
    try {
      final response = await http.post(
        url,
        headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
        body: json.encode(
          {
            "act": "getnotiflist",
            "t_account_id": tAccountId,
          },
        ),
      );
      // print(response.body);
      final List<CustNotification> loadedNotifications = [];
      final extractedData = json.decode(response.body)['data'] as List;

      extractedData.map((notif) {
        var notifData = CustNotification.fromJson(notif);
        loadedNotifications.add(notifData);
      }).toList();
      _notifications = loadedNotifications;
    } catch (e) {
      _notifications = [];
    }
  }
}
