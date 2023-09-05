import 'package:ecommerce_finalproject/models/orderitem_model.dart';
import 'package:flutter/material.dart';

class ProviderCard extends ChangeNotifier {
  // create list of OrderItems
  List<OrderItem>? orderItem;
  // create prefs key
  final _prefrenceKey = "orderItem";

  int itemQuantity = 1;

  
}
