import 'package:demo_ecom/utils/constant/constant.dart';
import 'package:demo_ecom/utils/services/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCategoryView extends StatefulWidget {
  final String categoryName;
  final void Function() onTap;
  const ProductCategoryView(
      {Key? key, required this.categoryName, required this.onTap})
      : super(key: key);

  @override
  State<ProductCategoryView> createState() => _ProductCategoryViewState();
}

class _ProductCategoryViewState extends State<ProductCategoryView> {
  Map<String, IconData> iconsMap = {
    'smartphones': Icons.phone_android,
    'laptops': Icons.laptop_mac,
    'fragrances': Icons.bolt,
    'skincare': Icons.face_sharp,
    'groceries': Icons.local_grocery_store,
    'home-decoration': Icons.home_rounded,
    'furniture': Icons.add_box_rounded,
    'tops': Icons.toc_sharp,
  };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4),
        child: Card(
          color: const Color(0xff309E94),
          elevation: 6,
          shadowColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Icon(
                  iconsMap[widget.categoryName],
                  size: 25,
                  color: CustomColors.leftMenuIcon,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.categoryName,
                  style: CustomTextStyle().categoryTextStyle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
