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
    var data = convert.jsonDecode(result.body);
    var apiProductData = data["products"];
    apiProductData.forEach((element) {
      var product = ProductModel.fromJson(element);
      if (_products.containsKey(product.id)) {
      } else {
        _products[product.id] = product;
        _productsSearchItems[product.id] = product;
      }
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
      if (_products.containsKey(product.id)) {
      } else {
        _products[product.id] = product;
        _productsSearchItems[product.id] = product;
      }
    });
    notifyListeners();
    return productSearchList;
  }

  void addItemInCart({required int productId, required bool isInCart}) {
    _products[productId]!.isInCart = isInCart;
    _products[productId]!.qty = 1;
    notifyListeners();
  }

  void removeItemInCart(
    int productId,
    bool isInCart,
  ) {
    _products[productId]!.isInCart = isInCart;
    _products[productId]!.qty = 0;
    notifyListeners();
  }

  void increaseQty(int productId) {
    _products[productId]!.qty++;
    notifyListeners();
  }

  void decreaseQty(int productId) {
    _products[productId]!.qty--;
    notifyListeners();
  }

  List<ProductModel> itemOnCart() {
    return _products.values.where((element) => element.isInCart).toList();
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
      if (_products.containsKey(product.id)) {
        _productsByCategory[product.id] = product;
        _productsByCategory.values.forEach((pC) {
          _products.values.forEach((p) {
            p.id == pC.id && p.isInCart ? pC.isInCart = true : false;
            p.id == pC.id && p.isInCart ? pC.qty = p.qty : pC.qty;
          });
        });
      } else {
        _productsByCategory[product.id] = product;
        _products[product.id] = product;
        _productsSearchItems[product.id] = product;
      }
    });
    notifyListeners();
    return result;
  }

  discountPrice(price, discountPercentage) {
    var discountAmount = price * (discountPercentage / 100);
    var dis = price - discountAmount;
    return dis;
  }
}
