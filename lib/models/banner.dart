class PromoBanner {
  final int id;
  final String pathBanner;
  final String titleInd;
  final String titleEng;
  final String descriptionInd;
  final String descriptionEng;
  final String urlInd;
  final String urlEng;
  final bool isActive;
  final int seq;

  PromoBanner({
    required this.id,
    required this.pathBanner,
    required this.titleInd,
    required this.titleEng,
    required this.descriptionInd,
    required this.descriptionEng,
    required this.urlInd,
    required this.urlEng,
    required this.isActive,
    required this.seq,
  });

  PromoBanner.fromJson(Map<String?, dynamic> json)
    : id = json['id'] ?? 0,
      pathBanner = json['path_banner'] ?? '',
      titleInd = json['title_ind'] ?? '',
      titleEng = json['title_eng'] ?? '',
      descriptionInd = json['description_ind'] ?? '',
      descriptionEng = json['description_eng'] ?? '',
      urlInd = json['url_ind'] ?? '',
      urlEng = json['url_eng'] ?? '',
      isActive = json['is_active'] == 1 ? true : false,
      seq = json['seq'] ?? 0;
}

class CarouselBanner {
  final int id;
  final String name;
  final String fileType;
  final String pathBanner;
  final String url;
  final int seq;
  final bool isActive;
  final String publishDate;
  final String expiredDate;

  CarouselBanner({
    required this.id,
    required this.name,
    required this.fileType,
    required this.pathBanner,
    required this.url,
    required this.seq,
    required this.isActive,
    required this.publishDate,
    required this.expiredDate,
  });

  CarouselBanner.fromJson(Map<String?, dynamic> json)
    : id = json['id'] ?? 0,
      name = json['name'] ?? '',
      fileType = json['file_type'] ?? '',
      pathBanner = json['path_banner'] ?? '',
      url = json['url'] ?? '',
      seq = json['seq'] ?? 0,
      isActive = json['is_active'] == 1 ? true : false,
      publishDate = json['publish_date'] ?? '',
      expiredDate = json['expired_date'] ?? '';
  
  Map<String?, dynamic> toJson() => {
    'id': id,
    'name': name,
    'file_type': fileType,
    'path_banner': pathBanner,
    'url': url,
    'seq': seq,
    'is_active': isActive,
    'publish_date': publishDate,
    'expired_date': expiredDate,
  };
}