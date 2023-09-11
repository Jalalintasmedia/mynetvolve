import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mynetvolve/models/http_exception.dart';

import '../core/constants.dart';
import '../models/customer_product.dart';

class Products with ChangeNotifier {
  List<CustomerProduct>? _custProducts;
  final String? token;
  final String? timeStamp;
  final String? tAccountId;

  Products(this.token, this.timeStamp, this.tAccountId, this._custProducts);

  List<CustomerProduct>? get custProducts {
    return _custProducts;
  }

  Future<void> getCustProducts() async {
    print('===== CALLING PRODUCTS FUTURE');
    final url = Uri.parse(IBOSS_API_URL + '/ibossapi');
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            "act": "getcustomerproduct",
            "time": timeStamp,
            "t_account_id": tAccountId,
          },
        ),
      );

      final List<CustomerProduct> loadedCustProducts = [];
      final extractedData = json.decode(response.body)['data'] as List;
      if (extractedData.isEmpty) {
        // _custProducts = [];
        // return;
        throw HttpException('CUST PRODUCT NULL');
      }

      extractedData.map((custProd) {
        var itemChargesJson = custProd['item_charge'] as List;
        var servicesJson = custProd['service_list'] as List;
        List<ProductItemCharge> itemCharges = getItemCharge(itemChargesJson);
        List<ProductService> services = getServices(servicesJson);

        var custProdData =
            CustomerProduct.fromJson(custProd, itemCharges, services);
        loadedCustProducts.add(custProdData);
      }).toList();
      _custProducts = loadedCustProducts.toList();
    } catch (e) {
      rethrow;
    }
  }

  List<ProductItemCharge> getItemCharge(List<dynamic> itemChargesJson) {
    final List<ProductItemCharge> itemChargeList = [];
    try {
      itemChargesJson.map((itemCharge) {
        var itemChargeData = ProductItemCharge.fromJson(itemCharge);
        itemChargeList.add(itemChargeData);
      }).toList();
    } catch (e) {
      var itemChargeData = ProductItemCharge(
        tAccountProductItemId: '',
        name: '',
        itemTypeDesc: '',
        amount: 0,
        tax: 0,
      );
      itemChargeList.add(itemChargeData);
    }
    return itemChargeList;
  }

  List<ProductService> getServices(List<dynamic> servicesJson) {
    final List<ProductService> productServiceList = [];
    try {
      servicesJson.map((service) {
        var serviceData = ProductService.fromJson(service);
        productServiceList.add(serviceData);
      }).toList();
    } catch (e) {
      var serviceData = ProductService(
        tAccountProductServiceId: '',
        description: '',
        serviceName: '',
        serviceTypeDesc: '',
        uomDesc: '',
        unit: '',
        speedMbps: '',
      );
      productServiceList.add(serviceData);
    }
    return productServiceList;
  }
}
