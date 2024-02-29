import 'package:dio/dio.dart';
import 'package:fashion/core/widgets/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/remote/dio_helper.dart';
import '../../../core/remote/end_points.dart';
import '../../home/model/get_home_products.dart';
import '../model/GetOrderAdmin.dart';
import '../model/GetProfileProducts.dart';
import '../model/ProfileModel.dart';
import 'states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  bool changeing=false;
  void changeButoom(){
    changeing=!changeing;
    emit(ChangeButoomState());
}

  ProfileModel? profileModel;

  void getDataProfile() {
    emit(ProfileDataLoadingState());
    DioHelper.getData(
      url: GETPROFILEDATA,
      token: token
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      emit(ProfileDataSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        emit(ProfileDataErrorState(error.message!));
      }
    });
  }

  GetProfileProducts? getProfileProducts;

  void getDataGridProfile() {
    emit(ProfileGridDataLoadingState());
    DioHelper.getData(
        url: GETPROFILEDATAGRID,
        token: token
    ).then((value) {
      getProfileProducts = GetProfileProducts.fromJson(value.data);
      emit(ProfileGridDataSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        emit(ProfileGridDataErrorState(error.message!));
      }
    });
  }

  GetOrderAdmin? getOrderAdmin;

  void getDataOrderAdmin() {
    emit(ProfileOrderDataLoadingState());
    DioHelper.getData(
        url: GETPROFILEORDERADMIN,
        token: token
    ).then((value) {
      getOrderAdmin = GetOrderAdmin.fromJson(value.data);
      emit(ProfileOrderDataSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        emit(ProfileOrderDataErrorState(error.message!));
      }
    });
  }

}
