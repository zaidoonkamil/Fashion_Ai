abstract class AppLoginStates {}

class AppLoginInitialState extends AppLoginStates {}

class ValidationState extends AppLoginStates {}

class AppRegisterLoadingState extends AppLoginStates {}
class AppRegisterSuccessState extends AppLoginStates {}
class AppRegisterErrorState extends AppLoginStates {
 final String error;

 AppRegisterErrorState(this.error);
}

class AppLoginLoadingState extends AppLoginStates {}
class AppLoginSuccessState extends AppLoginStates {}
class AppLoginErrorState extends AppLoginStates {
  final String error;

  AppLoginErrorState(this.error);
}
