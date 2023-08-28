class Efaktur {
  final String tEfakturId;
  final String tFileId;
  final String nofa;
  final String name;
  final String releaseDate;
  final String ext;
  final String type;
  final String content;

  Efaktur({
    required this.tEfakturId,
    required this.tFileId,
    required this.nofa,
    required this.name,
    required this.releaseDate,
    required this.ext,
    required this.type,
    required this.content,
  });

  Efaktur.fromJson(Map<String?, dynamic> json)
      : tEfakturId = json['t_efaktur_id'] ?? '',
        tFileId = json['t_file_id'] ?? '',
        nofa = json['nofa'] ?? '',
        name = json['name'] ?? '',
        releaseDate = json['release_date'] ?? '',
        ext = json['ext'] ?? '',
        type = json['type'] ?? '',
        content = json['content'] ?? '';
  
  Map<String?, dynamic> toJson() => {
    't_efaktur_id': tEfakturId,
    't_file_id': tFileId,
    'nofa': nofa,
    'name': name,
    'release_date': releaseDate,
    'ext': ext,
    'type': type,
    'content': content,
  };
}

// class EfakturFile {
//   final String tFileId;
//   final String name;
//   final String ext;

// }
