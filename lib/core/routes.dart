import 'package:flutter/widgets.dart';
import 'package:mynetvolve/screens/auth/new_register_screen.dart';
import 'package:mynetvolve/screens/auth/reset_password/reset_password_screen.dart';
import 'package:mynetvolve/screens/paket/addons_screen.dart';
import 'package:mynetvolve/screens/paket/games/games_screen.dart';
import 'package:mynetvolve/screens/paket/ganti_paket_screen.dart';
import 'package:mynetvolve/screens/payment/bayar_tagihan_screen.dart';
import 'package:mynetvolve/screens/payment/show_qris_screen.dart';
import 'package:mynetvolve/screens/profile/bantuan/bantuan_dan_kontak_screen.dart';
import 'package:mynetvolve/screens/profile/bantuan/kantor_sceen.dart';
import 'package:mynetvolve/screens/profile/ganti_password_screen.dart';
import 'package:mynetvolve/screens/profile/riwayat/aktivitas_screen.dart';
import 'package:mynetvolve/screens/profile/riwayat/efaktur_screen.dart';
import 'package:mynetvolve/screens/profile/riwayat/pembelian_screen.dart';
import 'package:mynetvolve/screens/profile/riwayat/tagihan_screen.dart';
import 'package:mynetvolve/screens/scan_code/scan_qr_screen.dart';

import '../screens/payment/bayar_tagihan_screen.dart';
import '../screens/profile/riwayat/detail_tagihan_screen.dart';
import '../screens/profile/info_akun_screen.dart';
import '../screens/profile/riwayat_screen.dart';
import '../screens/menu/beranda_screen.dart';
import '../screens/menu/chat_screen.dart';
import '../screens/menu/live_chat_screen.dart';
// import '../screens/login_screen.dart';
import '../screens/auth/new_login_screen.dart';
import '../screens/menu/paket_screen.dart';
import '../screens/pemberitahuan_screen.dart';
import '../screens/auth/pick_auth_screen.dart';
import '../screens/menu/profile_screen.dart';
import '../screens/menu/tabs_screen.dart';
import '../screens/profile/verifikasi_akun_screen.dart';
import 'constants.dart';

Map<String, Widget Function(BuildContext)> routesMap = {
  RouteNames.HOME_ROUTE: (_) => const TabsScreen(),
  RouteNames.PICK_AUTH_ROUTE: (_) => const PickAuthScreen(),
  RouteNames.LOGIN_ROUTE: (_) => const NewLoginScreen(),
  RouteNames.REGISTER_ROUTE: (_) => const NewRegisterScreen(),
  RouteNames.RESET_PASSWORD_ROUTE: (_) => const ResetPasswordScreen(),
  RouteNames.BERANDA_ROUTE: (_) => const BerandaScreen(),
  RouteNames.PAKET_ROUTE: (_) => const PaketScreen(),
  RouteNames.CHAT_ROUTE: (_) => const ChatScreen(),
  RouteNames.LIVE_CHAT_ROUTE: (_) => const LiveChatScreen(),
  RouteNames.PROFILE_ROUTE: (_) => const ProfileScreen(),
  RouteNames.PEMBERITAHUAN_ROUTE: (_) => const PemberitahuanScreen(),
  RouteNames.BAYAR_TAGIHAN_ROUTE: (_) => const BayarTagihanScreen(),
  // RouteNames.SHOW_QRIS_ROUTE: (_) => const ShowQrisScreen(),
  RouteNames.INFO_AKUN_ROUTE: (_) => const InfoAkunScreen(),
  RouteNames.RIWAYAT_ROUTE: (_) => const RiwayatScreen(),
  RouteNames.TAGIHAN_ROUTE: (_) => const TagihanScreen(),
  RouteNames.DETAIL_TAGIHAN_ROUTE: (_) => const DetailTagihanScreen(),
  RouteNames.PEMBELIAN_ROUTE: (_) => const PembelianScreen(),
  RouteNames.AKTIVITAS_ROUTE: (_) => const AktivitasScreen(),
  RouteNames.IMAGE_ROUTE: (_) => const EfakturScreen(),
  RouteNames.GANTI_PASSWORD_ROUTE: (_) => const GantiPasswordScreen(),
  // RouteNames.VERIFIKASI_AKUN_ROUTE: (_) => const VerifikasiAkunScreen(),
  RouteNames.ADDONS_ROUTE: (_) => const AddonsScreen(),
  RouteNames.GANTI_PAKET_ROUTE: (_) => const GantiPaketScreen(),
  RouteNames.GAMES_ROUTE: (_) => const GamesScreen(),
  RouteNames.SCAN_QR_ROUTE: (_) => const ScanQRScreen(),
  RouteNames.BANTUAN_DAN_KONTAK_ROUTE: (_) => const BantuanDanKontakScreen(),
  RouteNames.KANTOR_ROUTE: (_) => const KantorScreen(),
};
