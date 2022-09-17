import 'package:demo_ecom/core/model/products.dart';
import 'package:demo_ecom/core/provider/products.dart';
import 'package:demo_ecom/core/screen/home/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductSearchDelegate extends SearchDelegate<ProductModel> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, ProductModel());
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: _search(context),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(
                  snapshot.data[index].thumbnail,
                  width: 100,
                  height: 100,
                ),
                title: Text(
                  snapshot.data[index].title,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Productdetails(
                              productId: snapshot.data[index].id)));
                },
              );
            },
            itemCount: snapshot.data!.length,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final suggestions = productData.productSearchList.where((product) {
      return product.title.toLowerCase().contains(query.toLowerCase());
    });

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Image.network(
            suggestions.elementAt(index).thumbnail,
            width: 100,
            height: 100,
          ),
          title: Text(
            suggestions.elementAt(index).title,
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Productdetails(
                        productId: suggestions.elementAt(index).id)));
          },
        );
      },
    );
  }

  Future<List<ProductModel>> _search(BuildContext context) async {
    final productData = Provider.of<ProductProvider>(context, listen: false);
    final queryParameters = <String, String>{'q': query};
    productData.getProductSearchData(queryParams: queryParameters);
    return productData.productSearchList;
  }
}
