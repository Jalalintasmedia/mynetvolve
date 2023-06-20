class Qris {
  final int amount;
  final String merchantType;
  final String idPel;
  final String productId;
  final String qrText;
  final String qrId;
  final double billAmount;
  final double admin;
  final String img;
  final String rc;
  final String status;
  final DateTime expiryTime;

  Qris({
    required this.amount,
    required this.merchantType,
    required this.idPel,
    required this.productId,
    required this.qrText,
    required this.qrId,
    required this.billAmount,
    required this.admin,
    required this.img,
    required this.rc,
    required this.status,
    required this.expiryTime,
  });

  Qris.fromJson(Map<String?, dynamic> json, this.expiryTime)
      : amount = json['amount'] ?? 0,
        merchantType = json['merchant-type'] ?? '',
        idPel = json['idpel'] ?? '',
        productId = json['product_id'] ?? '',
        qrText = json['qr_text'] ?? '',
        qrId = json['qr_id'] ?? '',
        billAmount = double.parse(json['bill_amount'] ?? 0),
        admin = double.parse(json['admin'] ?? 0),
        img = json['img'] ?? '',
        rc = json['rc'] ?? '',
        status = json['status'] ?? '';

  Map<String?, dynamic> toJson() => {
        'amount': amount,
        'merchant-type': merchantType,
        'idpel': idPel,
        'product_id': productId,
        'qr_text': qrText,
        'qr_id': qrId,
        'bill_amount': billAmount.toString(),
        'admin': admin.toString(),
        'img': img,
        'rc': rc,
        'status': status,
      };
}

class GeneratedQr {
  final String tPaymentGwQrisId;
  final String qrId;
  final String amount;
  final String billAmount;
  final String admin;
  final String qrContent;
  final String status;
  final String paymentDate;
  final String paymentInfo;
  final String createDate;

  GeneratedQr({
    required this.tPaymentGwQrisId,
    required this.qrId,
    required this.amount,
    required this.billAmount,
    required this.admin,
    required this.qrContent,
    required this.status,
    required this.paymentDate,
    required this.paymentInfo,
    required this.createDate,
  });

  GeneratedQr.fromJson(Map<String?, dynamic> json)
      : tPaymentGwQrisId = json['t_payment_gw_qris_id'] ?? '',
        qrId = json['qr_id'] ?? '',
        amount = json['amount'] ?? '',
        billAmount = json['bill_amount'] ?? '',
        admin = json['admin'] ?? '',
        qrContent = json['qr_content'] ?? '',
        status = json['status'] ?? '',
        paymentDate = json['payment_date'] ?? '',
        paymentInfo = json['payment_info'] ?? '',
        createDate = json['create_date'] ?? '';

  Map<String?, dynamic> toJson() => {
        't_payment_gw_qris_id': tPaymentGwQrisId,
        'qr_id': qrId,
        'amount': amount,
        'bill_amount': billAmount,
        'admin': admin,
        'qr_content': qrContent,
        'status': status,
        'payment_date': paymentDate,
        'payment_info': paymentInfo,
        'create_date': createDate,
      };
}

class Qris2 {
  String idPel;
  String externalId;
  String qrId;
  String qrString;
  int billAmount;
  int adminFee;
  String status;
  int expiredTime;
  String expiredType;
  String expiredAt;
  String createdAt;

  Qris2({
    required this.idPel,
    required this.externalId,
    required this.qrId,
    required this.qrString,
    required this.billAmount,
    required this.adminFee,
    required this.status,
    required this.expiredTime,
    required this.expiredType,
    required this.expiredAt,
    required this.createdAt,
  });

  Qris2.fromJson(Map<String?, dynamic> json)
      : idPel = json['idpel'] ?? '',
        externalId = json['external_id'] ?? '',
        qrId = json['qr_id'] ?? '',
        qrString = json['qr_string'] ?? '',
        billAmount = json['bill_amount'] ?? 0,
        adminFee = json['adminFee'] ?? 0,
        status = json['status'] ?? '',
        expiredTime = json['expired_time'] ?? 0,
        expiredType = json['expired_type'] ?? '',
        expiredAt = json['expired_at'] ?? '',
        createdAt = json['expired_at'] ?? '';
}
