import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/login/cubit/states.dart';
import 'package:shoppingapp/network/Diohelper.dart';
import 'package:shoppingapp/network/end_points.dart';

class loginCubit extends Cubit<loginStates> {
  loginCubit() : super(loginStatesInit());

  static loginCubit get(context) => BlocProvider.of(context);

  void userLogin({required email, required password}) async {
    emit(loginStatesLoading());

    dioHelper.postData(
        url: LOGIN, data: {"email": email, "password": password}).then((value) {
      emit(loginStatesSuccess());
      print(value.data);
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
}
