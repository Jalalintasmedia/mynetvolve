import 'package:flutter/material.dart';

import '../../models/nomor_pembayaran.dart';
import '../../widgets/payment/expansion_pembayaran_sub.dart';
import '../../widgets/payment/metode_pembayaran_tile.dart';
import '../../widgets/payment/pembayaran_collapsible_tile.dart';
import '../../models/invoice.dart';

class VirtualAccountSub extends StatelessWidget {
  const VirtualAccountSub({
    Key? key,
    required this.invoiceById,
    required this.list,
  }) : super(key: key);

  final Invoice invoiceById;
  final List<NomorPembayaran> list;

  @override
  Widget build(BuildContext context) {
    return ExpansionPembayaranSub(
      title: 'Virtual Account',
      children: [
        MetodePembayaranTile(
          title: list[0].nama,
          image: list[0].image,
          contentWidget: PembayaranCollapsibleTile(
            ctx: context,
            jenisPembayaran: 'Nomor VA',
            noVa: list[0].nomor,
            total: invoiceById.currentBalance,
          ),
        ),
        const SizedBox(height: 5),
        MetodePembayaranTile(
          title: list[1].nama,
          image: list[1].image,
          contentWidget: PembayaranCollapsibleTile(
            ctx: context,
            jenisPembayaran: 'Nomor VA',
            noVa: list[1].nomor,
            total: invoiceById.currentBalance,
          ),
        ),
        const SizedBox(height: 5),
        MetodePembayaranTile(
          title: list[2].nama,
          image: list[2].image,
          contentWidget: PembayaranCollapsibleTile(
            ctx: context,
            jenisPembayaran: 'Nomor VA',
            noVa: list[2].nomor,
            total: invoiceById.currentBalance,
          ),
        ),
      ],
    );
  }
}
