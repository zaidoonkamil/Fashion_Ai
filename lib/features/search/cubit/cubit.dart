import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/remote/dio_helper.dart';
import '../../../core/remote/end_points.dart';
import '../model/get_search_products.dart';
import 'states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  GetSearchProducts? getSearchProducts;

  void getSearchProduct({
   required String searchText,
  }) {
    emit(SearchProductsLoadingState());
    DioHelper.getData(
      url: GETSEARCHPRODUCTS+searchText,
    ).then((value) {
      getSearchProducts = GetSearchProducts.fromJson(value.data);
      emit(SearchProductsSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        emit(SearchProductsErrorState(error.message!));
      }
    });
  }

}
