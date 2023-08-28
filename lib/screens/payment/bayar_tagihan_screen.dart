import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/payment/virtual_account_sub.dart';
import '../../widgets/gradient_app_bar.dart';
import '../../widgets/payment/pembayaran_counter_sub.dart';
import '../../models/nomor_pembayaran.dart';
import '../../providers/customer_profile.dart';
import '../../providers/invoice_list.dart';
import '../../widgets/payment/qris_sub.dart';
import '../../widgets/payment/ringkasan_card.dart';

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
    // var _qrList = NomorPembayaran.qrList;
    var _vaList = NomorPembayaran.vaList;

    late final _invoiceFuture = Provider.of<InvoiceList>(
      context,
      listen: false,
    ).getInvoiceInfo(invoiceId);

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
                          invoiceDetail: invoiceDetail,
                        ),
                        const SizedBox(height: 25),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Pilih Metode Pembayaran',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              // const SizedBox(height: 15),
                              QRISSub(
                                context: ctx,
                                invoiceById: invoiceById,
                                invoiceDetail: invoiceDetail,
                              ),
                              PembayaranCounterSub(
                                invoiceById: invoiceById,
                                accountNo: accountNo,
                              ),
                              VirtualAccountSub(
                                invoiceById: invoiceById,
                                list: _vaList,
                              ),
                            ],
                          ),
                        )
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
}
