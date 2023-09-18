import 'package:flutter/material.dart';

import '../../models/invoice.dart';
import '../profile/detail_tagihan_tile.dart';

class RingkasanCard extends StatelessWidget {
  const RingkasanCard({
    Key? key,
    required this.invoiceById,
    required this.invoiceDetail,
    this.anotherField,
    this.total,
  }) : super(key: key);

  final Invoice invoiceById;
  final List<InvoiceDetail>? invoiceDetail;
  final Widget? anotherField;
  final double? total;

  @override
  Widget build(BuildContext context) {
    var taxTotal = 0.0;
    for (var inv in invoiceDetail!) {
      taxTotal += inv.tax;
    }
    print('===== ${invoiceDetail!.length}');
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ringkasan Tagihan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: invoiceDetail!.length,
              itemBuilder: (ctx, i) => DetailTagihanTile(
                title: invoiceDetail![i].name,
                price: invoiceDetail![i].amount.toInt(),
                isBold: false,
              ),
            ),
            DetailTagihanTile(
              title: 'PPN',
              price: taxTotal.toInt(),
              isBold: false,
            ),
            if (anotherField != null) anotherField!,
            // const SizedBox(height: 10),
            const Divider(
              color: Colors.grey,
              height: 5,
            ),
            // const SizedBox(height: 10),
            DetailTagihanTile(
              title: 'Total Tagihan',
              price: total != null
                  ? total!.toInt()
                  : invoiceById.currentBalance.toInt(),
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }
}
