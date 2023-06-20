import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../helpers/custom_dialog.dart';
import '../../helpers/string_formatter.dart';
import '../../providers/invoice_list.dart';
import '../buttons/rounded_button.dart';

class KirimTagihanModal extends StatelessWidget {
  const KirimTagihanModal({
    Key? key,
    required this.invoiceData,
    required this.checks,
    required this.emailVerified,
    required this.email,
    required this.context,
  }) : super(key: key);

  final InvoiceList invoiceData;
  final List<bool> checks;
  final String emailVerified;
  final String email;
  final BuildContext context;

  Future<void> _sendToEmail() async {
    List<int> _chosenInvoicesIndex = [];
    checks.asMap().forEach(
      (key, value) {
        if (value) {
          _chosenInvoicesIndex.add(key);
        }
      },
    );
    if (_chosenInvoicesIndex.isEmpty) {
      return;
    }

    List<String> _chosenInvoices = [];
    for (var index in _chosenInvoicesIndex) {
      _chosenInvoices.add(invoiceData.invoices![index].statementDate);
    }

    try {
      await Provider.of<InvoiceList>(context, listen: false)
          .sendInvoiceToEmail(_chosenInvoices, email);
      Fluttertoast.showToast(
        msg: 'Riwayat tagihan berhasil dikirim ke $email',
        backgroundColor: Colors.black87,
      );
      Navigator.of(context).pop();
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (ctx, setState) {
        return Container(
          height: 300,
          color: Colors.white,
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Kirim Riwayat Tagihan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: invoiceData.invoices!.length,
                  itemBuilder: (ctx, i) {
                    final invoice = invoiceData.invoices![i];
                    var statementDate = invoice.statementDate;
                    var month = getMonthFromString(statementDate);
                    var year =
                        statementDate.substring(statementDate.length - 4);
                    return Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: CheckboxListTile(
                        value: checks[i],
                        title: Text('$month $year'),
                        onChanged: (bool? val) {
                          setState(() {
                            checks[i] = val!;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: RoundedButton(
                  onPressed: emailVerified == 'Y'
                      ? _sendToEmail
                      : () => showCustomDialog(
                            context: context,
                            title: 'Verifikasi Akun',
                            content:
                                'Akun belum terverifikasi\nSilakan lakukan verifikasi akun anda pada menu profile -> info akun',
                          ),
                  text: 'Kirim Ke Email',
                  useSide: true,
                  useShadow: false,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
