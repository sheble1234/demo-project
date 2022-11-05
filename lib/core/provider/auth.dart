import 'dart:collection';
import 'dart:convert' as convert;
import 'package:demo_ecom/core/model/product_add_to_cart.dart';
import 'package:demo_ecom/core/provider/products.dart';
import 'package:demo_ecom/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(api) : _api = api;
  final APIServiceClass _api;

  var userToken = '';
  var userName = '';
  var userGender = '';
  var userEmail = '';
  var userImage = '';

  void loadUser() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      userToken = _prefs.getString("Token") ?? "";
      userName = _prefs.getString("userName") ?? '';
      userEmail = _prefs.getString("userEmail") ?? '';
      userImage = _prefs.getString("userImage") ?? '';
      userGender = _prefs.getString("userGender") ?? '';
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void userLogut() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.remove("Token");
      _prefs.remove("userName");
      _prefs.remove("userEmail");
      _prefs.remove("userImage");
      _prefs.remove("userGender");
    } catch (e) {
      print(e);
    } finally {
      loadUser();
    }
    notifyListeners();
  }

  Future<Response> login(String userName, String passWord) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Response result = await _api.post("/auth/login",
        body: {"username": userName, "password": passWord});
    print("Result :${result.body}");
    if (result.statusCode == 200) {
      var data = convert.jsonDecode(result.body);
      _prefs.setString("Token", data["token"]);
      _prefs.setString("userName", data["firstName"] + data["lastName"]);
      _prefs.setString("userEmail", data["email"]);
      _prefs.setString("userImage", data["image"]);
      _prefs.setString("userGender", data["gender"]);
      loadUser();
    }
    return result;
  }
}
