abstract class loginStates {}

class loginStatesLoading extends loginStates {}

class loginStatesInit extends loginStates {}
class loginStatesSuccess extends loginStates {}
class changeV extends loginStates {}

class loginStatesError extends loginStates {
  final String error;

  loginStatesError(this.error);
}
