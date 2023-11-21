import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/palette.dart';
import '../../providers/products.dart';

class MyPackagesWidget extends StatelessWidget {
  const MyPackagesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: MediaQuery.sizeOf(context).width / 2,
      ),
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
        return IntrinsicWidth(
          child: Column(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildMyPackageTile(
                    '${productService.speedMbps} ${productService.uomDesc}',
                    product.productName,
                    Icons.language,
                  ),
                  // const VerticalDivider(color: Colors.grey),
                  // buildMyPackageTile(
                  //   '-',
                  //   Icons.tv,
                  // ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildMyPackageTile(String text, String name, IconData icon) {
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
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
    );
  }
}
