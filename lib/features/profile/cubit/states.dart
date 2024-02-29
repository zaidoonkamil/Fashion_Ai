
abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ChangeButoomState extends ProfileStates {}

class ProfileDataLoadingState extends ProfileStates {}
class ProfileDataSuccessState extends ProfileStates {}
class ProfileDataErrorState extends ProfileStates {
 final String error;

 ProfileDataErrorState(this.error);
}

class ProfileGridDataLoadingState extends ProfileStates {}
class ProfileGridDataSuccessState extends ProfileStates {}
class ProfileGridDataErrorState extends ProfileStates {
 final String error;

 ProfileGridDataErrorState(this.error);
}

class ProfileOrderDataLoadingState extends ProfileStates {}
class ProfileOrderDataSuccessState extends ProfileStates {}
class ProfileOrderDataErrorState extends ProfileStates {
 final String error;

 ProfileOrderDataErrorState(this.error);
}

