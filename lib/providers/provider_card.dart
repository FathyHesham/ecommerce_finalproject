import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecommerce_finalproject/main.dart';
import 'package:ecommerce_finalproject/models/orderitem_model.dart';
import 'package:ecommerce_finalproject/models/prodects_model.dart';
import 'package:ecommerce_finalproject/services/prefservice.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ProviderCard extends ChangeNotifier {
  // create list of OrderItems
  List<OrderItem>? orderItem;
  // create prefs key
  final _prefrenceKey = "orderItem";

  int itemQuantity = 1;

  // create loading dialog
  final SimpleFontelicoProgressDialog _dialog =
      SimpleFontelicoProgressDialog(context: navigatorKey.currentContext!);

  //! create func. to get the item in shopping card
  Future<void> getCardProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    // check to if the item in the shopping card or not
    if (PrefService.preferences?.getStringList(_prefrenceKey) == null) return;
    // else, get the list of items and convert the encoded list to decoded list
    var encodedList = PrefService.preferences
        ?.getStringList(_prefrenceKey)
        ?.map((e) => jsonDecode(e))
        .toList();
    // Convert the decoded items into a list of OrderItem objects
    orderItem = encodedList?.map((e) => OrderItem.fromJson(e)).toList();
    // Sort items in Shopping by their (userID)
    orderItem?.sort((a, b) => a.userID?.compareTo(b.userID ?? 0) ?? 0);
    notifyListeners();
  }

  //! create func. to add the items in shopping card
  void addProductsItems(Product product) async {
    // create the dialog to loading...
    _dialog.show(
        message: "Lodding...",
        type: SimpleFontelicoProgressDialogType.hurricane);

    // Get the list of encoded items from the preds. ,
    //if it does not exist, an empty list will be generated
    var encodedList =
        PrefService.preferences?.getStringList(_prefrenceKey) ?? [];
    // create object from OrderItems class
    var orderItems = OrderItem();
    orderItems.userID = product.id;
    orderItems.quantity = itemQuantity;
    orderItems.product = product;
    orderItems.price = (itemQuantity * (product.price ?? 0)).toDouble();
    // encoded the list of items
    var encodedOrderItems = jsonEncode(orderItems.toJson());
    // add the items in the shopping card
    encodedList.add(encodedOrderItems);
    // save the order items in prefs.
    await PrefService.preferences?.setStringList(_prefrenceKey, encodedList);
    // refresh the list
    await getCardProducts();
    // Hiden the dialog
    _dialog.hide();
  }

  //! create func. to remove the product in the shopping card
  void removeItemFromCard(int productID) async {
    // create the dialog to loading...
    _dialog.show(
        message: "Lodding...",
        type: SimpleFontelicoProgressDialogType.hurricane);

    // get the list of shopping card
    var encodedList = PrefService.preferences?.getStringList(_prefrenceKey);

    // remove the item in list
    encodedList
        ?.removeWhere((element) => jsonDecode(element)["userID"] == productID);
    // save the order items in prefs.
    await PrefService.preferences
        ?.setStringList(_prefrenceKey, encodedList ?? []);
    // refresh the shopping card
    await getCardProducts();
    //Hiden the dialog
    _dialog.hide();
  }

  //! check the item in card
  bool checkItemInCard(int prodectID) {
    // get the list of item in shopping card
    var encodedList = PrefService.preferences?.getStringList(_prefrenceKey);

    // decode the list of item
    var decodedList = encodedList?.map((e) => jsonDecode(e)).toList();

    // check the item in card or not
    return decodedList?.any((element) => element["userID"] == prodectID) ??
        false;
  }

  //! create func. to get item quantity
  void getItemsQuantity(int productID) {
    // get the list of shopping card in prefs.
    var encodedList = PrefService.preferences?.getStringList(_prefrenceKey);

    // decoded the list of shopping card
    var decodedList = encodedList?.map((e) => jsonDecode(e)).toList();

    // check the ID of item in this list or not
    var item = decodedList?.firstWhere(
        (element) => element["userID"] == productID,
        orElse: () => null);
    // Updates the item quantity to the specified value
    //if the item exists, otherwise it is set to 1
    itemQuantity = (item != null) ? item["quantity"] : 1;

    notifyListeners();
  }

  //! create func. to make change quantity of item
  void changeItemQuantity(int productID, {required bool decrease}) async {
    // create the dialog to loading...
    _dialog.show(
        message: "Lodding...",
        type: SimpleFontelicoProgressDialogType.hurricane);

    // if cleck the button to decrease
    if (decrease == true) {
      if (itemQuantity == 1) {
        _dialog.hide();
        return;
      }
      itemQuantity--; // decrease the quantity of item
    } else {
      itemQuantity++; // increase the quantity of item
    }

    if (!checkItemInCard(productID)) {
      notifyListeners();
      _dialog.hide();
      return;
    }

    // get the list of shopping card in prefs.
    var encodedList = PrefService.preferences?.getStringList(_prefrenceKey);

    // decode the list of shopping card
    var orderList =
        encodedList?.map((e) => OrderItem.fromJson(jsonDecode(e))).toList();

    // search the item in list and update the quantity of item
    var updateItem =
        orderList?.firstWhere((element) => element.userID == productID);

    // remove the item in list
    orderList?.removeWhere((element) => element.userID == productID);

    // Update the item's quantity and price based on the new quantity
    updateItem?.quantity = itemQuantity;
    updateItem?.price =
        ((updateItem.product?.price ?? 0) * itemQuantity).toDouble();

    // add the item in shopping card after update
    orderList?.add(updateItem!);

    // encoded the list of shopping card
    var encodedUpdateList =
        orderList?.map((e) => jsonEncode(e.toJson())).toList();

    // save the list of shopping card in prefs.
    await PrefService.preferences
        ?.setStringList(_prefrenceKey, encodedUpdateList ?? []);

    // get the new quantity of item
    getItemsQuantity(productID);
    // refresh the card
    await getCardProducts();

    // hiden the dialog
    _dialog.hide();
  }

  //! create func. to get the total of salary for items in card
  double getTotalSalaryOfItems() {
    double totalSalary = 0;
    for (var item in orderItem ?? []) {
      totalSalary += (item.price ?? 0);
      getTotalNumberOfItems();
    }
    return totalSalary;
  }

  //! create func. to get the total of number for items
  num getTotalNumberOfItems() {
    num countItem = 0;
    for (var item in orderItem ?? []) {
      countItem += (item.quantity ?? 0);
    }
    return countItem;
  }

  //! create func. to when click the button to buy
  void buyNow() async {
    // create the dialog to loading...
    _dialog.show(
        message: "Lodding...",
        type: SimpleFontelicoProgressDialogType.hurricane);

    // date now
    var dateNow = DateTime.now();

    try {
      // get the list of shopping card in prefs.
      var encodedList = PrefService.preferences?.getStringList(_prefrenceKey);

      // post the request the order
      var response =
          await http.post(Uri.parse("https://fakestoreapi.com/carts"), body: {
        "date": "${dateNow.day} / ${dateNow.month} / ${dateNow.year}",
        "products": jsonEncode(encodedList),
      });

      // check the request is success or not
      if (response.statusCode >= 200 && response.statusCode < 300) {
        await PrefService.preferences?.setStringList(_prefrenceKey, []);
        await getCardProducts();
        _dialog.hide();

        // todo : create Alert
        Alert(
          context: navigatorKey.currentContext!,
          title: "Order Done",
          type: AlertType.success,
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(navigatorKey.currentContext!),
              child: const Text("OK"),
            )
          ],
        ).show();
      } else {
        _dialog.hide();
        // todo : create Alert
        Alert(
          context: navigatorKey.currentContext!,
          title: "Error In Creating Order",
          desc: "Status Code : ${response.statusCode}",
          type: AlertType.error,
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(navigatorKey.currentContext!),
              child: const Text("OK"),
            )
          ],
        ).show();
      }
    } catch (e) {
      _dialog.hide();
      // todo : create Alert
      Alert(
        context: navigatorKey.currentContext!,
        title: "Error In Creating Order",
        desc: "Status Code : ${e.toString()}",
        type: AlertType.error,
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(navigatorKey.currentContext!),
            child: const Text("OK"),
          )
        ],
      ).show();
    }
  }
}
