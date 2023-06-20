import 'package:flutter/material.dart';
import 'package:mynetvolve/widgets/payment/pembayaran_collapsible_tile.dart';

import '../../models/invoice.dart';
import '../../models/nomor_pembayaran.dart';
import 'metode_pembayaran_tile.dart';

class MetodePembayaranSub extends StatelessWidget {
  const MetodePembayaranSub({
    Key? key,
    required this.ctx,
    required this.namaSub,
    required this.list,
    required this.invoiceById,
    required this.accountNo,
  }) : super(key: key);

  final BuildContext ctx;
  final String namaSub;
  final List<NomorPembayaran> list;
  final Invoice invoiceById;
  final String accountNo;

  @override
  Widget build(BuildContext context) {
    var jenisPembayaran = '';
    switch (namaSub) {
      case ('Virtual Account'):
        jenisPembayaran = 'Nomor VA';
        break;
      case ('Bayar di Counter'):
        jenisPembayaran = 'Nomor Pelanggan';
        break;
      default:
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          namaSub,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (ctx, i) {
            return Column(
              children: [
                MetodePembayaranTile(
                  title: list[i].nama,
                  image: list[i].image,
                  contentWidget: PembayaranCollapsibleTile(
                    ctx: ctx,
                    jenisPembayaran: jenisPembayaran,
                    noVa: list[i].nomor + accountNo,
                    total: invoiceById.currentBalance,
                  ),
                ),
                const SizedBox(height: 5),
              ],
            );
          },
        ),
      ],
    );
  }
}
