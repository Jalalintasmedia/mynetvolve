// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:intl/intl.dart';

const CURRENT_VERSION = 'v1.0';

const JLM_GATEWAY_URL = 'https://apigate.jlm.net.id';
const IBOSS_API_URL = '$JLM_GATEWAY_URL/myaccount';
const API_GATEWAY_2 = 'https://pgapi.jlm.net.id';
const PG_API_URL = 'https://xpress.bnetfit.id/API';
// const PG_API_URL = 'https://pgapi.jlm.net.id/pg-xendit';
const BNETFIT_API_URL = '$JLM_GATEWAY_URL/api';
const CLIENT_ID_DEV = 17989;
const CLIENT_ID_PROD = 1798945435467876;
const OTELLO_SECRET_KEY = 'VUmZrzuG3YgIljfo2wRNX5K7c1C9y4Aq';

var FORMAT_CURRENCY =
    NumberFormat.simpleCurrency(locale: 'id', decimalDigits: 0);
var EMAIL_REGEXP = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

class RouteNames {
  // auth
  static const PICK_AUTH_ROUTE = '/pick-auth';
  static const LOGIN_ROUTE = '/login';
  static const REGISTER_ROUTE = '/register';
  static const RESET_PASSWORD_ROUTE = '/reset-password';

  static const HOME_ROUTE = '/home';
  static const BERANDA_ROUTE = '/beranda';
  static const PAKET_ROUTE = '/paket';
  static const CHAT_ROUTE = '/chat';
  static const LIVE_CHAT_ROUTE = '/live-chat';
  static const AREA_ROUTE = '/area';
  static const PROFILE_ROUTE = '/profile';
  static const PEMBERITAHUAN_ROUTE = '/pemberitahuan';

  //payment
  static const BAYAR_TAGIHAN_ROUTE = '/bayar-tagihan';
  static const SHOW_QRIS_ROUTE = '/show-qris';

  // profile
  static const INFO_AKUN_ROUTE = '/info-akun';
  static const RIWAYAT_ROUTE = '/riwayat';
  static const TAGIHAN_ROUTE = '/riwayat/tagihan';
  static const PEMBELIAN_ROUTE = '/riwayat/pembelian';
  static const AKTIVITAS_ROUTE = '/riwayat/aktivitas';
  static const DETAIL_TAGIHAN_ROUTE = '/riwayat/tagihan/detail';
  static const IMAGE_ROUTE = '/image';
  static const GANTI_PASSWORD_ROUTE = '/ganti-password';
  static const VERIFIKASI_AKUN_ROUTE = '/verifikasi-akun';

  static const BANTUAN_DAN_KONTAK_ROUTE = '/bantuan-dan-kontak';
  static const KANTOR_ROUTE = '/kantor';

  // paket
  static const ADDONS_ROUTE = '/addons';
  static const GANTI_PAKET_ROUTE = '/ganti-paket';
  static const GAMES_ROUTE = '/games';

  static const SCAN_QR_ROUTE = '/scan-QR';
  static const SPEED_TEST_ROUTE = '/speed-test';
}

class ToolTipString {
  static const SCAN_PEGAWAI = 'Scan Pegawai Bnetfit';
  static const NOTIFIKASI = 'Notifikasi';
  static const FLOATING_INFO_CONTAINER = 'Info tagihan Anda';
  static const STATUS_KONEKSI = 'Status koneksi internet saat ini';
  static const MULAI_CHAT = 'Chat dengan CS Bnetfit';
  static const REFRESH_NETWORK_STATUS = 'Refresh status koneksi internet';
}
