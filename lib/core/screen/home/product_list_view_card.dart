import 'package:demo_ecom/core/model/products.dart';
import 'package:demo_ecom/core/provider/cart.dart';
import 'package:demo_ecom/core/provider/products.dart';
import 'package:demo_ecom/utils/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListViewCard extends StatefulWidget {
  const ProductListViewCard({
    Key? key,
    required this.productModel,
    required this.onTap,
  }) : super(key: key);

  final void Function() onTap;
  final ProductModel productModel;

  @override
  State<ProductListViewCard> createState() => _ProductListViewCardState();
}

class _ProductListViewCardState extends State<ProductListViewCard> {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final cartData = Provider.of<CartProvider>(context);
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            elevation: 10,
            shadowColor: Colors.grey,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: const Color(0xffc0f1f2),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              widget.productModel.thumbnail == ""
                                  ? "https://thumbs.dreamstime.com/z/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482930.jpg"
                                  : widget.productModel.thumbnail,
                              fit: BoxFit.fill,
                              height: 100,
                              width: 100,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  widget.productModel.title,
                                  style: CustomTextStyle().productNameTextStyle,
                                  maxLines: 2,
                                ),
                              ),
                              Text(
                                "৳ ${widget.productModel.price}",
                                style:
                                    CustomTextStyle().productBasePriceTextStyle,
                              ),
                              Text(
                                "☆${widget.productModel.rating}",
                                style: CustomTextStyle().productRatingTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          widget.productModel.isInCart
                              ? IconButton(
                                  onPressed: () {
                                    cartData
                                        .removeItemIntoCart(
                                            widget.productModel.id, true)
                                        .then((value) {
                                      productData.removeItemInCart(
                                          widget.productModel.id, false);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.remove_shopping_cart,
                                    size: 30,
                                  ))
                              : IconButton(
                                  onPressed: () {
                                    cartData
                                        .addItemIntoCart(
                                            widget.productModel.id, true)
                                        .then((value) {
                                      productData.addItemInCart(
                                          productId: widget.productModel.id,
                                          isInCart: true);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add_shopping_cart_sharp,
                                    size: 30,
                                  )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              widget.productModel.isInCart
                                  ? IconButton(
                                      onPressed: widget.productModel.qty <= 1
                                          ? () {
                                              cartData
                                                  .removeItemIntoCart(
                                                      widget.productModel.id,
                                                      true)
                                                  .then((value) {
                                                productData.removeItemInCart(
                                                    widget.productModel.id,
                                                    false);
                                              });
                                            }
                                          : () {
                                              productData.decreaseQty(
                                                  widget.productModel.id);
                                            },
                                      icon: const Icon(Icons.remove_circle))
                                  : Container(),
                              widget.productModel.isInCart
                                  ? Text(
                                      "${widget.productModel.qty.toInt()}",
                                      style:
                                          CustomTextStyle().productQtyTextStyle,
                                    )
                                  : Container(),
                              widget.productModel.isInCart
                                  ? IconButton(
                                      onPressed: () {
                                        productData.increaseQty(
                                            widget.productModel.id);
                                      },
                                      icon: const Icon(Icons.add_circle))
                                  : Container(),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
