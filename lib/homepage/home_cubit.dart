import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/homepage/categories/categoriesModel.dart';
import 'package:shoppingapp/homepage/categories/categories_screen.dart';
import 'package:shoppingapp/homepage/favourites/favorites_model.dart';
import 'package:shoppingapp/homepage/favourites/favourites_screen.dart';
import 'package:shoppingapp/homepage/home_model.dart';
import 'package:shoppingapp/homepage/products/products_screen.dart';
import 'package:shoppingapp/homepage/settings/settings_screen.dart';
import 'package:shoppingapp/homepage/states.dart';
import 'package:shoppingapp/login/cubit/login_cubit.dart';
import 'package:shoppingapp/login/login_model.dart';
import 'package:shoppingapp/network/Diohelper.dart';
import 'package:shoppingapp/network/cache_helper.dart';
import 'package:shoppingapp/network/end_points.dart';
import 'package:shoppingapp/reusabaleComponents.dart';

class homeCubit extends Cubit<homePageStates> {
  homeCubit() : super(homePageInitState());
  String english = 'en';
  String arabic = 'ar';

  static homeCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> homeScreen = [
    productScreen(),
    categoriesScreen(),
    favScreen(),
    settingsScreen()
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(naviagteBottom());
  }

  homeModel? home_model;
  allcategoriesModel? allCategory;

  Map<int, dynamic> favoritesMap = {};

  // to fetch the whole data from the API
  void fetchProducts() async {
    emit(homePageLoadingState());
    // NO QUERY WHILE I DO GET , and that's why I have null query parameter
    dioHelper.getData(url: HOME_PRODUCTS, token: token).then((value) {
      home_model = homeModel.fromJson(value.data);

      home_model!.data!.products.forEach((element) {
        favoritesMap.addAll({element.id!: element.in_fav!});
      });

      emit(homePageSuccessState());
    }).catchError((onError) {
      emit(homePageFailState(onError));
      print(onError.toString());
    });
  }

  allcategoriesModel? categoryData;

  void fetchCategory() {
    emit(homePageLoadingState());
    dioHelper.getData(url: GET_CATEGORY).then((value) {
      categoryData = allcategoriesModel.fromJson(value.data);
      emit(categorySuccessState());
    }).catchError((onError) {
      emit(categoryFailState(onError));
      print(onError.toString());
    });
  }

  favoritesModel? favModel;

  void fetch_Fav() {
    emit(fetch_favLoadingState());
    dioHelper.getData(url: FAVORITES, token: token).then((value) {
      favModel = favoritesModel.fromJson(value.data);
      emit(fetch_CategorySuccessState());
    }).catchError((onError) {
      emit(fetch_CategoryFailState(onError));
      print(onError.toString());
    });
  }

  // function that will get the values of fav products
  void changeFavs(int? productID) {
    favoritesMap[productID!] = !favoritesMap[productID]!;
    emit(favSuccessState());
    // print(favoritesMap[productID]);

    dioHelper
        .postData(url: FAVORITES, data: {'product_id': productID}, token: token)
        .then((value) {
      favModel = favoritesModel.fromJson(value.data);
      if (favModel?.status == false) {
        emit(favSuccessState());
        favoritesMap[productID] != !favoritesMap[productID]!;
      } else {
        fetch_Fav();
      }

      print(favModel!.message);
      print(favModel!.status);
      emit(favSuccessState());
    }).catchError((onError) {
      favoritesMap[productID] != !favoritesMap[productID]!;
      print(onError.toString());
      emit(favFailState());
    });
  }

  shopLoginModel? userModel;

  void getUserData() {
    emit(userLoadingState());
    dioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = shopLoginModel.fromJson(value.data);
      emit(userSuccessState(userModel!));
      print(userModel?.data?.phone);
    }).catchError((onError) {
      emit(userFailState(onError));
      print(onError.toString());
    });
  }

  void updateUserData({required name, required email, required phone}) {
    emit(userLoadingState());
    dioHelper.putData(
        url: UPDATE,
        token: token,
        data: {"name": name, "email": email, "phone": phone}).then((value) {
      userModel = shopLoginModel.fromJson(value.data);
      emit(userSuccessState(userModel!));
      print(userModel?.data?.phone);
    }).catchError((onError) {
      emit(userFailState(onError));
      print(onError.toString());
    });
  }
}
