import 'package:dio/dio.dart';
import 'package:fashion/core/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/remote/end_points.dart';
import 'states.dart';

class AppLoginCubit extends Cubit<AppLoginStates> {
  AppLoginCubit() : super(AppLoginInitialState());

  static AppLoginCubit get(context) => BlocProvider.of(context);

  void validation(){
    emit(ValidationState());
  }

  signUp({
    required String name,
    required String email,
    required String password,
    required String Cpassword,
}){
    emit(AppRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
      data:
      {
        'name': name,
        'email': email,
        'password': password,
        'passwordConfirm': Cpassword,
      },
    ).then((value) {
      emit(AppRegisterSuccessState());
    }).catchError((error)
    {
      if (error is DioError) {
          emit(AppRegisterErrorState(error.message!));
      }
    });
  }

  String? token;
  String? role;
  String? id;

  signIn({
    required String email,
    required String password,
  }){
    emit(AppLoginLoadingState());
    DioHelper.postData(
        url: SIGNIN,
      data:
      {
        'email': email,
        'password': password,
      },
    ).then((value) {
      token=value.data['token'];
      role=value.data['data']['user']['role'];
      id=value.data['data']['user']['_id'];
      emit(AppLoginSuccessState());
    }).catchError((error)
    {
      if (error is DioError) {
          emit(AppLoginErrorState(error.message!));
      }
    });
  }

}
