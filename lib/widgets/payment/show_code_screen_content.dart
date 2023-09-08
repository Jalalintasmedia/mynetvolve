import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../core/enums.dart';
import '../../helpers/copy_text.dart';
import '../../helpers/custom_dialog.dart';
import '../../helpers/link_director.dart';
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
    this.logo,
  }) : super(key: key);

  final int amount;
  final int adminFee;
  final int totalAmount;
  final PaymentType paymentType;
  final String paymentCode;
  final String tutorialText;
  final String expirationDate;
  final String? logo;

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
                      if (logo != null)
                        SizedBox(
                          height: 40,
                          child: Image.asset('assets/images/${logo!}'),
                        ),
                      // const Text('Kode Pembayaran:'),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            paymentCode,
                            style: TextStyle(
                              fontSize: paymentType == PaymentType.va ? 20 : 32,
                              fontWeight: FontWeight.bold,
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
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 15,
                          left: 7,
                          right: 7,
                        ),
                        child: Text(
                          'Cara Pembayaran:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Html(
                        data: tutorialText,
                        style: {
                          'ol': Style(
                            padding: const EdgeInsets.only(bottom: 12),
                          ),
                        },
                        onLinkTap: (url, _, __, ___) async {
                          final uri = Uri.parse(url!);
                          print('URL: $url, URI: $uri');
                          openExternalApplication(url);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
