import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/banners_prov.dart';
import '../providers/customer_profile.dart';
import '../providers/faq_prov.dart';
import '../providers/invoice_list.dart';
import '../providers/network_info_prov.dart';
import '../providers/notification_prov.dart';
import '../providers/products.dart';
import '../providers/qris_prov.dart';
import '../providers/tiket_prov.dart';

final PROVIDERS_LIST = [
  ChangeNotifierProvider(create: (_) => Auth()),
  ChangeNotifierProvider(create: (_) => BannerProvs()),
  ChangeNotifierProvider(create: (_) => FaqProvs()),
  ChangeNotifierProxyProvider<Auth, CustomerProfile>(
    create: (context) => CustomerProfile(null, null, null, null),
    update: (ctx, auth, previousCust) => CustomerProfile(
      auth.token,
      auth.time,
      auth.tAccountId,
      previousCust?.customer,
    ),
  ),
  ChangeNotifierProxyProvider<Auth, InvoiceList>(
    create: (context) => InvoiceList(null, null, null, []),
    update: (ctx, auth, previousInvoices) => InvoiceList(
      auth.token,
      auth.time,
      auth.tAccountId,
      previousInvoices?.invoices,
    ),
  ),
  ChangeNotifierProxyProvider<Auth, Products>(
    create: (context) => Products(null, null, null, []),
    update: (ctx, auth, previousProducts) => Products(
      auth.token,
      auth.time,
      auth.tAccountId,
      previousProducts?.custProducts,
    ),
  ),
  ChangeNotifierProxyProvider<Auth, NotificationProv>(
    create: (context) => NotificationProv(null, null, null, []),
    update: (ctx, auth, previousNotifs) => NotificationProv(
      auth.token,
      auth.time,
      auth.tAccountId,
      previousNotifs?.notifications,
    ),
  ),
  ChangeNotifierProxyProvider<Auth, QrisProv>(
    create: (context) => QrisProv(null, null, null, null, null, null, null, null),
    update: (ctx, auth, previousQris) => QrisProv(
      auth.token,
      auth.time,
      auth.tAccountId,
      previousQris?.qris,
      previousQris!.qris2,
      previousQris.alfamartPayment,
      previousQris.vaPayment,
      previousQris.creditCardPayment,
    ),
  ),
  ChangeNotifierProxyProvider<Auth, TicketProvider>(
    create: (context) => TicketProvider(null, []),
    update: (ctx, auth, prevTickets) => TicketProvider(
      auth.tAccountId,
      prevTickets!.tickets,
    ),
  ),
  ChangeNotifierProxyProvider<Auth, NetworkInfoProv>(
    create: (context) => NetworkInfoProv(null),
    update: (ctx, auth, prevNetInfo) => NetworkInfoProv(
      auth.tAccountId,
      // prevNetInfo!.networkInfo,
    ),
  ),
];
