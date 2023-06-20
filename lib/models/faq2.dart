class Faq2 {
  final int id;
  final String titleInd;
  final String titleEng;
  final String descriptionInd;
  final String descriptionEng;
  final String picture;

  Faq2({
    required this.id,
    required this.titleInd,
    required this.titleEng,
    required this.descriptionInd,
    required this.descriptionEng,
    required this.picture,
  });

  Faq2.fromJson(Map<String?, dynamic> json)
      : id = json['id'] ?? '',
        titleInd = json['title_ind'] ?? '',
        titleEng = json['title_eng'] ?? '',
        descriptionInd = json['description_ind'] ?? '',
        descriptionEng = json['description_eng'] ?? '',
        picture = json['picture'] ?? '';

  Map<String?, dynamic> toJson() => {
        'id': id,
        'title_ind': titleInd,
        'title_eng': id,
        'description_ind': descriptionInd,
        'description_eng': descriptionEng,
        'picture': picture,
      };

  static List<Faq2> staticFaqs = [
    Faq2(
      id: 0,
      titleInd: 'Apa itu bnetfit',
      titleEng: 'Apa itu bnetfit',
      descriptionInd: ' ',
      descriptionEng: ' ',
      picture: '',
    ),
    Faq2(
      id: 1,
      titleInd: 'Apa itu add on',
      titleEng: 'Apa itu add on',
      descriptionInd: ' ',
      descriptionEng: ' ',
      picture: '',
    ),
    Faq2(
      id: 2,
      titleInd: 'Kenapa koneksi internet lambat?',
      titleEng: 'Kenapa koneksi internet lambat?',
      descriptionInd: ' ',
      descriptionEng: ' ',
      picture: '',
    ),
    Faq2(
      id: 3,
      titleInd: 'Apakah dapat digunakan untuk bisnis dan perusahaan?',
      titleEng: 'Apakah dapat digunakan untuk bisnis dan perusahaan?',
      descriptionInd: ' ',
      descriptionEng: ' ',
      picture: '',
    ),
    Faq2(
      id: 4,
      titleInd: 'Apakah kecepatan internet akan selalu konstan setiap hari?',
      titleEng: 'Apakah kecepatan internet akan selalu konstan setiap hari?',
      descriptionInd: ' ',
      descriptionEng: ' ',
      picture: '',
    ),
    Faq2(
      id: 5,
      titleInd:
          'Apakah instalasi bnetfit dapat dilakukan di pusat perbelanjaan atau mall?',
      titleEng:
          'Apakah instalasi bnetfit dapat dilakukan di pusat perbelanjaan atau mall?',
      descriptionInd: ' ',
      descriptionEng: ' ',
      picture: '',
    ),
  ];
}
