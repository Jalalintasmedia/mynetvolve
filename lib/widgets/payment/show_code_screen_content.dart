import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../core/enums.dart';
import '../../helpers/copy_text.dart';
import '../../helpers/custom_dialog.dart';
import '../../widgets/payment/ringkasan_qris_card.dart';

class ShowCodeScreenContent extends StatelessWidget {
  const ShowCodeScreenContent({
    Key? key,
    required this.amount,
    required this.adminFee,
    required this.totalAmount,
    required this.paymentType,
    required this.paymentCode,
    required this.tutorialText,
    required this.expirationDate,
  }) : super(key: key);

  final int amount;
  final int adminFee;
  final int totalAmount;
  final PaymentType paymentType;
  final String paymentCode;
  final String tutorialText;
  final String expirationDate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        child: Column(
          children: [
            RingkasanQrisCard(
              amount: amount,
              adminFee: adminFee,
              totalAmount: totalAmount,
              paymentType: paymentType,
              useCustInfo: true,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 8,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    children: [
                      const Text('Kode Pembayaran:'),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              paymentCode,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              try {
                                copyText(copiedData: paymentCode);
                              } catch (e) {
                                showErrMsg(context, 'Gagal menyalin kode');
                              }
                            },
                            icon: const Icon(Icons.copy),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Kode ini hanya berlaku hingga: $expirationDate',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // const SizedBox(height: 10),
            // Container(
            //   width: double.infinity,
            //   padding: const EdgeInsets.symmetric(horizontal: 15),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(25),
            //     color: Colors.red,
            //   ),
            //   child: Text(
            //     expirationDate,
            //     style: const TextStyle(color: Colors.white),
            //   ),
            // ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 15,
                        left: 15,
                        right: 15,
                      ),
                      child: Text(
                        'Cara Pembayaran:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Html(data: tutorialText),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
