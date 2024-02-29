import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/local_save_storege/cache_helper.dart';
import '../../../core/remote/dio_helper.dart';
import '../../../core/remote/end_points.dart';
import '../../../core/widgets/constant.dart';
import '../../home/model/get_home_products.dart';
import '../model/details_products.dart';
import 'states.dart';

class DetailsCubit extends Cubit<DetailsStates> {
  DetailsCubit() : super(DetailsInitialState());

  static DetailsCubit get(context) => BlocProvider.of(context);

  void validation(){
    emit(ValidationState());
  }

  DetailsProducts? detailsProducts;

  void getDetailsProducts({
    required String page,
  }) {
    emit(DetailsProductsLoadingState());
    DioHelper.getData(
      url: DitalsPRODUCTS+page,
    ).then((value) {
      detailsProducts = DetailsProducts.fromJson(value.data);
      emit(DetailsProductsSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        emit(DetailsProductsErrorState(error.message!));
      }
    });
  }

  GetHomeProducts? getClassProductsModel;

  void getClassProducts({
    required String page,
  }) {
    emit(HomeProductsLoadingState());
    DioHelper.getData(
      url: GETCLASSPRODUCTS+page,
    ).then((value) {
      getClassProductsModel = GetHomeProducts.fromJson(value.data);
      emit(HomeProductsSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        emit(HomeProductsErrorState(error.message!));
      }
    });
  }

  void addToCart({
    required String productId,
    required String shopId,
    required String size,
    required String color,
  }) {
    emit(AddToCartLoadingState());
    DioHelper.postData(
      data: {
        'product':productId,
        'shop':shopId,
        'user':id,
        'size':size,
        'color':color,
      },
      url: ADDTOCART,
      token: token
    ).then((value) {
      emit(AddToCartSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        emit(AddToCartErrorState(error.message!));
      }
    });
  }

}
