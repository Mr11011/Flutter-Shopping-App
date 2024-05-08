import 'package:shoppingapp/login/login_model.dart';

abstract class loginStates {}

class loginStatesLoading extends loginStates {}

class loginStatesInit extends loginStates {}

class loginStatesSuccess extends loginStates {
  final shopLoginModel? loginModel;

  loginStatesSuccess(this.loginModel);
}

class homePageState extends loginStates {}

class changeV extends loginStates {}

class navigateToState extends loginStates {}

class navigateFinishState extends loginStates {}

class loginStatesError extends loginStates {
  final String error;

  loginStatesError(this.error);
}
