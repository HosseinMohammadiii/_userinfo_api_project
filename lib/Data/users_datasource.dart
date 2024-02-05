import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_api_project/Models/users.dart';
import 'package:flutter_api_project/Util/api_exeption.dart';
import 'package:flutter_api_project/Util/dio_provider.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.instance;

Future<void> getItInit() async {
  locator.registerSingleton<Dio>(DioProvider.createDio());
  locator.registerFactory<userDataSource>(() => DioProviderUsers());
}

abstract class userDataSource {
  Future<Either<String, List<Users>>> getUsers();
}

class DioProviderUsers extends userDataSource {
  @override
  Future<Either<String, List<Users>>> getUsers() async {
    final Dio dio = locator.get();
    try {
      var resposne = await dio.get('users');

      List<dynamic> json = resposne.data;
      List<Users> usersList = json.map((e) => Users.fromMapJson(e)).toList();
      return Right(usersList);
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw left(ApiExeption(0, 'unknown error'));
    }
  }
}
