import 'package:demo_ecom/core/common/product_card.dart';
import 'package:demo_ecom/core/provider/products.dart';
import 'package:demo_ecom/utils/constant/constant.dart';
import 'package:demo_ecom/utils/services/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ProductProvider>(context, listen: false).getProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);

    var productList = productData.productList;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "E-Com",
          style: CustomTextStyle().homeTitleStyle,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Products List",
            style: CustomTextStyle().homeTitleStyle,
          ),
          const Divider(
            height: 2,
            thickness: 2,
            color: Colors.black,
          ),
          const SizedBox(
            height: CustomSpacing.medium,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
              ),
              itemBuilder: (context, int index) {
                var product = productList[index];
                return Card(
                  color: CustomColors.lightCyan,
                  elevation: 10,
                  shadowColor: Colors.black38,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: SizedBox(
                      height: 200,
                      width: 180,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(product.thumbnail,
                                height: 100, width: 180, fit: BoxFit.cover),
                            Text("Product Name: ${product.title}"),
                            Text("Product Price: ${product.price}"),
                            Text("Product Rateing: ${product.rating}"),
                          ],
                        ),
                      )),
                );
              },
              itemCount: productList.length,
            ),
          ),
        ],
      ),
    );
  }
}
