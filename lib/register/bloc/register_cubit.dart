import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/login/login_model.dart';
import 'package:shoppingapp/network/Diohelper.dart';
import 'package:shoppingapp/register/bloc/register_states.dart';

import '../../network/end_points.dart';

class registerCubit extends Cubit<registerStates> {
  registerCubit() : super(registerStatesInit());

  static registerCubit get(context) => BlocProvider.of(context);

  late shopLoginModel loginModel;

  void userRegister({
    required name,
    required email,
    required phone,
    required password,
  }) async {
    emit(registerStatesLoading());

    dioHelper.postData(
        url: REGISTER,
        data: { "name": name,"email": email,"phone": phone,"password": password}).then((value) {
      loginModel = shopLoginModel.fromJson(value.data);
      print(loginModel.message);
      print(loginModel.status);

      emit(registerStatesSuccess(loginModel));
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
    emit(RegisterchangeV());
  }

  void navigateFinish(context, widget) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);
    emit(RegisternavigateFinishState());
  }

  void navigateTo(context, widget) {
    emit(RegisternavigateToState());
  }
}
