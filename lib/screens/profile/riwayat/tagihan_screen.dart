import 'package:flutter/material.dart';
import 'package:mynetvolve/screens/tidak_ada_data_screen.dart';
import 'package:mynetvolve/widgets/loading/shimmer_list_view.dart';
import 'package:mynetvolve/widgets/profile/riwayat/tagihan_shimmer.dart';
import 'package:provider/provider.dart';

import '../../../providers/customer_profile.dart';
import '../../../providers/invoice_list.dart';
import '../../../widgets/profile/kirim_tagihan_modal.dart';
import '../../../widgets/profile/riwayat/tagihan_tile.dart';

class TagihanScreen extends StatefulWidget {
  const TagihanScreen({Key? key}) : super(key: key);

  @override
  State<TagihanScreen> createState() => _TagihanScreenState();
}

class _TagihanScreenState extends State<TagihanScreen> {
  // bool _isChecked = false;

  Future<void> _refreshInvoice(BuildContext context) async {
    await Provider.of<InvoiceList>(context, listen: false).getInvoices();
  }

  void _showModalBottomSheet(BuildContext context, InvoiceList invoiceData,
      List<bool> checks, String emailVerified, String email) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return KirimTagihanModal(
          invoiceData: invoiceData,
          checks: checks,
          emailVerified: emailVerified,
          email: email,
          context: context,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    late final _invoiceFuture =
        Provider.of<InvoiceList>(context, listen: false).getInvoices();
    final custData = Provider.of<CustomerProfile>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: FutureBuilder(
        future: _invoiceFuture,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'Pembayaran Tagihan Anda',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(child: ShimmerListView(shimmerTile: TagihanShimmer())),
              ],
            );
          } else {
            if (dataSnapshot.error != null) {
              return const Center(
                child: Text('an error occured'),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () {
                  return Future(() {
                    setState(() {});
                  });
                },
                child: Consumer<InvoiceList>(
                  builder: (ctx, invoiceData, _) {
                    List<bool> checks = List.generate(
                        invoiceData.invoices!.length, (i) => false);
                    if (invoiceData.invoices!.isEmpty) {
                      return const TidakAdaDataScreen();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Pembayaran Tagihan Anda',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              buildEmailButton(
                                context,
                                invoiceData,
                                checks,
                                custData,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (ctx, i) => const Divider(
                              color: Colors.grey,
                              // height: 0,
                            ),
                            itemCount: invoiceData.invoices!.length,
                            itemBuilder: (ctx, i) => TagihanTile(
                              invoiceData: invoiceData,
                              i: i,
                              context: context,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }

  IconButton buildEmailButton(BuildContext context, InvoiceList invoiceData,
      List<bool> checks, CustomerProfile custData) {
    return IconButton(
      onPressed: () => _showModalBottomSheet(
        context,
        invoiceData,
        checks,
        custData.customer!.emailVerified,
        custData.customer!.accountEmail,
      ),
      icon: const Icon(Icons.mail_outline),
      padding: const EdgeInsets.all(0),
      constraints: const BoxConstraints(),
    );
  }
}
