import 'package:demo_ecom/core/common/product_card.dart';
import 'package:demo_ecom/core/model/products.dart';
import 'package:demo_ecom/core/provider/products.dart';
import 'package:demo_ecom/core/screen/home/product_details.dart';
import 'package:demo_ecom/core/screen/home/product_search_delegeate.dart';
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

  bool isListView = true;

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
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final product = await showSearch<ProductModel>(
                context: context,
                delegate: ProductSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Products",
                style: CustomTextStyle().smallTitleHeaderStyle,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isListView ? isListView = false : isListView = true;
                  });
                },
                icon: Icon(isListView ? Icons.grid_view : Icons.list_alt),
                iconSize: 30,
              ),
            ],
          ),
          const Divider(
            height: 2,
            thickness: 2,
            color: Colors.black,
          ),
          const SizedBox(
            height: CustomSpacing.medium,
          ),
          isListView
              ? Expanded(
                  child: ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Productdetails(
                                      productId: productList[index].id)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                              elevation: 10,
                              shadowColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              color: Colors.blue.shade200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.grey.shade100,
                                      child: ClipOval(
                                          child: Image.network(
                                        productList[index].thumbnail == ""
                                            ? "https://thumbs.dreamstime.com/z/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482930.jpg"
                                            : productList[index].thumbnail,
                                        fit: BoxFit.fill,
                                        height: 100,
                                        width: 100,
                                      )),
                                      radius: 45,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 250,
                                          child: Text(
                                            "Product Name:  ${productList[index].title}",
                                            maxLines: 2,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            "Price: ${productList[index].price}",
                                          ),
                                        ),
                                        Text(
                                            "Product Rating : ${productList[index].rating}"),
                                      ],
                                    )
                                  ],
                                ),
                              )),
                        ),
                      );
                    },
                  ),
                )
              : Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(product.thumbnail,
                                      height: 100,
                                      width: 180,
                                      fit: BoxFit.cover),
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
