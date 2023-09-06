/* 
  {
    "id": 1,
    ==> "userId": 1,
    ==> "date": "2020-03-02T00:00:00.000Z",
    ==> "products": [
      {
        "productId": 1,
        "quantity": 4
      },
      {
        "productId": 2,
        "quantity": 1
      },
      {
        "productId": 3,
        "quantity": 6
      }
    ],
    ===> add price and 
    "__v": 0
  },

*/

import 'package:ecommerce_finalproject/models/prodects_model.dart';

class OrderItem {
  int? userID;
  int? quantity;
  double? price;
  Product? product;

  OrderItem();

  OrderItem.fromJson(Map<String, dynamic> JsonDate) {
    userID = JsonDate['userID'];
    quantity = JsonDate['quantity'];
    price = JsonDate['price'];
    product = Product.fromJson(JsonDate['product']);
  }

  Map<String, dynamic> toJson() => {
        "userID": userID,
        "quantity": quantity,
        "price": price,
        "product": product?.toJson(),
      };
}
