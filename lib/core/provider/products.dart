import 'dart:collection';

import 'package:demo_ecom/core/model/products.dart';
import 'package:demo_ecom/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class ProductProvider extends ChangeNotifier {
  ProductProvider(apiService) : _apiService = apiService;

  final APIServiceClass _apiService;
  final _products = <int, ProductModel>{};
  final _productsSearchItems = <int, ProductModel>{};
  final _productsByCategory = <int, ProductModel>{};
  List<String> productCategoryList = [];

  List<ProductModel> get productList {
    return _products.values.toList();
  }

  List<ProductModel> get producstListByCategory {
    return _productsByCategory.values.toList();
  }

  List<ProductModel> get productSearchList {
    return _productsSearchItems.values.toList();
  }

  ProductModel? getProductById(int productId) {
    return _products[productId];
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
      _productsSearchItems[product.id] = product;
    });
    notifyListeners();
    return result;
  }

  Future<List<ProductModel>> getProductSearchData(
      {Map<String, String?>? queryParams}) async {
    var result =
        await _apiService.get("/products/search", queryParams: queryParams);
    print(result.body);
    var data = convert.jsonDecode(result.body);
    var apiProductData = data["products"];
    apiProductData.forEach((element) {
      var product = ProductModel.fromJson(element);
      _products[product.id] = product;
      _productsSearchItems[product.id] = product;
    });
    notifyListeners();
    return productSearchList;
  }

  Future getProductByIdFromAPI(int productId) async {
    var result = await _apiService.get(
      "/products/$productId",
    );
    print("GetProdutById: ${result.body}");
    var data = convert.jsonDecode(result.body);
    var product = ProductModel.fromJson(data);
    _products[product.id] = product;
    notifyListeners();
    return result;
  }

  Future getProductCategoris() async {
    var result = await _apiService.get(
      "/products/categories",
    );
    var data = convert.jsonDecode(result.body);
    if (data != null) {
      data.forEach((cD) {
        productCategoryList.add(cD);
      });
    }
    notifyListeners();
    return result;
  }

  Future getProductsByCategory(String category) async {
    _productsByCategory.clear();
    var result = await _apiService.get(
      "/products/category/$category",
    );
    var data = convert.jsonDecode(result.body);
    var apiProductData = data["products"];
    apiProductData.forEach((element) {
      var product = ProductModel.fromJson(element);
      _productsByCategory[product.id] = product;
      _products[product.id] = product;
      _productsSearchItems[product.id] = product;
    });
    notifyListeners();
    return result;
  }
}
