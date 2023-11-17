import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/enums.dart';
import '../../providers/customer_profile.dart';
import '../../providers/qris_prov.dart';
import '../../widgets/gradient_app_bar.dart';
import '../../widgets/payment/show_code_screen_content.dart';

class ShowVACodeScreen extends StatefulWidget {
  const ShowVACodeScreen({
    Key? key,
    required this.bankType,
    required this.invoiceNo,
    required this.amount,
    required this.tutorialText,
  }) : super(key: key);

  final BankType bankType;
  final String invoiceNo;
  final int amount;
  final String tutorialText;

  @override
  State<ShowVACodeScreen> createState() => _ShowVACodeScreenState();
}

class _ShowVACodeScreenState extends State<ShowVACodeScreen> {
  @override
  Widget build(BuildContext context) {
    String? logo;
    var bankName = '';
    switch (widget.bankType) {
      case BankType.bri:
        logo = 'bri-logo.png';
        bankName = 'BRI';
        break;
      case BankType.bni:
        logo = 'bni-logo.png';
        bankName = 'BNI';
        break;
      case BankType.permata:
        logo = 'permata-bank-logo.png';
        bankName = 'Permata';
        break;
      case BankType.bankSahabatSampoerna:
        logo = 'bank-sampoerna-logo.png';
        bankName = 'BSS';
        break;
      case BankType.cimbNiaga:
        logo = 'cimb-niaga-logo.png';
        bankName = 'CIMB';
        break;
      case BankType.bjb:
        logo = 'bjb-logo.png';
        bankName = 'BJB';
        break;
      case BankType.bsi:
        logo = 'bsi-logo.png';
        bankName = 'BSI';
        break;
      case BankType.mandiri:
        logo = 'mandiri-logo.png';
        bankName = 'Mandiri';
        break;
      case BankType.danamon:
        logo = 'danamon-logo.png';
        bankName = 'Danamon';
        break;
      case BankType.doku:
        logo = 'doku-logo.png';
        bankName = 'DOKU';
        break;
      case BankType.otherBank:
        logo = null;
        bankName = 'BNI';
        break;
      default:
    }

    final customerData = Provider.of<CustomerProfile>(
      context,
      listen: false,
    ).customer!;
    final accountNo = customerData.accountNo;
    final accountName = customerData.accountName;
    final accountEmail = customerData.accountEmail;
    final tIspId = customerData.tIspId;
    late final _vaFuture = Provider.of<QrisProv>(
      context,
      listen: false,
    ).generateVACode(
      accountNo: accountNo,
      name: accountName,
      email: accountEmail,
      invoiceNo: widget.invoiceNo,
      amount: widget.amount,
      tIspId: tIspId,
      bankType: bankName,
    );

    return Scaffold(
      appBar: GradientAppBar(
        title: widget.bankType == BankType.otherBank
            ? 'Tagihan VA Bank Lain'
            : 'Tagihan VA $bankName',
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
        future: _vaFuture,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (dataSnapshot.hasError) {
            return Center(
              child: Text(
                'Tidak Dapat men-generate kode VA.0\n${dataSnapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }
          return Consumer<QrisProv>(
            builder: (ctx, paymentData, _) {
              final vaPayment = paymentData.vaPayment!;
              return ShowCodeScreenContent(
                amount: widget.amount,
                adminFee: vaPayment.adminFee,
                totalAmount: vaPayment.billAmount,
                paymentType: PaymentType.va,
                paymentCode: vaPayment.vaNo,
                tutorialText: widget.tutorialText,
                expirationDate: vaPayment.expirationDate,
                logo: logo,
              );
            },
          );
        },
      ),
    );
  }
}
