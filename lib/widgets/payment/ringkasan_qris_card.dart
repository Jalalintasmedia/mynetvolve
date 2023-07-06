import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/enums.dart';
import '../../providers/customer_profile.dart';
import '../profile/detail_tagihan_tile.dart';

class RingkasanQrisCard extends StatelessWidget {
  const RingkasanQrisCard({
    Key? key,
    required this.amount,
    required this.adminFee,
    required this.totalAmount,
    required this.paymentType,
    this.useCustInfo = false,
  }) : super(key: key);

  final int amount;
  final int adminFee;
  final int totalAmount;
  final bool useCustInfo;
  final PaymentType paymentType;

  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<CustomerProfile>(
      context,
      listen: false,
    ).customer!;
    final accountNo = customer.accountNo;
    final accountName = customer.accountName;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (useCustInfo)
              const Text(
                'Informasi Pelanggan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            if (useCustInfo)
              DetailTagihanTile(
                title: accountName,
                price: 0,
                isBold: false,
                customString: accountNo,
              ),
            if (useCustInfo) const SizedBox(height: 5),
            const Text(
              'Ringkasan Tagihan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 5),
            DetailTagihanTile(
              title: 'Tagihan',
              price: amount.toDouble(),
              isBold: false,
            ),
            DetailTagihanTile(
              title: paymentType == PaymentType.qris
                  ? 'Biaya Admin QRIS'
                  : 'Biaya Admin Alfamart',
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
