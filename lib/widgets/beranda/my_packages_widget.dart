import 'package:flutter/material.dart';
import 'package:mynetvolve/core/palette.dart';
import 'package:mynetvolve/models/customer_product.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';
import '../../providers/products.dart';
import 'bayar_button.dart';

class MyPackagesWidget extends StatelessWidget {
  const MyPackagesWidget({
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Palette.kToDark,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Text(
                'My Package',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            const Divider(color: Colors.grey),
            IntrinsicHeight(
              child: Row(
                children: [
                  buildMyPackageTile(
                    '${productService.speedMbps} ${productService.uomDesc}',
                    Icons.language,
                  ),
                  const VerticalDivider(color: Colors.grey),
                  buildMyPackageTile(
                    '${productService.speedMbps} ${productService.uomDesc}',
                    Icons.tv,
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget buildMyPackageTile(String text, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            color: Palette.kToDark,
            size: 50,
          ),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
