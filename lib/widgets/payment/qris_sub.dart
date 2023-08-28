import 'package:flutter/material.dart';

import '../../models/invoice.dart';
import '../../screens/payment/show_qris_screen.dart';
import '../../helpers/custom_dialog.dart';
import '../../widgets/payment/expansion_pembayaran_sub.dart';
import '../../widgets/payment/generate_pembayaran_tile.dart';

class QRISSub extends StatelessWidget {
  const QRISSub({
    Key? key,
    required this.context,
    required this.invoiceById,
    required this.invoiceDetail,
  }) : super(key: key);

  final BuildContext context;
  final Invoice invoiceById;
  final List<InvoiceDetail>? invoiceDetail;

  @override
  Widget build(BuildContext context) {
    final disable = invoiceById.currentBalance > 500000;
    const qrisText =
        'Anda akan mendapatkan QRCODE, harap segera melakukan pembayaran. Batas waktu pembayaran MAX 1 jam. Jika sudah lebih dari 1 jam, lakukan generate ulang barcode dan jangan melakukan pembayaran untuk QRCODE yang lama.';
    return ExpansionPembayaranSub(
      title: 'QRIS',
      children: [
        GeneratePembayaranTile(
          title: 'QR Code',
          image: 'QRIS-logo.svg.png',
          tutorialText: qrisText,
          onPressed: () {
            if (disable) {
              showCustomDialog(
                context: context,
                title: 'Tidak Dapat Men-generate QRIS',
                content: 'Pembayaran menggunakan QRIS maksimal Rp500.000',
              );
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ShowQrisScreen(
                    invoiceById: invoiceById,
                    invoiceDetail: invoiceDetail!,
                    amountBeforeAdmin: invoiceById.currentBalance.toInt(),
                  ),
                ),
              );
            }
          },
          buttonText: 'Generate QR Code',
        ),
      ],
    );
  }
}
