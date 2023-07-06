import 'package:flutter/material.dart';
import 'package:mynetvolve/core/palette.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';
import '../../providers/products.dart';
import 'bayar_button.dart';

class InternetPackageContainer extends StatelessWidget {
  const InternetPackageContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final _productsFuture =
        Provider.of<Products>(context, listen: false).getCustProducts();
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Consumer<Products>(builder: (ctx, productData, _) {
        final product = productData.custProducts![0];
        final productService = product.services[0];
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Palette.kToDark,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      product.productName,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.language,
                      color: Palette.kToDark,
                    ),
                    SizedBox(width: 3),
                    Text(
                      'Internet',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(color: Colors.grey),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${productService.speedMbps} ${productService.uomDesc}',
                        style: const TextStyle(
                          color: Palette.kToDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${FORMAT_CURRENCY.format(product.monthlyFee)}/bln',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 3),
                BayarButton(context: context)
              ],
            ),
          ],
        );
      }),
    );
  }
}
