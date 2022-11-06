import 'package:demo_ecom/core/model/products.dart';
import 'package:demo_ecom/core/provider/auth.dart';
import 'package:demo_ecom/core/provider/cart.dart';
import 'package:demo_ecom/core/provider/products.dart';
import 'package:demo_ecom/core/screen/profile/login.dart';
import 'package:demo_ecom/utils/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/src/iterable_extensions.dart';

class CartDetailsPage extends StatefulWidget {
  const CartDetailsPage({Key? key}) : super(key: key);

  @override
  State<CartDetailsPage> createState() => _CartDetailsPageState();
}

class _CartDetailsPageState extends State<CartDetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<double> disCount = [];
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    final productData = Provider.of<ProductProvider>(context);
    final cartData = Provider.of<CartProvider>(context);

    final _itemOnCart = productData.itemOnCart();
    // final product = products.getProductById(widget.productId) ?? ProductModel();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cart Details",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _itemOnCart.clear();
              },
              icon: Icon(Icons.clear_all_rounded)),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          authData.userToken != ''
              ? cartData.addToCart()
              : Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        child: Icon(Icons.check_box),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _itemOnCart.length,
                itemBuilder: (context, int i) {
                  disCount.add((productData.discountPrice(_itemOnCart[i].price,
                          _itemOnCart[i].discountPercentage) *
                      _itemOnCart[i].qty));
                  return Card(
                      elevation: 10,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      color: Colors.blue.shade200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey.shade100,
                                  child: ClipOval(
                                      child: Image.network(
                                    _itemOnCart[i].thumbnail == ""
                                        ? "https://thumbs.dreamstime.com/z/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482930.jpg"
                                        : _itemOnCart[i].thumbnail,
                                    fit: BoxFit.fill,
                                    height: 100,
                                    width: 100,
                                  )),
                                  radius: 45,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 250,
                                      child: Text(
                                        "Product Name:  ${_itemOnCart[i].title}",
                                        maxLines: 2,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        "Price: ${_itemOnCart[i].price}",
                                      ),
                                    ),
                                    Text(
                                      "৳ ${productData.discountPrice(_itemOnCart[i].price, _itemOnCart[i].discountPercentage)}",
                                      style: CustomTextStyle()
                                          .productBasePriceTextStyle,
                                    ),
                                    Text("QTY: ${_itemOnCart[i].qty}"),
                                    Text(
                                        "Product Rating : ${_itemOnCart[i].rating}"),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ));
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Total: ${(_itemOnCart.map((e) => e.price * e.qty).sum).toStringAsFixed(2)}"),
                Text(
                    "Total after discount: ${disCount.map((e) => e).sum.toStringAsFixed(2)}"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
