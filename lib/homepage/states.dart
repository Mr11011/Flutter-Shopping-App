import 'package:shoppingapp/login/login_model.dart';

abstract class homePageStates {}

class homePageInitState extends homePageStates {}

class homePageSuccessState extends homePageStates {}

class homePageFailState extends homePageStates {
  final dynamic error;

  homePageFailState(this.error);
}

class homePageLoadingState extends homePageStates {}

class naviagteBottom extends homePageStates {}

class categorySuccessState extends homePageStates {}

class categoryFailState extends homePageStates {
  final dynamic error;

  categoryFailState(this.error);
}

class favSuccessState extends homePageStates {}

class favFailState extends homePageStates {}

class fetch_CategoryInitState extends homePageStates {}

class fetch_CategorySuccessState extends homePageStates {}

class fetch_CategoryFailState extends homePageStates {
  final dynamic error;

  fetch_CategoryFailState(this.error);
}

class fetch_CategoryLoadingState extends homePageStates {}

class fetch_favLoadingState extends homePageStates {}

// user states
class userSuccessState extends homePageStates {
  final shopLoginModel usersModel;
  userSuccessState(this.usersModel);

}

class userFailState extends homePageStates {
  final dynamic error;

  userFailState(this.error);
}

class userLoadingState extends homePageStates {}
// user updating states
class userUpdateSuccessState extends homePageStates {
  final shopLoginModel usersModel;
  userUpdateSuccessState(this.usersModel);

}

class userUpdateFailState extends homePageStates {
  final dynamic error;

  userUpdateFailState(this.error);
}

class userUpdateLoadingState extends homePageStates {}
