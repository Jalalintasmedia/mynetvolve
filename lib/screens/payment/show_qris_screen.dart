import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mynetvolve/helpers/save_image.dart';
import 'package:mynetvolve/models/invoice.dart';
import 'package:mynetvolve/providers/customer_profile.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';
import 'package:mynetvolve/widgets/payment/ringkasan_card.dart';
import 'package:mynetvolve/widgets/payment/ringkasan_qris_card.dart';
import 'package:mynetvolve/widgets/profile/detail_tagihan_tile.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../providers/qris_prov.dart';

class ShowQrisScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final globalKey = GlobalKey();
    final accountNo = Provider.of<CustomerProfile>(
      context,
      listen: false,
    ).customer!.accountNo;
    late final _qrisFuture = Provider.of<QrisProv>(
      context,
      listen: false,
    ).generateQris(
      accountNo: accountNo,
      invoiceNo: invoiceById.invoiceNo,
      amount: amountBeforeAdmin,
    );

    void shareQRCode() async {
      try {
        RenderRepaintBoundary boundary = globalKey.currentContext!
            .findRenderObject() as RenderRepaintBoundary;
        var image = await boundary.toImage();

        ByteData? byteData =
            await image.toByteData(format: ImageByteFormat.png);

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
      appBar: const GradientAppBar(title: 'Tagihan QRIS'),
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
                            amount: amountBeforeAdmin,
                            adminFee: qrisInfo.adminFee,
                            totalAmount: qrisInfo.billAmount,
                          ),
                          const SizedBox(height: 15),
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            width: double.infinity,
                            child: RepaintBoundary(
                              key: globalKey,
                              child: QrImage(
                                data: qrisInfo.qrString,
                                version: QrVersions.auto,
                              ),
                            ),
                          ),
                          // const SizedBox(height: 15),
                          TextButton(
                            onPressed: () {
                              try {
                                shareQRCode();
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Gagal mengunduh QR Code'),
                                  ),
                                );
                              }
                            },
                            child: const Text('Bagikan QR Code'),
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
