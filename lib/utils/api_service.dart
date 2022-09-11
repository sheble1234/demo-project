import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:http/http.dart';

class APIServiceClass {
  Uri _makeUri(String path, {Map<String, String?>? queryParams}) {
    return Uri.https("dummyjson.com", path, queryParams);
  }

  Future get(String path, {Map<String, String?>? queryParams}) async {
    var uri = _makeUri(path, queryParams: queryParams);
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString('Token') ?? '';
    Response result =
        await http.get(uri, headers: {'Authorization': 'Bearer ' + ""});
    return result;
  }

  Future post(
    String path, {
    Object? body,
    Map<String, String?>? queryParams,
  }) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString('Token') ?? '';
    var uri = _makeUri(path, queryParams: queryParams);

    var result = await http.post(
      uri,
      body: convert.jsonEncode(body),
      headers: {
        'Authorization': 'Bearer ' + "",
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(uri);
    // print("api post Result : ${result.body}");
    return result;
  }

  Future put(
    String path, {
    required Object body,
  }) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString('Token') ?? '';
    var result = await http.put(
      _makeUri(path),
      body: convert.jsonEncode(body),
      headers: {
        'Authorization': 'Bearer ' + "",
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return result;
  }

  Future delete(String path, {Object? body}) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString('Token') ?? '';
    var result = await http.delete(
      _makeUri(path),
      body: convert.jsonEncode(body),
      headers: {
        'Authorization': 'Bearer ' + "",
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return result;
  }
}
