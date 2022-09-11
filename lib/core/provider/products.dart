import 'dart:collection';

import 'package:demo_ecom/core/model/products.dart';
import 'package:demo_ecom/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class ProductProvider extends ChangeNotifier {
  ProductProvider(apiService) : _apiService = apiService;

  APIServiceClass _apiService;
  final _products = LinkedHashMap<int, ProductModel>();

  List<ProductModel> get productList {
    return _products.values.toList();
  }

  Future getProductData() async {
    var result = await _apiService.get(
      "/products",
    );
    print(result.body);
    var data = convert.jsonDecode(result.body);
    var apiProductData = data["products"];
    apiProductData.forEach((element) {
      var product = ProductModel.fromJson(element);
      _products[product.id] = product;
    });
    notifyListeners();
    return result;
  }
}
