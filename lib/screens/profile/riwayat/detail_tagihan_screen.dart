import 'package:flutter/material.dart';
import 'package:mynetvolve/helpers/custom_dialog.dart';
import 'package:mynetvolve/helpers/string_formatter.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../core/constants.dart';
import '../../../core/palette.dart';
import '../../../models/invoice.dart';
import '../../../providers/invoice_list.dart';
import '../../../widgets/profile/detail_tagihan_tile.dart';
import '../../../widgets/buttons/rounded_button.dart';

class DetailTagihanScreen extends StatelessWidget {
  const DetailTagihanScreen({Key? key}) : super(key: key);

  void buttonFunc(
    BuildContext context,
    Invoice invoiceById,
    InvoiceList invoiceData,
  ) {
    if (invoiceById.isPaid == 'Y') {
      if (invoiceData.efaktur!.name != '') {
        Navigator.of(context).pushNamed(
          RouteNames.IMAGE_ROUTE,
          arguments: invoiceData.efaktur,
        );
      } else {
        showCustomDialog(
          context: context,
          title: 'Tidak Dapat Mengunduh Efaktur',
          content: 'Maaf, Efaktur Tidak Tersedia',
        );
      }
    } else {
      Navigator.of(context).pushNamed(
        RouteNames.BAYAR_TAGIHAN_ROUTE,
        arguments: invoiceById.tInvoiceId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tInvoiceId = ModalRoute.of(context)!.settings.arguments as String;
    final invoiceById =
        Provider.of<InvoiceList>(context, listen: false).findById(tInvoiceId);

    late final _invoiceFuture = Provider.of<InvoiceList>(context, listen: false)
        .getInvoiceInfo(tInvoiceId);

    return FutureBuilder(
      future: _invoiceFuture,
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          if (dataSnapshot.error != null) {
            return const Scaffold(
              body: SafeArea(
                child: Center(
                  child: Text('an error occured'),
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: const GradientAppBar(
                title: 'Detail Tagihan',
                isCloseButton: true,
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50 + 20),
                  child: invoiceDetails(invoiceById),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: floatingButton(context, invoiceById),
            );
          }
        }
      },
    );
  }

  Widget invoiceDetails(Invoice invoiceById) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: Consumer<InvoiceList>(
          builder: (ctx, invoiceInfo, _) {
            var invoiceDetail = invoiceInfo.invoiceDetails;
            var payment = invoiceInfo.payment;
            var statementDate = invoiceById.statementDate;
            // var startDate = invoiceById.periodStartDate.replaceAll('-', ' ');
            // var endDate = invoiceById.periodEndDate.replaceAll('-', ' ');
            var periodeTagihan =
                '${getMonthFromString(statementDate)} ${statementDate.substring(statementDate.length - 4)}';
            var taxTotal = 0.0;
            invoiceDetail!.forEach((inv) => taxTotal += inv.tax);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invoiceById.isPaid == 'Y' ? 'PAID' : 'UNPAID',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color:
                        invoiceById.isPaid == 'Y' ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 10),
                invoiceById.isPaid == 'Y'
                    ? section(
                        'Transaksi Berhasil',
                        [
                          Text(payment!.transactionDate),
                          Text('ID Transaksi: ${payment.tPaymentId}'),
                        ],
                      )
                    : const SizedBox(height: 0),
                const SizedBox(height: 10),
                section(
                  'Periode Tagihan',
                  [Text(periodeTagihan)],
                ),
                const SizedBox(height: 10),
                payment!.paymentChannel != ''
                    ? section(
                        'Metode Pembayaran',
                        [Text(payment.paymentChannel)],
                      )
                    : const SizedBox(height: 10),
                const Text(
                  'Detail Tagihan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                detailTagihan(invoiceDetail),
                DetailTagihanTile(
                  title: 'PPN',
                  price: taxTotal.toInt(),
                  isBold: false,
                ),
                const SizedBox(height: 10),
                DetailTagihanTile(
                  title: 'Tagihan Bulan Ini',
                  price: invoiceById.currentBalance.toInt(),
                  isBold: true,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget section(String sectionTitle, List<Widget> content) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...content.map((text) {
          return Column(
            children: [
              text,
              const SizedBox(height: 5),
            ],
          );
        }),
      ],
    );
  }

  Widget detailTagihan(List<InvoiceDetail>? invoiceDetail) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: invoiceDetail!.length,
      itemBuilder: (ctx, i) => DetailTagihanTile(
        title: invoiceDetail[i].nameFull,
        price: invoiceDetail[i].amount.toInt(),
        isBold: false,
      ),
    );
  }

  Widget floatingButton(BuildContext context, Invoice invoiceById) {
    return Consumer<InvoiceList>(
      builder: (ctx, invoiceData, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          height: 50,
          child: RoundedButton(
            onPressed: () => buttonFunc(context, invoiceById, invoiceData),
            text: invoiceById.isPaid == 'Y'
                ? 'Download Efaktur'
                : 'Bayar Sekarang',
            useSide: invoiceById.isPaid == 'Y' ? true : false,
            bgColor: invoiceById.isPaid == 'Y'
                ? Palette.kToDark
                : Colors.red.shade700,
            useShadow: false,
          ),
        );
      },
    );
  }
}
