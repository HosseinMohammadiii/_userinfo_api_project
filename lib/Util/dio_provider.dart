import 'package:dio/dio.dart';

class DioProvider {
  static Dio createDio() {
    Dio dio =
        Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com/'));
    return dio;
  }
}
