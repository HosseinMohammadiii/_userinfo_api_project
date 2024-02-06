import 'package:dio/dio.dart';

class DioProviderUsers {
  static Dio createDioInfo() {
    Dio dio = Dio(BaseOptions(baseUrl: 'https://reqres.in/api'));
    return dio;
  }
}

class DioProviderAvatars {
  static Dio createDioAvatar() {
    Dio dio = Dio(BaseOptions(baseUrl: 'https://reqres.in/api/'));
    return dio;
  }
}
