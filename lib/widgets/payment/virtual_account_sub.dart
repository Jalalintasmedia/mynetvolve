import 'package:flutter/material.dart';
import 'package:mynetvolve/core/enums.dart';
import 'package:mynetvolve/helpers/payment_text.dart';
import 'package:mynetvolve/models/nomor_pembayaran.dart';
import 'package:mynetvolve/screens/payment/show_va_code_screen.dart';
import 'package:mynetvolve/widgets/payment/expansion_pembayaran_sub.dart';
import 'package:mynetvolve/widgets/payment/generate_pembayaran_tile.dart';
import 'package:mynetvolve/widgets/payment/metode_pembayaran_tile.dart';
import 'package:mynetvolve/widgets/payment/pembayaran_collapsible_tile.dart';

import '../../models/invoice.dart';

class VirtualAccountSub extends StatelessWidget {
  const VirtualAccountSub({
    Key? key,
    required this.invoiceById,
    required this.list,
    required this.accountNo,
  }) : super(key: key);

  final Invoice invoiceById;
  final List<NomorPembayaran> list;
  final String accountNo;

  @override
  Widget build(BuildContext context) {
    return ExpansionPembayaranSub(
      title: 'Virtual Account',
      children: [
        GeneratePembayaranTile(
          title: 'BRI',
          image: 'bri-logo.png',
          tutorialText:
              '<ol><li>Transfer sesama bank</li><li>Transfer antar bank menggunakan online transfer (RTOL)</li><li>BI-RTGS</li><li>SKN-BI</li><li>BI-Fast</li></ol>',
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ShowVACodeScreen(
                invoiceNo: invoiceById.invoiceNo,
                amount: invoiceById.currentBalance.toInt(),
                tutorialText: PaymentTutorialText.briText,
                bankType: BankType.bri,
              ),
            ),
          ),
          buttonText: 'Generate Kode VA',
        ),
        const SizedBox(height: 5),
        GeneratePembayaranTile(
          title: 'BNI',
          image: 'bni-logo.png',
          tutorialText:
              '<ol><li>Transfer sesama bank</li><li>Transfer antar bank menggunakan online transfer (RTOL)</li><li>BI-RTGS</li><li>SKN-BI</li></ol>',
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
          title: 'Permata Bank',
          image: 'permata-bank-logo.png',
          tutorialText:
              '<ol><li>Transfer sesama bank</li><li>Transfer antar bank menggunakan online transfer (RTOL)</li><li>BI-RTGS</li><li>SKN-BI</li></ol>',
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ShowVACodeScreen(
                invoiceNo: invoiceById.invoiceNo,
                amount: invoiceById.currentBalance.toInt(),
                tutorialText: PaymentTutorialText.permataText,
                bankType: BankType.permata,
              ),
            ),
          ),
          buttonText: 'Generate Kode VA',
        ),
        const SizedBox(height: 5),
        GeneratePembayaranTile(
          title: 'CIMB Niaga',
          image: 'cimb-niaga-logo.png',
          tutorialText:
              '<ol><li>Transfer sesama bank</li><li>Transfer antar bank menggunakan online transfer (RTOL)</li></ol>',
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ShowVACodeScreen(
                invoiceNo: invoiceById.invoiceNo,
                amount: invoiceById.currentBalance.toInt(),
                tutorialText: PaymentTutorialText.cimbText,
                bankType: BankType.cimbNiaga,
              ),
            ),
          ),
          buttonText: 'Generate Kode VA',
        ),
        const SizedBox(height: 5),
        GeneratePembayaranTile(
          title: 'BJB',
          image: 'bjb-logo.png',
          tutorialText:
              '<ol><li>Transfer sesama bank</li><li>Transfer antar bank menggunakan online transfer (RTOL)</li><li>BI-RTGS</li><li>SKN-BI</li></ol>',
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ShowVACodeScreen(
                invoiceNo: invoiceById.invoiceNo,
                amount: invoiceById.currentBalance.toInt(),
                tutorialText: PaymentTutorialText.bjbText,
                bankType: BankType.bjb,
              ),
            ),
          ),
          buttonText: 'Generate Kode VA',
        ),
        const SizedBox(height: 5),
        GeneratePembayaranTile(
          title: 'BSI',
          image: 'bsi-logo.png',
          tutorialText:
              '<ol><li>Transfer sesama bank</li><li>Transfer antar bank menggunakan online transfer (RTOL)</li><li>BI-RTGS</li><li>SKN-BI</li></ol>',
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
        const SizedBox(height: 5),
        MetodePembayaranTile(
          title: list[0].nama,
          image: list[0].image,
          contentWidget: PembayaranCollapsibleTile(
            ctx: context,
            jenisPembayaran: 'Nomor VA',
            noVa: '${list[0].nomor}$accountNo',
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
            noVa: '${list[1].nomor}$accountNo',
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
            noVa: '${list[2].nomor}$accountNo',
            total: invoiceById.currentBalance,
          ),
        ),
      ],
    );
  }
}
