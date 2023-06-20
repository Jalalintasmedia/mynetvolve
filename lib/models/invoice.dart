class Invoice {
  final String tInvoiceId;
  final String invoiceNo;
  final String description;
  final String currencyCode;
  final double currentBalance;
  final double newBalance;
  final String dueDate;
  final String periodStartDate;
  final String periodEndDate;
  final String statementDate;
  final String isPaid;
  final String tFileId;

  Invoice({
    required this.tInvoiceId,
    required this.invoiceNo,
    required this.description,
    required this.currencyCode,
    required this.currentBalance,
    required this.newBalance,
    required this.dueDate,
    required this.periodStartDate,
    required this.periodEndDate,
    required this.statementDate,
    required this.isPaid,
    required this.tFileId,
  });

  Invoice.fromJson(Map<String?, dynamic> json)
      : tInvoiceId = json['t_invoice_id'] ?? '',
        invoiceNo = json['invoice_no'] ?? '',
        description = json['description'] ?? '',
        currencyCode = json['currency_code'] ?? '',
        currentBalance = double.parse(json['current_balance'] ?? 0.0),
        newBalance = double.parse(json['new_balance'] ?? 0.0),
        dueDate = json['due_date'] ?? '',
        periodStartDate = json['period_start_date'] ?? '',
        periodEndDate = json['period_end_date'] ?? '',
        statementDate = json['statement_date'] ?? '',
        isPaid = json['is_paid'] ?? '',
        tFileId = json['t_file_id'] ?? '';

  Map<String?, dynamic> toJson() => {
        't_invoice_id': tInvoiceId,
        'invoice_no': invoiceNo,
        'description': description,
        'currency_code': currencyCode,
        'current_balance': currentBalance.toString(),
        'new_balance': newBalance.toString(),
        'due_date': dueDate,
        'period_start_date': periodStartDate,
        'period_end_date': periodEndDate,
        'statement_date': statementDate,
        'is_paid': isPaid,
        't_file_id': tFileId,
      };
}

class InvoiceDetail {
  final String tInvoiceDetailId;
  final String name;
  final String nameFull;
  final double amount;
  final double tax;

  InvoiceDetail({
    required this.tInvoiceDetailId,
    required this.name,
    required this.nameFull,
    required this.amount,
    required this.tax,
  });

  InvoiceDetail.fromJson(Map<String?, dynamic> json)
      : tInvoiceDetailId = json['t_invoice_detail_id'] ?? '',
        name = json['name'] ?? '',
        nameFull = json['name_full'] ?? '',
        amount = double.parse(json['amount'] ?? 0.0),
        tax = double.parse(json['tax'] ?? 0.0);

  Map<String?, dynamic> toJson() => {
        't_invoice_detail_id': tInvoiceDetailId,
        'name': name,
        'name_full': nameFull,
        'amount': amount.toString(),
        'tax': tax.toString(),
      };
}
