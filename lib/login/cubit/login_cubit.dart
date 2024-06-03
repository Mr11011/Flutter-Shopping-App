import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/homepage/home_page.dart';
import 'package:shoppingapp/login/cubit/states.dart';
import 'package:shoppingapp/login/login_model.dart';
import 'package:shoppingapp/network/Diohelper.dart';
import 'package:shoppingapp/network/end_points.dart';
import 'package:shoppingapp/onBoardingScreen.dart';

class loginCubit extends Cubit<loginStates> {
  loginCubit() : super(loginStatesInit());

  static loginCubit get(context) => BlocProvider.of(context);

  late shopLoginModel loginModel;

  void userLogin({required email, required password}) async {
    emit(loginStatesLoading());

    dioHelper.postData(
        url: LOGIN, data: {"email": email, "password": password}).then((value) {
      loginModel = shopLoginModel.fromJson(value.data);
      // print(loginModel.message);
      // print(loginModel.status);

      emit(loginStatesSuccess(loginModel));
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  IconData suffixIcon = Icons.visibility;
  bool visibleFlag = true;

  void changeVisibility() {
    suffixIcon = Icons.visibility_off;
    visibleFlag = !visibleFlag;

    suffixIcon = visibleFlag ? Icons.visibility : Icons.visibility_off;
    emit(changeV());
  }

  void navigateFinish(context, widget) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);
    emit(navigateFinishState());
  }

  void navigateTo(context, widget) {
    emit(navigateToState());
  }
}
