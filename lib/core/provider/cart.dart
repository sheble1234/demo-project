import 'dart:collection';
import 'dart:convert' as convert;
import 'package:demo_ecom/core/model/product_add_to_cart.dart';
import 'package:demo_ecom/utils/api_service.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  CartProvider(apiService) : _apiService = apiService;

  final APIServiceClass _apiService;
  final List<ProductAddToCart> productsOnCart = [];

  Future<dynamic> addItemIntoCart(int id) async {
    print("ddd:${productsOnCart.length}");
    if (productsOnCart.where((element) => element.id == id).length > 1) {
      productsOnCart.removeWhere((element) => element.id == id);
    }
    productsOnCart.add(ProductAddToCart(
      id: id,
      quantity: 1,
    ));
    print(productsOnCart.first.id);
  }
}
