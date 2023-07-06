import 'package:flutter/material.dart';

import '../../core/constants.dart';

class DetailTagihanTile extends StatelessWidget {
  const DetailTagihanTile({
    Key? key,
    required this.title,
    required this.price,
    required this.isBold,
    this.customString,
  }) : super(key: key);

  final String title;
  final double price;
  final bool isBold;
  final String? customString;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      title: Text(
        title,
        style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : null,
            fontSize: isBold ? 15 : 13),
      ),
      trailing: Text(
        customString != null ? customString! : FORMAT_CURRENCY.format(price),
        style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : null,
            fontSize: isBold ? 15 : 13),
      ),
    );
  }
}
