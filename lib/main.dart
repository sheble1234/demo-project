import 'package:demo_ecom/core/common/custom_card.dart';
import 'package:demo_ecom/core/provider/products.dart';
import 'package:demo_ecom/core/screen/home/home_page.dart';
import 'package:demo_ecom/utils/api_service.dart';
import 'package:demo_ecom/utils/services/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final APIServiceClass api = APIServiceClass();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider(api)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: customTheme,
        home: const HomePage(),
      ),
    );
  }
}
