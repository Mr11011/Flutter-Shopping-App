class allcategoriesModel {
  bool? status;
  categoriesDataModel? data;

  allcategoriesModel.fromJson(Map<String, dynamic> allCategory) {
    status = allCategory["status"];
    data = categoriesDataModel.fromJson(allCategory["data"]);
  }
}

class categoriesDataModel {
  int? current_page;
  List<dataOfCategory> data = [];

  categoriesDataModel.fromJson(Map<String, dynamic> categoriesData) {
    current_page = categoriesData["current_page"];
    categoriesData["data"].forEach((element) {
      data.add(dataOfCategory.fromJson(element));
    });
  }
}

class dataOfCategory {
  int? id;
  String? name;
  String? image;

  dataOfCategory.fromJson(Map<String, dynamic> data) {
    id = data["id"];
    name = data["name"];
    image = data["image"];
  }
}
