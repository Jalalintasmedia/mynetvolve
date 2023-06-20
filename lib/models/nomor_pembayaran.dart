class NomorPembayaran {
  final String nama;
  final String image;
  final String nomor;

  NomorPembayaran({
    required this.nama,
    required this.image,
    required this.nomor,
  });

  static List<NomorPembayaran> qrList = [
    NomorPembayaran(
      nama: 'QR Code',
      image: 'QRIS-logo.svg.png',
      nomor: '',
    ),
  ];

  static List<NomorPembayaran> vaList = [
    NomorPembayaran(
      nama: 'Virtual Account Mandiri',
      image: 'mandiri-logo.png',
      nomor: '8891897',
    ),
    NomorPembayaran(
      nama: 'Virtual Account Danamon',
      image: 'danamon-logo.png',
      nomor: '8880097',
    ),
    NomorPembayaran(
      nama: 'Virtual Account BCA',
      image: 'bca-logo.png',
      nomor: '1068597',
    ),
  ];

  static List<NomorPembayaran> counterList = [
    NomorPembayaran(
      nama: 'Indomaret',
      image: 'indomaret-logo.png',
      nomor: '',
    ),
  ];
}
