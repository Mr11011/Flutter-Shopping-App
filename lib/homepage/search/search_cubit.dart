import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/homepage/search/search_model.dart';
import 'package:shoppingapp/homepage/search/search_states.dart';
import 'package:shoppingapp/network/Diohelper.dart';
import 'package:shoppingapp/reusabaleComponents.dart';

import '../../network/end_points.dart';

class searchCubit extends Cubit<searchStates> {
  searchCubit() : super(searchInitialState());

  static searchCubit get(context) => BlocProvider.of(context);

  searchModel? sModel;

  void search(String text) {
    emit(searchLoadingState());
    dioHelper
        .postData(url: SEARCH, data: {"text": text}, token: token)
        .then((value) {
      sModel = searchModel.fromJson(value.data);
      emit(searchSuccessState());
    }).catchError((onError) {
      emit(searchFailState(onError));
      print(onError.toString());
    });
  }
}
