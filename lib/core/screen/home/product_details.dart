import 'package:demo_ecom/core/model/products.dart';
import 'package:demo_ecom/core/provider/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Productdetails extends StatefulWidget {
  final int productId;
  const Productdetails({Key? key, required this.productId}) : super(key: key);

  @override
  State<Productdetails> createState() => _ProductdetailsState();
}

class _ProductdetailsState extends State<Productdetails> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   Provider.of<ProductProvider>(context, listen: false)
  //       .getProductByIdFromAPI(widget.productId);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context);
    final product = products.getProductById(widget.productId) ?? ProductModel();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product Details",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: Image.network(product.thumbnail),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.blue,
                  elevation: 10,
                  shadowColor: Colors.yellow,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Product ID: ${product.id}"),
                            Text("Product Name: ${product.title}"),
                            Text("Price: ${product.price}"),
                            Text("Discount: ${product.discountPercentage}"),
                            Text("Rating: ${product.rating}"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
