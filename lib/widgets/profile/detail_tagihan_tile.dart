import 'package:flutter/material.dart';

import '../../core/constants.dart';
import '../../helpers/copy_text.dart';
import '../../helpers/custom_dialog.dart';

class DetailTagihanTile extends StatelessWidget {
  const DetailTagihanTile({
    Key? key,
    required this.title,
    required this.price,
    required this.isBold,
    this.customString,
    this.copyButton = false,
  }) : super(key: key);

  final String title;
  final int price;
  final bool isBold;
  final String? customString;
  final bool copyButton;

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
          fontSize: isBold ? 15 : 13,
        ),
      ),
      trailing: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            customString != null
                ? customString!
                : FORMAT_CURRENCY.format(price),
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : null,
              fontSize: isBold ? 15 : 13,
            ),
          ),
          if (copyButton) const SizedBox(width: 5),
          if (copyButton)
            IconButton(
              onPressed: () {
                try {
                  copyText(copiedData: '$price');
                } catch (e) {
                  showErrMsg(context, 'Gagal menyalin kode');
                }
              },
              icon: const Icon(Icons.copy),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: 18,
            ),
        ],
      ),
    );
  }
}
