import 'package:flutter/material.dart';

import '../../models/invoice.dart';
import '../profile/detail_tagihan_tile.dart';

class RingkasanQrisCard extends StatelessWidget {
  const RingkasanQrisCard({
    Key? key,
    required this.amount,
    required this.adminFee,
    required this.totalAmount,
  }) : super(key: key);

  final int amount;
  final int adminFee;
  final int totalAmount;

  @override
  Widget build(BuildContext context) {
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
            DetailTagihanTile(
              title: 'Tagihan',
              price: amount.toDouble(),
              isBold: false,
            ),
            DetailTagihanTile(
              title: 'Biaya Admin QRIS',
              price: adminFee.toDouble(),
              isBold: false,
            ),
            // const SizedBox(height: 10),
            const Divider(
              color: Colors.grey,
              height: 5,
            ),
            // const SizedBox(height: 10),
            DetailTagihanTile(
              title: 'Total Tagihan',
              price: totalAmount.toDouble(),
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }
}
