import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.0.114:3000',
        receiveDataWhenStatusError: true,
      ),
    );

  }

  static Future<Response> postData({
    required String url,
    Object? data,
    String? token,
    Options? options,
  }) async
  {
    dio!.options.headers['Authorization'] =
    'Bearer ${token??''}';

    return dio!.post(
      url,
      data: data,
      options: options,
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async
  {
    dio!.options.headers['Authorization'] =
    'Bearer ${token??''}';

    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async
  {
    dio!.options.headers['Authorization'] =
    'Bearer ${token??''}';

    return dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String url,
    String? token,
  }) async
  {
    dio!.options.headers['Authorization'] =
    'Bearer ${token??''}';

    return dio!.delete(
      url,
    );
  }

}


