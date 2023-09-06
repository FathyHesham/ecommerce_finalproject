import 'dart:convert';
import 'package:ecommerce_finalproject/main.dart';
import 'package:ecommerce_finalproject/models/prodects_model.dart';
import 'package:ecommerce_finalproject/services/prefservice.dart';
import 'package:flutter/material.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ProviderFavourite extends ChangeNotifier {
  List<Product>? productsFavourite;
  final _prefrenceKey = "productsFavourite";

  // create loading dialog
  final SimpleFontelicoProgressDialog _dialog =
      SimpleFontelicoProgressDialog(context: navigatorKey.currentContext!);

  // I will return if it is one of my favorite products or not
  bool isFavourite(int productID) =>
      (productsFavourite?.any((element) => element.id == productID) ?? false);

  // create future func. to get the favourite producte and make encode, decode for it
  Future<void> getFavouriteProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    // if prefs is null --> same state
    if (PrefService.preferences?.getStringList(_prefrenceKey) == null) return;
    // else prefs is not null --> change state and get the value to encode
    var encodedList = PrefService.preferences?.getStringList(_prefrenceKey);

    // get the favourite products and decoded it
    var decodedList = encodedList?.map((e) => jsonDecode(e)).toList() ?? [];
    productsFavourite = decodedList.map((e) => Product.fromJson(e)).toList();
    // listen of change
    notifyListeners();
  }

  // create func. make loading and add the favourite producte
  void addFavouriteProducts(Product product) async {
    // create the dialog to loading...
    _dialog.show(
        message: "Lodding...",
        type: SimpleFontelicoProgressDialogType.hurricane);
    // Get the encoded list of preferences, and if it does not exist, create a new list
    var encodedList =
        PrefService.preferences?.getStringList(_prefrenceKey) ?? [];
    // encoded the list of favourite products
    var encodedProducts = jsonEncode(product.toJson());
    // add the products encode in the list
    encodedList.add(encodedProducts);
    // save the list in prefs.
    await PrefService.preferences?.setStringList(_prefrenceKey, encodedList);
    // call getFavouriteProducts func.
    await getFavouriteProducts();
    // hiden the dialog
    _dialog.hide();
  }

  // create func. to remove the favourite product in the list
  void removeFavouriteProducts(int id) async {
    // create the dialog to loading...
    _dialog.show(
        message: "Lodding...",
        type: SimpleFontelicoProgressDialogType.hurricane);
    // get the list of favourite product from pref. and decoded it
    var decodedList = PrefService.preferences
        ?.getStringList(_prefrenceKey)
        ?.map((e) => jsonDecode(e))
        .toList();

    // reomve the favourite product with the specified 'id' from the decoded list
    decodedList?.removeWhere((element) => element['id'] == id);

    // after removing the product, encoded the list
    var encodedList = decodedList?.map((e) => jsonEncode(e)).toList();
    // save the list in prefs.
    await PrefService.preferences
        ?.setStringList(_prefrenceKey, encodedList ?? []);
    // call getFavouriteProducts func.
    await getFavouriteProducts();
    // hiden the dialog
    _dialog.hide();
  }
}
