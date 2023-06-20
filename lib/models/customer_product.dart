class CustomerProduct {
  final String tAccountProductId;
  final String productName;
  final double monthlyFee;
  final String instalationFee;
  final String activationDate;
  final String statusDesc;
  final List<ProductItemCharge> itemCharge;
  final List<ProductService> services;

  CustomerProduct({
    required this.tAccountProductId,
    required this.productName,
    required this.monthlyFee,
    required this.instalationFee,
    required this.activationDate,
    required this.statusDesc,
    required this.itemCharge,
    required this.services,
  });

  CustomerProduct.fromJson(Map<String?, dynamic> json, this.itemCharge, this.services)
      : tAccountProductId = json['t_account_product_id'] ?? '',
        productName = json['product_name'] ?? '',
        monthlyFee = double.parse(json['monthly_fee'] ?? 0.0),
        instalationFee = json['instalation_fee'] ?? '',
        activationDate = json['activation_date'] ?? '',
        statusDesc = json['status_desc'] ?? '';

  Map<String?, dynamic> toJson() => {
        't_account_product_id': tAccountProductId,
        'product_name': productName,
        'monthly_fee': monthlyFee.toString(),
        'instalation_fee': instalationFee,
        'activation_date': activationDate,
        'status_desc': statusDesc,
      };
}

class ProductItemCharge {
  final String tAccountProductItemId;
  final String name;
  final String itemTypeDesc;
  final double amount;
  final double tax;

  ProductItemCharge({
    required this.tAccountProductItemId,
    required this.name,
    required this.itemTypeDesc,
    required this.amount,
    required this.tax,
  });

  ProductItemCharge.fromJson(Map<String?, dynamic> json)
      : tAccountProductItemId = json['t_account_product_item_id'] ?? '',
        name = json['name'] ?? '',
        itemTypeDesc = json['item_type_desc'] ?? '',
        amount = double.parse(json['amount'] ?? 0),
        tax = double.parse(json['tax'] ?? 0);

  Map<String?, dynamic> toJson() => {
        't_account_product_item_id': tAccountProductItemId,
        'name': name,
        'item_type_desc': itemTypeDesc,
        'amount': amount.toString(),
        'tax': tax.toString(),
      };
}

class ProductService {
  final String tAccountProductServiceId;
  final String description;
  final String serviceName;
  final String serviceTypeDesc;
  final String uomDesc;
  final String unit;
  final String speedMbps;

  ProductService({
    required this.tAccountProductServiceId,
    required this.description,
    required this.serviceName,
    required this.serviceTypeDesc,
    required this.uomDesc,
    required this.unit,
    required this.speedMbps,
  });

  ProductService.fromJson(Map<String?, dynamic> json)
      : tAccountProductServiceId = json['t_account_product_service_id'] ?? '',
        description = json['description'] ?? '',
        serviceName = json['service_name'] ?? '',
        serviceTypeDesc = json['service_type_desc'] ?? '',
        uomDesc = json['uom_desc'] ?? '',
        unit = json['unit'] ?? '',
        speedMbps = json['speed_mbps'] ?? '';
  
  Map<String?, dynamic> toJson() => {
    't_account_product_service_id': tAccountProductServiceId,
    'description': description,
    'service_name': serviceName,
    'service_type_desc': serviceTypeDesc,
    'uom_desc': uomDesc,
    'unit': unit,
    'speed_mbps': speedMbps,
  };
}
