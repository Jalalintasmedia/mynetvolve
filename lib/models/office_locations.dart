class OfficeLocation {
  final String officeName;
  final String address;
  final double latitude;
  final double longitude;

  OfficeLocation({
    required this.officeName,
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}

List<OfficeLocation> OFFICE_LOCATIONS = [
  OfficeLocation(
    officeName: 'Head Office',
    address: 'Jl. Mayor Oking Jaya Atmajaya No.89 KM2 Cibinong Bogor 16918',
    latitude: -6.477875088607771, 
    longitude: 106.86357518184066,
  ),
  OfficeLocation(
    officeName: 'Jakarta',
    address: 'Gedung Graha Dirgantara Lt. GF Unit A & B Jl. Protokol Halim Perdana Kusuma No.8, Jakarta Timur 13610',
    latitude: -6.255708301659587,
    longitude: 106.8826723413536,
  ),
  OfficeLocation(
    officeName: 'Bekasi',
    address: 'Ruko Asera Blok 1W26 No.08, Harapan Indah, Pusaka Rakyat, Tarumajaya, Kabupaten bekasi, Jawa Barat 1721',
    latitude: -6.165910300594855,
    longitude: 106.98579728757899,
  ),
  OfficeLocation(
    officeName: 'Medan',
    address: 'Jl. Ringroad Gagak Hitam No 34 Kelurahan Tanjung Rejo. Kecamatan Medan Sunggal kota Medan Sumatra Utara 20122',
    latitude: 3.574088140852723,
    longitude: 98.6259890394989,
  ),
  OfficeLocation(
    officeName: 'Bali',
    address: 'Jl. Kubu Gunung, Tegal Jaya, Daling, Kuta Utara, Badung Bali',
    latitude: -8.63090352696844,
    longitude: 115.17703569041858,
  ),
  OfficeLocation(
    officeName: 'Cikupa',
    address: 'Jl. Raya Serang KM 19, Sukanagara, Cikupa, Tangerang, Banten 15710',
    latitude: -6.197743981791688,
    longitude: 106.49067256945911,
  ),
  OfficeLocation(
    officeName: 'Semarang',
    address: 'Jl. Gajah Raya No.90D, Sambirejo, Kec. Gayamsari, Kota Semarang, Jawa Tengah 50249',
    latitude: -6.981257810593972,
    longitude: 110.44912735300842,
  ),
  OfficeLocation(
    officeName: 'Purwokerto',
    address: 'Jl. Sultan Agung No.17, ruko no 6 Karanggayam, Teluk, Kec. Purwokerto Sel., Kabupaten Banyumas, Jawa Tengah 53145',
    latitude: -7.446548839659867,
    longitude: 109.25485304643124,
  ),
];
