import 'package:demo_ecom/core/model/products.dart';
import 'package:demo_ecom/core/provider/auth.dart';
import 'package:demo_ecom/core/provider/cart.dart';
import 'package:demo_ecom/core/provider/products.dart';
import 'package:demo_ecom/core/screen/cart.dart';
import 'package:demo_ecom/core/screen/home/product_category_view.dart';
import 'package:demo_ecom/core/screen/home/product_details.dart';
import 'package:demo_ecom/core/screen/home/product_list_view_card.dart';
import 'package:demo_ecom/core/screen/home/product_search_delegeate.dart';
import 'package:demo_ecom/core/screen/products_by_category.dart';
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
    Provider.of<ProductProvider>(context, listen: false).getProductCategoris();
    Provider.of<AuthProvider>(context, listen: false).loadUser();
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
            icon: const Icon(Icons.shopping_basket),
            onPressed: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartDetailsPage()));
            },
          ),
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
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (int i = 0; i < productData.productCategoryList.length; i++)
                  ProductCategoryView(
                    categoryName: productData.productCategoryList[i],
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductsByCategory(
                                  categoryName:
                                      productData.productCategoryList[i])));
                    },
                  )
              ],
            ),
          ),
          const SizedBox(
            height: CustomSpacing.medium,
          ),
          isListView
              ? Expanded(
                  child: ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (context, int index) {
                      return ProductListViewCard(
                          productModel: productList[index],
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Productdetails(
                                        productId: productList[index].id)));
                          });
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
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Productdetails(
                                      productId: productList[index].id)));
                        },
                        child: Card(
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
                        ),
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
