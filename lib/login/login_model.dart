// this class model to help us to access/pass the json data that come from API

// to get the login model
class shopLoginModel {
  bool? status;
  String? message;
  userData? data;

  shopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] != null ? userData.fromJson(json["data"]) : null;   //this line to check if the data come with null value or not
  }
}

// about the user data from API
class userData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;


  //  second constructor
  userData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    image = json["image"];
    points = json["points"];
    credit = json["credit"];
    token = json["token"];
  }
}
