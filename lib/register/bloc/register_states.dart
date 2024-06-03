import 'package:shoppingapp/login/login_model.dart';

abstract class registerStates {}

class registerStatesLoading extends registerStates {}

class registerStatesInit extends registerStates {}

class registerStatesSuccess extends registerStates {
  final shopLoginModel? loginModel;

  registerStatesSuccess(this.loginModel);
}

class RegisterchangeV extends registerStates {}

class RegisternavigateToState extends registerStates {}

class RegisternavigateFinishState extends registerStates {}

class registerStatesError extends registerStates {
  final String error;

  registerStatesError(this.error);
}
