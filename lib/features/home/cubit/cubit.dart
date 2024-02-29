import 'package:dio/dio.dart';
import 'package:fashion/core/widgets/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/remote/dio_helper.dart';
import '../../../core/remote/end_points.dart';
import '../../profile/model/ProfileModel.dart';
import '../model/GetOrder.dart';
import '../model/get_home_products.dart';
import 'states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  bool ready=false;
  List<XFile>? selectedImages;

  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> resultList = await picker.pickMultiImage();
    if (resultList.isNotEmpty) {
      selectedImages = resultList;
      ready=true;
      emit(ShowImageState());
    }
  }


  void addJewelleries({
    required List<XFile> files,
    required List<XFile> filesCover,
  })async
  {
    emit(SabikaAddJewelleriesLoadingStates());
    FormData formData = FormData.fromMap(
        {
          'name': 'zaidoon',
          'price': 22,
          'description': 'sdasdsad',
          'userid': id,
          'colors': '#222222',
        },
        ListFormat.multiCompatible
    );
    for (var file in files){
      formData.files.addAll([MapEntry("images[]", await MultipartFile.fromFile(file.path, filename: file.name))]);
    }
    for (var file in filesCover){
      formData.files.addAll([MapEntry("imageCover[]", await MultipartFile.fromFile(file.path, filename: file.name))]);
    }
    DioHelper.postData(
      url: UPLOADPROUDUCTS,
      token: token,
      data:formData,
    ).then((value)
    {
      emit(SabikaAddJewelleriesSuccessStates());
    }).catchError((error)
    {
      if (error is DioError) {
        print(error.message);
        emit(SabikaAddJewelleriesErrorStates(error.message!));
      }
    });
  }




  void validation(){
    emit(ValidationState());
  }

  GetHomeProducts? getHomeProducts;

  void getHomeUserProducts({
    required String page,
  }) {
    emit(HomeProductsLoadingState());
    DioHelper.getData(
      url: GETHOMEPRODUCTS,//+page,
    ).then((value) {
      getHomeProducts = GetHomeProducts.fromJson(value.data);
      emit(HomeProductsSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        emit(HomeProductsErrorState(error.message!));
      }
    });
  }

  GetOrder? getOrder;

  void getUserOrder() {
    emit(GetUserOrderLoadingState());
    DioHelper.getData(
      url: GETUSERORDER,
      token: token
    ).then((value) {
      getOrder = GetOrder.fromJson(value.data);
      emit(GetUserOrderSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        emit(GetUserOrderErrorState(error.message!));
      }
    });
  }

  ProfileModel? profileModell;

  void getDataProfile() {
    emit(ProfileDataLoadingState());
    DioHelper.getData(
        url: GETPROFILEDATA,
        token: token
    ).then((value) {
      profileModell = ProfileModel.fromJson(value.data);
      emit(ProfileDataSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        emit(ProfileDataErrorState(error.message!));
      }
    });
  }

  void deleteUserOrder({
    required String id,
}) {
    emit(DeleteUserOrderLoadingState());
    DioHelper.deleteData(
      url: "$GETUSERORDER/$id",
      token: token
    ).then((value) {
      emit(DeleteUserOrderSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        emit(DeleteUserOrderErrorState(error.message!));
      }
    });
  }

}
