import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/string_formatter.dart';
import '../../providers/products.dart';
import '../../providers/customer_profile.dart';
import '../paket_info_widget.dart';
import 'bayar_button.dart';

class FloatingInfoContainer extends StatelessWidget {
  const FloatingInfoContainer({
    Key? key,
    required this.context,
    // required this.bayarButton
  }) : super(key: key);

  final BuildContext context;
  // final Widget bayarButton;

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerProfile>(
      builder: (ctx, custData, child) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(5, 5),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                upperContainer(custData, context),
                const Divider(
                  color: Colors.grey,
                ),
                lowerSection(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget upperContainer(
    CustomerProfile custData,
    BuildContext context,
  ) {
    var statementDate = custData.customer!.statementDate;
    var month = getMonthFromString(statementDate);
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  custData.customer!.accountName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  custData.customer!.accountNo,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                if (custData.customer!.dueDate != '')
                  Row(
                    children: [
                      const Text(
                        'Batas Pembayaran',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 9,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        custData.customer!.dueDate,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const VerticalDivider(
            color: Colors.grey,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Tagihan $month',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 9,
                ),
              ),
              BayarButton(context: context),
              // bayarButton,
            ],
          ),
        ],
      ),
    );
  }

  Widget lowerSection() {
    late final _productsFuture =
        Provider.of<Products>(context, listen: false).getCustProducts();
    var serviceName = 'Internet';
    var speed = '0';
    var uomDesc = 'Mbps';
    var shownFee = '0';
    var feeSuffix = 'Rb';

    return FutureBuilder(
      future: _productsFuture,
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return PaketInfoWidget(
            serviceName: serviceName,
            speed: speed,
            uomDesc: uomDesc,
            shownFee: shownFee,
            feeSuffix: feeSuffix,
          );
        } else {
          return Consumer<Products>(
            builder: (ctx, productData, _) {
              if (dataSnapshot.connectionState == ConnectionState.done &&
                  dataSnapshot.error == null) {
                var productServiceInfo =
                    productData.custProducts![0].services[0];
                serviceName = productServiceInfo.serviceName;
                speed = productServiceInfo.speedMbps;
                uomDesc = productServiceInfo.uomDesc;
                var fee = (productData.custProducts![0].monthlyFee);
                // var fee = 7000000.00;
                shownFee = 'Free';
                feeSuffix = '';
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
              } else {
                return PaketInfoWidget(
                  serviceName: serviceName,
                  speed: speed,
                  uomDesc: uomDesc,
                  shownFee: shownFee,
                  feeSuffix: feeSuffix,
                );
              }
              return PaketInfoWidget(
                serviceName: serviceName,
                speed: speed,
                uomDesc: uomDesc,
                shownFee: shownFee,
                feeSuffix: feeSuffix,
              );
            },
          );
        }
      },
    );
  }
}
