import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/enums.dart';
import '../../helpers/save_image.dart';
import '../../models/invoice.dart';
import '../../providers/customer_profile.dart';
import '../../widgets/gradient_app_bar.dart';
import '../../widgets/payment/ringkasan_qris_card.dart';
import '../../providers/qris_prov.dart';

class ShowQrisScreen extends StatefulWidget {
  const ShowQrisScreen({
    Key? key,
    required this.invoiceById,
    required this.invoiceDetail,
    required this.amountBeforeAdmin,
  }) : super(key: key);

  final Invoice invoiceById;
  final List<InvoiceDetail> invoiceDetail;
  final int amountBeforeAdmin;

  @override
  State<ShowQrisScreen> createState() => _ShowQrisScreenState();
}

class _ShowQrisScreenState extends State<ShowQrisScreen> {
  @override
  Widget build(BuildContext context) {
    final globalKey = GlobalKey();
    final customerData = Provider.of<CustomerProfile>(
      context,
      listen: false,
    ).customer!;
    final accountNo = customerData.accountNo;
    final tIspId = customerData.tIspId;
    late final _qrisFuture = Provider.of<QrisProv>(
      context,
      listen: false,
    ).generateQris(
      accountNo: accountNo,
      invoiceNo: widget.invoiceById.invoiceNo,
      amount: widget.amountBeforeAdmin,
      tIspId: tIspId,
    );

    void shareQRCode() async {
      try {
        RenderRepaintBoundary boundary = globalKey.currentContext!
            .findRenderObject() as RenderRepaintBoundary;
        var image = await boundary.toImage();

        ByteData? byteData = await image.toByteData(
          format: ImageByteFormat.png,
        );

        Uint8List pngBytes = byteData!.buffer.asUint8List();
        var datetime = DateTime.now();
        shareImage(
          base64String: pngBytes,
          fileName: '$datetime',
          fileType: 'png',
        );
        // Share.share('hello');
        // saveImage(base64String: pngBytes, fileName: '$datetime');
      } catch (e) {
        print('===== save qr error');
      }
    }

    return Scaffold(
      appBar: GradientAppBar(
        title: 'Tagihan QRIS',
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
        future: _qrisFuture,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text(
                  'Tidak Dapat men-generate QRIS\n${dataSnapshot.error}',
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return Consumer<QrisProv>(
                builder: (ctx, qrisData, _) {
                  final qrisInfo = qrisData.qris2!;

                  return SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      child: Column(
                        children: [
                          RingkasanQrisCard(
                            amount: widget.amountBeforeAdmin,
                            adminFee: qrisInfo.adminFee,
                            totalAmount: qrisInfo.billAmount,
                            useCustInfo: true,
                            paymentType: PaymentType.qris,
                          ),
                          const SizedBox(height: 15),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 8,
                            child: Column(
                              children: [
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  width: double.infinity,
                                  child: RepaintBoundary(
                                    key: globalKey,
                                    // child: QrImage(
                                    //   data: qrisInfo.qrString,
                                    //   version: QrVersions.auto,
                                    // ),
                                    child: QrImageView(
                                      data: qrisInfo.qrString,
                                      version: QrVersions.auto,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    try {
                                      shareQRCode();
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Gagal mengunduh QR Code'),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text('Bagikan QR Code'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
