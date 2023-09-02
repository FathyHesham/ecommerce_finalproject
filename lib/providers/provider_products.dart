import 'dart:convert';

import 'package:ecommerce_finalproject/models/prodects_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProviderProduct extends ChangeNotifier {
  // create two list -> [categories , products]
  List<String>? categories;
  List<Product>? products;

  final productsURL = "https://fakestoreapi.com/products";
  String? selectCategories;

  void changeCategories(String newCat) {
    if (selectCategories == newCat) return;
    selectCategories = newCat;
    getProducts();
    notifyListeners();
  }

  void getProducts() async {
    try {
      if (products != null) products = null;
      var response =
          await http.get(Uri.parse("$productsURL/category/$selectCategories"));
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        products = List<Product>.from(
            jsonDecode(response.body).map((e) => Product.fromJson(e)));
      } else {
        products = [];
      }
    } catch (e) {
      products = [];
    }
    notifyListeners();
  }

  void getCategories() async {
    try {
      var response = await http.get(Uri.parse("$productsURL/categories"));
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        categories = List<String>.from(jsonDecode(response.body));
      } else {
        categories = [];
      }
    } catch (e) {
      categories = [];
    }
    notifyListeners();
  }
}
