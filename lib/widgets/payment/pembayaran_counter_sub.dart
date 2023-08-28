import 'package:flutter/material.dart';

import '../../models/invoice.dart';
import 'metode_pembayaran_tile.dart';
import '../../screens/payment/show_alfamart_code_screen.dart';
import '../payment/expansion_pembayaran_sub.dart';
import '../payment/generate_pembayaran_tile.dart';
import '../payment/pembayaran_collapsible_tile.dart';

class PembayaranCounterSub extends StatelessWidget {
  const PembayaranCounterSub({
    Key? key,
    required this.invoiceById,
    required this.accountNo,
  }) : super(key: key);
  final Invoice invoiceById;
  final String accountNo;

  @override
  Widget build(BuildContext context) {
    const alfamartText =
        '''<ol><li>Kunjungi gerai Alfamart/Alfamidi/Lawson/DAN+DAN terdekat sebelum kode pembayaran kadaluwarsa</li>
<li>Informasikan ke Kasir untuk melakukan pembayaran ke produk/servis Bnetfit.</li>
<li>Berikan informasi KODE PEMBAYARAN yang tertera di MyBNetFit atau Xpress BNetFit kepada kasir.</li>
<li>Pastikan jumlah pembayaran sama dengan jumlah yang diberitahukan oleh kasir.</li>
<li>Minta struk pembayaran sebagai bukti transaksi dari Alfamart.</li>
<li>Pembayaran Alfamart anda sudah selesai.</li></ol>''';

    return ExpansionPembayaranSub(
      title: 'Bayar di Counter',
      children: [
        GeneratePembayaranTile(
          title: 'Alfamart',
          image: 'alfamart-logo.png',
          tutorialText: alfamartText,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ShowAlfamartCodeScreen(
                invoiceNo: invoiceById.invoiceNo,
                amount: invoiceById.currentBalance.toInt(),
                tutorialText: alfamartText,
              ),
            ),
          ),
          buttonText: 'Generate Kode Pembayaran',
        ),
        const SizedBox(height: 5),
        MetodePembayaranTile(
          title: 'Indomaret',
          image: 'indomaret-logo.png',
          contentWidget: PembayaranCollapsibleTile(
            ctx: context,
            jenisPembayaran: 'Nomor Pelanggan',
            noVa: accountNo,
            total: invoiceById.currentBalance,
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
