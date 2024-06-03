import 'package:shoppingapp/login/login_model.dart';

class homeModel {
  bool? status;
  allDataModel? data;

  homeModel.fromJson(Map<String, dynamic> homeData) {
    status = homeData["status"];
    data = allDataModel.fromJson(homeData["data"]);
  }
}

class bannersModel {
// banners: id,image,category,products - products: id,price,old_price,discount,image,name,description,images,in_fav,in_cart

  int? id;
  String? image;
  String? category;
  String? product;

  // named Constructor
  bannersModel.fromJson(Map<String, dynamic> bannersData) {
    id = bannersData["id"];
    image = bannersData["image"];
    category = bannersData["category"];
    product = bannersData["product"];
  }
}

class productsModel {
  // products: id,price,old_price,discount,image,name,description,images,in_fav,in_cart

  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;
  String? name;

  // String? description;
  // String? images;
  bool? in_fav;
  bool? in_cart;

  // named Constructor
  productsModel.fromJson(Map<String, dynamic> productsData) {
    id = productsData["id"];
    price = productsData["price"];
    old_price = productsData["old_price"];
    discount = productsData["discount"];
    image = productsData["image"];
    // description = productsData["description"];
    name = productsData["name"];
    in_fav = productsData["in_favorites"];
    in_cart = productsData["in_cart"];
  }
}

class allDataModel {
  List<bannersModel> banners = [];
  List<productsModel> products = [];

  allDataModel.fromJson(Map<String, dynamic> allData) {
    allData["banners"].forEach((element) {
      banners.add(bannersModel.fromJson(
          element)); // be care that the element is from bannersModel not just "element"
    });

    // print("Banners: ${banners}");

    allData["products"].forEach((element) {
      products.add(productsModel.fromJson(element));
    });
    // print("Products: ${products}");
  }
}
