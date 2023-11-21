import 'package:flutter/material.dart';
import 'package:mynetvolve/models/invoice.dart';
import 'package:mynetvolve/screens/payment/akulaku_screen.dart';
import 'package:mynetvolve/screens/payment/credit_card_screen.dart';
import 'package:mynetvolve/widgets/payment/expansion_pembayaran_sub.dart';
import 'package:mynetvolve/widgets/payment/generate_pembayaran_tile.dart';

class CreditCardSub extends StatelessWidget {
  const CreditCardSub({
    Key? key,
    required this.invoiceById,
  }) : super(key: key);
  
  final Invoice invoiceById;

  @override
  Widget build(BuildContext context) {
    return ExpansionPembayaranSub(
      title: 'Kartu Kredit dan Paylater',
      children: [
        GeneratePembayaranTile(
          title: 'Kartu Kredit',
          image: 'mandiri-logo.png',
          noImage: true,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CreditCardScreen(
                invoiceNo: invoiceById.invoiceNo,
                amount: invoiceById.currentBalance.toInt(),
              ),
            ),
          ),
          buttonText: 'Bayar menggunakan kartu kredit',
        ),
        GeneratePembayaranTile(
          title: 'Akulaku',
          image: 'akulaku-logo.jpeg',
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AkuLakuScreen(
                invoiceNo: invoiceById.invoiceNo,
                amount: invoiceById.currentBalance.toInt(),
              ),
            ),
          ),
          buttonText: 'Bayar menggunakan akulaku',
        ),
      ],
    );
  }
}
