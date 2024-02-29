
abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchProductsLoadingState extends SearchStates {}
class SearchProductsSuccessState extends SearchStates {}
class SearchProductsErrorState extends SearchStates {
 final String error;

 SearchProductsErrorState(this.error);
}

