import 'package:flutter/material.dart';
import 'package:mynetvolve/widgets/loading/shimmer_list_view.dart';
import 'package:mynetvolve/widgets/profile/riwayat/pembelian_shimmer.dart';
import 'package:provider/provider.dart';

import '../../../providers/products.dart';
import '../../../screens/tidak_ada_data_screen.dart';
import '../../../widgets/profile/riwayat/paket_tile.dart';
import '../../../widgets/loading/shimmer_widget.dart';

class PembelianScreen extends StatefulWidget {
  const PembelianScreen({Key? key}) : super(key: key);

  @override
  State<PembelianScreen> createState() => _PembelianScreenState();
}

class _PembelianScreenState extends State<PembelianScreen> {
  @override
  Widget build(BuildContext context) {
    late final _productsFuture =
        Provider.of<Products>(context, listen: false).getCustProducts();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'Paket Aktif',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          FutureBuilder(
            future: _productsFuture,
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return const Expanded(
                  child: ShimmerListView(shimmerTile: PembelianShimmer()),
                );
              } else {
                if (dataSnapshot.error != null) {
                  return const Center(
                    child: Text('an error occured'),
                  );
                } else {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        return Future(() {
                          setState(() {});
                        });
                      },
                      child: Consumer<Products>(
                        builder: (ctx, custProdData, _) {
                          final custProd = custProdData.custProducts!;
                          if (custProd.isEmpty) {
                            return const TidakAdaDataScreen();
                          }
                          return ListView.separated(
                            separatorBuilder: (ctx, i) => const Divider(
                              color: Colors.grey,
                            ),
                            itemCount: custProd.length,
                            itemBuilder: (ctx, i) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: (i == custProd.length - 1) ? 5 : 0),
                                child: PaketTile(custProd: custProd[i]),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
