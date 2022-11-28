import 'package:demo_ecom/core/common/custom_card.dart';
import 'package:demo_ecom/core/provider/auth.dart';
import 'package:demo_ecom/core/provider/cart.dart';
import 'package:demo_ecom/core/provider/products.dart';
import 'package:demo_ecom/core/screen/home/home_page.dart';
import 'package:demo_ecom/firabase_config.dart';
import 'package:demo_ecom/utils/api_service.dart';
import 'package:demo_ecom/utils/services/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/screen/bottom_navigator.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final APIServiceClass api = APIServiceClass();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider = ProductProvider(api);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider(api)),
        ChangeNotifierProvider(
            create: (_) => CartProvider(api, productProvider)),
        ChangeNotifierProvider(create: (_) => AuthProvider(api)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: customTheme,
        home: BottomNavBar(),
      ),
    );
  }
}
