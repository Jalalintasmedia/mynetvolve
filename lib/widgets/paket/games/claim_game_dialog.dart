import 'package:flutter/material.dart';
import 'package:mynetvolve/helpers/copy_text.dart';

class ClaimGameDialog extends StatelessWidget {
  const ClaimGameDialog({
    Key? key,
    required this.voucherCode,
  }) : super(key: key);

  final String voucherCode;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ImageIcon(
              AssetImage('assets/icons/check.png'),
              color: Colors.green,
              size: 100,
            ),
            const Text(
              'Voucher Code:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Text(
              voucherCode,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            TextButton(
              onPressed: () => copyText(copiedData: voucherCode),
              child: const Text('Salin Kode'),
            ),
          ],
        ),
      ),
    );
  }
}
