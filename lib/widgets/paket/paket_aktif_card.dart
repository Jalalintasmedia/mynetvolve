import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products.dart';
import '../paket_info_widget.dart';

class PaketAktifCard extends StatelessWidget {
  const PaketAktifCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Products>(
      builder: (ctx, productData, _) {
        var productInfo = productData.custProducts![0];
        var productServiceInfo = productData.custProducts![0].services[0];
        var fee = (productData.custProducts![0].monthlyFee);
        // var fee = 7000000.00;
        var shownFee = 'Free';
        var feeSuffix = '';
        if (fee != 0.0) {
          var feeString = fee.toString();
          feeString = feeString.substring(0, feeString.length - 2);
          if (feeString.length < 7) {
            shownFee = feeString.substring(0, feeString.length - 3);
            feeSuffix = 'Rb';
          } else {
            shownFee = feeString.substring(0, feeString.length - 6);
            feeSuffix = 'Jt';
          }
        }
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  productInfo.productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                PaketInfoWidget(
                  serviceName: productServiceInfo.serviceName,
                  speed: productServiceInfo.speedMbps,
                  uomDesc: productServiceInfo.uomDesc,
                  shownFee: shownFee,
                  feeSuffix: feeSuffix,
                ),
                // const Divider(color: Colors.grey),
                // const SizedBox(height: 8),
                // Text(
                //   'Aktif sejak ${productInfo.activationDate}',
                //   style: const TextStyle(
                //     fontWeight: FontWeight.bold,
                //     color: Colors.grey,
                //     fontSize: 12,
                  // ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
