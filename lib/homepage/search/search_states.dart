abstract class searchStates {}

class searchInitialState extends searchStates {}
class searchLoadingState extends searchStates {}

class searchSuccessState extends searchStates {}

class searchFailState extends searchStates {
  final dynamic error;

  searchFailState(this.error);
}
