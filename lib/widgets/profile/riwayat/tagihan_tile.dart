import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../helpers/string_formatter.dart';
import '../../../providers/invoice_list.dart';

class TagihanTile extends StatelessWidget {
  const TagihanTile({
    Key? key,
    required this.invoiceData,
    required this.i,
    required this.context,
  }) : super(key: key);

  final InvoiceList invoiceData;
  final int i;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final invoice = invoiceData.invoices![i];
    var statementDate = invoice.statementDate;
    var month = getMonthFromString(statementDate);
    var year = statementDate.substring(statementDate.length - 4);

    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        RouteNames.DETAIL_TAGIHAN_ROUTE,
        arguments: invoice.tInvoiceId,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                invoice.isPaid == 'Y' ? 'PAID' : 'UNPAID',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: invoice.isPaid == 'Y' ? Colors.green : Colors.red),
              ),
              const SizedBox(height: 5),
              Text('$month $year'),
            ],
          ),
          Row(
            children: [
              Text(FORMAT_CURRENCY.format(invoice.currentBalance)),
              const Icon(
                Icons.arrow_right,
                // size: 30,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
