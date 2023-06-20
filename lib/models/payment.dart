import 'dart:convert';

class Payment {
  final String tPaymentId;
  final String transactionDate;
  final String trxNo;
  final String paymentChannel;

  Payment({
    required this.tPaymentId,
    required this.transactionDate,
    required this.trxNo,
    required this.paymentChannel,
  });

  Payment.fromJson(Map<String?, dynamic> json)
      : tPaymentId = json['t_payment_id'] ?? '',
        transactionDate = json['transaction_date'] ?? '',
        trxNo = json['trxno'] ?? '',
        paymentChannel = json['payment_channel'] ?? '';
  
  Map<String?, dynamic> toJson() => {
    't_payment_id': tPaymentId,
    'transaction_date': transactionDate,
    'trxno': trxNo,
    'payment_channel': paymentChannel,
  };
}
