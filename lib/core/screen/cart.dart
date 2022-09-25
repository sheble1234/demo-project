import 'package:demo_ecom/core/model/products.dart';
import 'package:demo_ecom/core/provider/cart.dart';
import 'package:demo_ecom/core/provider/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartDetailsPage extends StatefulWidget {
  const CartDetailsPage({Key? key}) : super(key: key);

  @override
  State<CartDetailsPage> createState() => _CartDetailsPageState();
}

class _CartDetailsPageState extends State<CartDetailsPage> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   Provider.of<ProductProvider>(context, listen: false)
  //       .getProductByIdFromAPI(widget.productId);
  //   super.initState();
  // }
  final List<ProductModel> _itemOnCart = [];
  @override
  Widget build(BuildContext context) {
    final carts = Provider.of<CartProvider>(context);
    final products = Provider.of<ProductProvider>(context);
    products.productList.forEach((product) {
      carts.productsOnCart.forEach((element) {
        if (product.id == element.id) {
          _itemOnCart.add(product);
        }
      });
    });
    // final product = products.getProductById(widget.productId) ?? ProductModel();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Cart Details",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: _itemOnCart.length,
            itemBuilder: (context, int i) {
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
                                    "Product Rating : ${_itemOnCart[i].rating}"),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ));
            }));
  }
}


//  Column(
//         children: [
//           SizedBox(
//             height: 250,
//             child: Image.network(product.thumbnail),
//           ),
//           Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Card(
//                   color: Colors.blue,
//                   elevation: 10,
//                   shadowColor: Colors.yellow,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16)),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Product ID: ${product.id}"),
//                             Text("Product Name: ${product.title}"),
//                             Text("Price: ${product.price}"),
//                             Text("Discount: ${product.discountPercentage}"),
//                             Text("Rating: ${product.rating}"),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),