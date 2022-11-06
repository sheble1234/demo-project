import 'dart:collection';
import 'dart:convert' as convert;
import 'package:demo_ecom/core/model/product_add_to_cart.dart';
import 'package:demo_ecom/core/model/products.dart';
import 'package:demo_ecom/core/provider/products.dart';
import 'package:demo_ecom/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future addToCart() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    productProvider.itemOnCart().forEach((element) {
      productsOnCart
          .add(ProductAddToCart(id: element.id, quantity: element.qty.toInt()));
    });
    final userId = _prefs.getInt("userId");
    print(userId);
    Response result = await _api.post("/carts/add",
        body: {"userId": userId, "products": productsOnCart});
    print("Result :${result.body}");
    if (result.statusCode == 200) {}
    return result;
  }
}
