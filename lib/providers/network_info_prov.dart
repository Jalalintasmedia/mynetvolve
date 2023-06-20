import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mynetvolve/core/constants.dart';
import 'package:mynetvolve/models/http_exception.dart';
import 'package:mynetvolve/models/network_info.dart';

class NetworkInfoProv with ChangeNotifier {
  // NetworkInfo? _networkInfo;
  final String? tAccountId;

  NetworkInfoProv(this.tAccountId);

  // NetworkInfo? get networkInfo => _networkInfo;

  Future<NetworkInfo> getNetworkInfo() async {
    final url = Uri.parse(IBOSS_API_URL + '/ibossapi');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'act': 'getnetworkinfo',
          't_account_id': tAccountId,
        }),
      );

      Map<String?, dynamic> networkInfoMap = json.decode(response.body);
      print(networkInfoMap);

      if(networkInfoMap['result'] != '00') {
        throw HttpException('Error fetching data');
      }

      var networkInfoData = networkInfoMap['data'];
      return NetworkInfo.fromJson(networkInfoData);
    } catch (e) {
      print('GET NETWORK INFO ERROR: $e');
      return NetworkInfo(accountStatus: '', deviceState: '');
    }
  }
}
