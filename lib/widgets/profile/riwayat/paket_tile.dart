import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../models/customer_product.dart';

class PaketTile extends StatelessWidget {
  const PaketTile({
    Key? key,
    required this.custProd,
  }) : super(key: key);

  final CustomerProduct custProd;

  @override
  Widget build(BuildContext context) {
    var fee = FORMAT_CURRENCY.format(custProd.monthlyFee);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(custProd.productName),
        const SizedBox(height: 8),
        Text(
          '$fee / Bulan',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Aktif sejak ${custProd.activationDate}',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
