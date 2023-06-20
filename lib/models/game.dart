class Game {
  String gameCode;
  String publisherCode;
  String gameName;
  String description1;
  String description2;

  Game.fromJson(Map<String?, dynamic> json)
      : gameCode = json['game_code'] ?? '',
        publisherCode = json['publisher_code'] ?? '',
        gameName = json['game_name'] ?? '',
        description1 = json['description1'] ?? '',
        description2 = json['description2'] ?? '';
}

class GameReward {
  String gameCode;
  String gameName;
  String gamePicture;
  String gameTNC;
  bool isClaim;
  DateTime? isClaimDate;

  GameReward.fromJson(Map<String?, dynamic> json)
      : gameCode = json['GameCode'] ?? '',
        gameName = json['GameName'] ?? '',
        gamePicture = json['GamePicture'] ?? '',
        gameTNC = json['GameTNC'] ?? '',
        isClaim = json['isClaim'] == '1' ? true : false,
        isClaimDate = json['isClaimDate'] != null
            ? DateTime.parse(json['isClaimDate'])
            : null;
}
