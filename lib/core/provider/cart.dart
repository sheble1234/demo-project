import 'dart:collection';
import 'dart:convert' as convert;
import 'package:demo_ecom/core/model/product_add_to_cart.dart';
import 'package:demo_ecom/core/provider/products.dart';
import 'package:demo_ecom/utils/api_service.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  CartProvider(api, this.productProvider) : _api = api;
  final APIServiceClass _api;
  final ProductProvider productProvider;

  final List<ProductAddToCart> productsOnCart = [];
  Future<dynamic> addItemIntoCart(int id, bool? isInCart) async {
    productsOnCart.add(ProductAddToCart(
      id: id,
      quantity: 1,
    ));
  }

  Future<dynamic> removeItemIntoCart(int id, bool isInCart) async {
    productsOnCart.removeWhere((element) => element.id == id);
  }
}
