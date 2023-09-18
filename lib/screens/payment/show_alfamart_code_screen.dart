import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/enums.dart';
import '../../providers/qris_prov.dart';
import '../../widgets/gradient_app_bar.dart';
import '../../widgets/payment/show_code_screen_content.dart';
import '../../providers/customer_profile.dart';

class ShowAlfamartCodeScreen extends StatefulWidget {
  const ShowAlfamartCodeScreen({
    Key? key,
    required this.invoiceNo,
    required this.amount,
    required this.tutorialText,
  }) : super(key: key);

  final String invoiceNo;
  final int amount;
  final String tutorialText;

  @override
  State<ShowAlfamartCodeScreen> createState() => _ShowAlfamartCodeScreenState();
}

class _ShowAlfamartCodeScreenState extends State<ShowAlfamartCodeScreen> {
  @override
  Widget build(BuildContext context) {
    final customerData = Provider.of<CustomerProfile>(
      context,
      listen: false,
    ).customer!;
    final accountNo = customerData.accountNo;
    final accountName = customerData.accountName;
    final tIspId = customerData.tIspId;
    late final _alfamartFuture = Provider.of<QrisProv>(
      context,
      listen: false,
    ).generateAlfamartCode(
      accountNo: accountNo,
      name: accountName,
      invoiceNo: widget.invoiceNo,
      amount: widget.amount,
      tIspId: tIspId,
    );

    return Scaffold(
      appBar: GradientAppBar(
        title: 'Tagihan Alfamart',
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _alfamartFuture,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (dataSnapshot.hasError) {
            return Center(
              child: Text(
                'Tidak Dapat men-generate kode\n${dataSnapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }
          return Consumer<QrisProv>(builder: (ctx, paymentData, _) {
            final alfamartPayment = paymentData.alfamartPayment!;
            return ShowCodeScreenContent(
              amount: widget.amount,
              adminFee: alfamartPayment.adminFee,
              totalAmount: alfamartPayment.billAmount,
              paymentType: PaymentType.alfamart,
              paymentCode: alfamartPayment.paymentCode,
              tutorialText: widget.tutorialText,
              expirationDate: alfamartPayment.expirationDate,
              customWidget: BarcodeWidget(
                data: alfamartPayment.paymentCode,
                barcode: Barcode.code128(),
              ),
            );
          });
        },
      ),
    );
  }
}
