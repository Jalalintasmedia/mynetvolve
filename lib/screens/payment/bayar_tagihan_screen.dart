import 'package:flutter/material.dart';
import 'package:mynetvolve/screens/payment/show_qris_screen.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';
import 'package:provider/provider.dart';

import '../../models/nomor_pembayaran.dart';
import '../../widgets/buttons/rounded_button.dart';
import '../../core/constants.dart';
import '../../core/palette.dart';
import '../../models/invoice.dart';
import '../../providers/customer_profile.dart';
import '../../providers/invoice_list.dart';
import '../../widgets/payment/metode_pembayaran_sub.dart';
import '../../widgets/payment/ringkasan_card.dart';
import '../../widgets/payment/metode_pembayaran_tile.dart';

class BayarTagihanScreen extends StatelessWidget {
  const BayarTagihanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final invoiceId = ModalRoute.of(context)!.settings.arguments as String;
    final invoiceById =
        Provider.of<InvoiceList>(context, listen: false).findById(invoiceId);
    final accountNo = Provider.of<CustomerProfile>(context, listen: false)
        .customer!
        .accountNo;
    var _qrList = NomorPembayaran.qrList;
    var _vaList = NomorPembayaran.vaList;
    var _counterList = NomorPembayaran.counterList;

    late final _invoiceFuture = Provider.of<InvoiceList>(context, listen: false)
        .getInvoiceInfo(invoiceId);

    return Scaffold(
      appBar: const GradientAppBar(title: 'Tagihan'),
      body: FutureBuilder(
        future: _invoiceFuture,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              return const Center(
                child: Text('an error occured'),
              );
            } else {
              return Consumer<InvoiceList>(
                builder: (ctx, invoiceInfo, _) {
                  var invoiceDetail = invoiceInfo.invoiceDetails;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    width: double.infinity,
                    child: ListView(
                      children: [
                        const SizedBox(height: 5),
                        RingkasanCard(
                            invoiceById: invoiceById,
                            invoiceDetail: invoiceDetail),
                        const SizedBox(height: 25),
                        metodePembayaran(
                          context,
                          _qrList,
                          _vaList,
                          _counterList,
                          invoiceById,
                          invoiceDetail,
                          accountNo,
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }

  Widget metodePembayaran(
      BuildContext ctx,
      List<NomorPembayaran> listQr,
      List<NomorPembayaran> listVA,
      List<NomorPembayaran> listCounter,
      Invoice invoiceById,
      List<InvoiceDetail>? invoiceDetail,
      String accountNo) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pilih Metode Pembayaran',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 15),
          qrisSub(ctx, invoiceById, invoiceDetail),
          const SizedBox(height: 15),
          MetodePembayaranSub(
            ctx: ctx,
            namaSub: 'Virtual Account',
            list: listVA,
            invoiceById: invoiceById,
            accountNo: accountNo,
          ),
          const SizedBox(height: 15),
          MetodePembayaranSub(
            ctx: ctx,
            namaSub: 'Bayar di Counter',
            list: listCounter,
            invoiceById: invoiceById,
            accountNo: accountNo,
          )
        ],
      ),
    );
  }

  Widget qrisSub(BuildContext context, Invoice invoiceById,
      List<InvoiceDetail>? invoiceDetail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'QRIS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 8),
        MetodePembayaranTile(
          title: 'QR Code',
          image: 'QRIS-logo.svg.png',
          contentWidget: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              children: [
                const Text(
                  'Anda akan mendapatkan QRCODE, harap segera melakukan pembayaran. Batas waktu pembayaran MAX 1 jam. Jika sudah lebih dari 1 jam, lakukan generate ulang barcode dan jangan melakukan pembayaran untuk QRCODE yang lama.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 15),
                RoundedButton(
                  // onPressed: () => Navigator.of(context).pushNamed(
                  //   RouteNames.SHOW_QRIS_ROUTE,
                  //   arguments: {
                  //     'invoiceById': invoiceById,
                  //     'invoiceDetail': invoiceDetail
                  //   },
                  // ),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ShowQrisScreen(
                        invoiceById: invoiceById,
                        invoiceDetail: invoiceDetail!,
                        amountBeforeAdmin: invoiceById.currentBalance.toInt(),
                      ),
                    ),
                  ),
                  // onPressed: null,
                  text: 'Generate QR Code',
                  useSide: false,
                  useShadow: false,
                  bgColor: Palette.kToDark,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
