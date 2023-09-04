import 'package:flutter/material.dart';

import '../../core/enums.dart';
import '../../helpers/payment_text.dart';
import '../../models/invoice.dart';
import '../../models/nomor_pembayaran.dart';
import '../../screens/payment/show_va_code_screen.dart';
import 'expansion_pembayaran_sub.dart';
import 'generate_pembayaran_tile.dart';
import 'metode_pembayaran_tile.dart';
import 'pembayaran_collapsible_tile.dart';

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
        const SizedBox(height: 5),
        GeneratePembayaranTile(
          title: 'BNI',
          image: 'bni-logo.png',
          tutorialText: '<ol><li>Transfer sesama bank</li><li>Transfer antar bank menggunakan online transfer (RTOL)</li><li>BI-RTGS</li><li>SKN-BI</li></ol>',
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ShowVACodeScreen(
                invoiceNo: invoiceById.invoiceNo,
                amount: invoiceById.currentBalance.toInt(),
                tutorialText: PaymentTutorialText.bniText,
                bankType: BankType.bni,
              ),
            ),
          ),
          buttonText: 'Generate Kode VA',
        ),
        const SizedBox(height: 5),
        GeneratePembayaranTile(
          title: 'BSI',
          image: 'bsi-logo.png',
          tutorialText: '<ol><li>Transfer sesama bank</li><li>Transfer antar bank menggunakan online transfer (RTOL)</li><li>BI-RTGS</li><li>SKN-BI</li></ol>',
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ShowVACodeScreen(
                invoiceNo: invoiceById.invoiceNo,
                amount: invoiceById.currentBalance.toInt(),
                tutorialText: PaymentTutorialText.bsiText,
                bankType: BankType.bsi,
              ),
            ),
          ),
          buttonText: 'Generate Kode VA',
        ),
      ],
    );
  }
}
