/* 
  {
    ************** class Product **************
    "id": 1,
    "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
    "price": 109.95,
    "description": "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
    "category": "men's clothing",
    "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    
    ************** class Rating ****************
    "rating": {
      "rate": 3.9,
      "count": 120
    }
  }
*/

class Product {
  int? id;
  String? title;
  num? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;
  Product();
  // create fromjson --> convert the json tp Map
  Product.fromJson(Map<String, dynamic> JsonDate) {
    id = JsonDate["id"];
    title = JsonDate["title"];
    price = JsonDate["price"];
    description = JsonDate["description"];
    image = JsonDate["image"];
    category = JsonDate["category"];
    rating = Rating.fromJson(JsonDate["rating"]);
  }
  // create map to convert of json
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating?.toJson(),
      };
}

class Rating {
  num? rate;
  int? count;

  // create fromjson --> convert the json tp Map
  Rating.fromJson(Map<String, dynamic> date) {
    rate = date['rate'];
    count = date['count'];
  }

  // create map to convert of json
  Map<String, dynamic> toJson() => {"rate": rate, "count": count};
}
