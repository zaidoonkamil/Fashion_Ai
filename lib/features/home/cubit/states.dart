
abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class ValidationState extends HomeStates {}

class HomeProductsLoadingState extends HomeStates {}
class HomeProductsSuccessState extends HomeStates {}
class HomeProductsErrorState extends HomeStates {
 final String error;

 HomeProductsErrorState(this.error);
}

class GetUserOrderLoadingState extends HomeStates {}
class GetUserOrderSuccessState extends HomeStates {}
class GetUserOrderErrorState extends HomeStates {
 final String error;

 GetUserOrderErrorState(this.error);
}

class DeleteUserOrderLoadingState extends HomeStates {}
class DeleteUserOrderSuccessState extends HomeStates {}
class DeleteUserOrderErrorState extends HomeStates {
 final String error;

 DeleteUserOrderErrorState(this.error);
}

class ProfileDataLoadingState extends HomeStates {}
class ProfileDataSuccessState extends HomeStates {}
class ProfileDataErrorState extends HomeStates {
 final String error;

 ProfileDataErrorState(this.error);
}




class ShowImageState extends HomeStates {}
class SabikaAddJewelleriesLoadingStates extends HomeStates {}
class SabikaAddJewelleriesSuccessStates extends HomeStates {}
class SabikaAddJewelleriesErrorStates extends HomeStates {
 final String error;

 SabikaAddJewelleriesErrorStates(this.error);
}