
abstract class DetailsStates {}

class DetailsInitialState extends DetailsStates {}

class ValidationState extends DetailsStates {}

class DetailsProductsLoadingState extends DetailsStates {}
class DetailsProductsSuccessState extends DetailsStates {}
class DetailsProductsErrorState extends DetailsStates {
 final String error;

 DetailsProductsErrorState(this.error);
}

class HomeProductsLoadingState extends DetailsStates {}
class HomeProductsSuccessState extends DetailsStates {}
class HomeProductsErrorState extends DetailsStates {
 final String error;

 HomeProductsErrorState(this.error);
}

class AddToCartLoadingState extends DetailsStates {}
class AddToCartSuccessState extends DetailsStates {}
class AddToCartErrorState extends DetailsStates {
 final String error;

 AddToCartErrorState(this.error);
}

