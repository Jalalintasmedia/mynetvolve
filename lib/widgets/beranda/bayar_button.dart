import 'package:flutter/material.dart';
import 'package:mynetvolve/widgets/buttons/rounded_button.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';
import '../../core/palette.dart';
import '../../models/invoice.dart';
import '../../providers/invoice_list.dart';

class BayarButton extends StatelessWidget {
  const BayarButton({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    late final _invoiceFuture = Provider.of<InvoiceList>(context, listen: false).getInvoices();
    return FutureBuilder(
      future: _invoiceFuture,
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return RoundedButton(
            onPressed: () {},
            text: '...',
            textColor: Colors.grey.shade400,
            useSide: false,
            useShadow: false,
            bgColor: Colors.grey.shade400,
          );
        } else {
          if (dataSnapshot.error != null) {
            return RoundedButton(
            onPressed: () {},
            text: '...',
            textColor: Colors.grey.shade400,
            useSide: false,
            useShadow: false,
            bgColor: Colors.grey.shade400,
          );
          } else {
            return Consumer<InvoiceList>(
              builder: (ctx, invoice, _) {
                List<Invoice> unpaidInvoices = invoice.unpaidInvoices();
                Invoice? lastInvoice = invoice.latestInvoice();
                bool unpaidExists = unpaidInvoices.isNotEmpty;
                return RoundedButton(
                  onPressed: () {
                    if (unpaidExists) {
                      Navigator.of(context).pushNamed(
                        RouteNames.BAYAR_TAGIHAN_ROUTE,
                        arguments: unpaidInvoices[0].tInvoiceId,
                      );
                    } else {
                      Navigator.of(context).pushNamed(
                        RouteNames.DETAIL_TAGIHAN_ROUTE,
                        arguments: lastInvoice!.tInvoiceId,
                      );
                    }
                  },
                  text: unpaidExists ? 'Belum Bayar' : 'Sudah Bayar',
                  bgColor: unpaidExists ? Colors.red : Palette.kToDark,
                  fontSize: 12,
                  useSide: false,
                  useShadow: false,
                );
              },
            );
          }
        }
      },
    );
  }
}
