import 'package:flutter/material.dart';

import '../../core/constants.dart';
import 'copy_button.dart';

class PembayaranCollapsibleTile extends StatelessWidget {
  const PembayaranCollapsibleTile({
    Key? key,
    required this.ctx,
    required this.jenisPembayaran,
    required this.noVa,
    required this.total,
  }) : super(key: key);

  final BuildContext ctx;
  final String jenisPembayaran;
  final String noVa;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: Colors.grey.shade400),
        const SizedBox(height: 10),
        Text(
          jenisPembayaran,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 10),
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Text(
              noVa,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CopyButton(ctx: ctx, copyType: jenisPembayaran, copiedData: noVa),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Divider(color: Colors.grey.shade400),
        const SizedBox(height: 10),
        const Text(
          'Jumlah Pembayaran',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 10),
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Text(
              FORMAT_CURRENCY.format(total),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CopyButton(ctx: ctx, copyType: 'Jumlah Pembayaran', copiedData: (total.toInt()).toString()),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
