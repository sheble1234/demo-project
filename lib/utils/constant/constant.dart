import 'package:demo_ecom/utils/services/theme.dart';
import 'package:flutter/material.dart';

class CustomTextStyle {
  final homeTitleStyle = const TextStyle(
      fontSize: 26, fontWeight: FontWeight.bold, color: CustomColors.darkText);
  final smallTitleHeaderStyle = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.w700, color: CustomColors.darkText);
  final productNameTextStyle = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: CustomColors.darkText);
  final productBasePriceTextStyle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.bold, color: CustomColors.lightText);
  final productRatingTextStyle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.bold, color: Colors.pink);
  final productQtyTextStyle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.bold, color: Colors.pinkAccent);
  final categoryTextStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: CustomColors.leftMenuIcon);
}
