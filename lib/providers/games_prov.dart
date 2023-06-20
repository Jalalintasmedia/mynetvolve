import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mynetvolve/core/constants.dart';
import 'package:mynetvolve/models/game.dart';
import 'package:mynetvolve/models/http_exception.dart';

class GamesProv with ChangeNotifier {
  List<Game>? _gamesList;
  List<GameReward>? _gameRewards;
  final String? token;
  final String? timeStamp;
  final String? tAccountId;

  GamesProv(
    this.token,
    this.tAccountId,
    this.timeStamp,
    this._gamesList,
    this._gameRewards,
  );

  List<Game>? get gamesList => _gamesList;

  List<GameReward>? get gameRewards => _gameRewards;

  List<GameReward>? get freeGames => _gameRewards!
      .where((game) => !game.gameName.contains('CHOOSE ONE'))
      .toList();

  List<GameReward>? get chooseOneGames => _gameRewards!
      .where((game) => game.gameName.contains('CHOOSE ONE'))
      .toList();

  final url = Uri.parse(API_GATEWAY_2 + '/otello/api');

  Future<void> getGamesList() async {
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'reqtype': 'getlistgames',
        }),
      );
      print(response.body);

      if (response.body == '') {
        throw HttpException('Error fetching games list');
      }

      final List<Game> loadedGames = [];
      final responseJson = json.decode(response.body) as Map<String?, dynamic>;

      if (responseJson['status'] != 200) {
        throw HttpException(responseJson['message']);
      }

      final extractedData = responseJson['data'] as List;

      for (var json in extractedData) {
        loadedGames.add(Game.fromJson(json));
      }
      _gamesList = loadedGames;
    } catch (e) {
      print('===== GET GAMES ERROR: $e');
      rethrow;
    }
  }

  Future<void> getGameRewardList({
    required String customerCode,
    required String packageCode,
  }) async {
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'reqtype': 'getlistrewards',
          'customer_code': customerCode,
          'package_code': packageCode,
        }),
      );
      print(response.body);

      if (response.body == '') {
        throw HttpException('Error fetching games list');
      }

      final List<GameReward> loadedGameRewards = [];
      final responseJson = json.decode(response.body) as Map<String?, dynamic>;

      if (responseJson['status'] != 200) {
        throw HttpException(responseJson['message']);
      }

      final extractedData = responseJson['data'] as List;

      for (var json in extractedData) {
        loadedGameRewards.add(GameReward.fromJson(json));
      }
      _gameRewards = loadedGameRewards;
    } catch (e) {
      print('===== GET GAMES ERROR: $e');
      rethrow;
    }
  }

  Future<String> claimGameReward({
    required String customerCode,
    required String packageCode,
    required String gameCode,
  }) async {
    var voucherCode = '';
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'reqtype': 'getclaimrewards',
          'customer_code': customerCode,
          'package_code': packageCode,
          'game_code': gameCode,
        }),
      );
      print(response.body);
      if (response.body == '') {
        throw HttpException('Error fetching games list');
      }

      final responseJson = json.decode(response.body) as Map<String?, dynamic>;
      if (responseJson['status'] != 200) {
        throw HttpException(responseJson['message']);
      }
      voucherCode = responseJson['data']['VoucherCode'];
      notifyListeners();
      return voucherCode;
    } catch (e) {
      rethrow;
    }
  }
}
