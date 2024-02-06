import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_api_project/Models/avatar_users.dart';
import 'package:flutter_api_project/Models/users.dart';
import 'package:flutter_api_project/Util/api_exeption.dart';
import 'package:flutter_api_project/Util/dio_provider.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.instance;

Future<void> getItInit() async {
  locator.registerSingleton<Dio>(DioProviderUsers.createDioInfo());
  locator.registerFactory<userDataSource>(() => DioProviderUsersInfo());
  locator.registerSingleton<Dio>(DioProviderAvatars.createDioAvatar());
  locator.registerFactory<userAvatarDataSource>(() => DioProviderAvatarsInfo());
}

abstract class userDataSource {
  Future<Either<String, List<Users>>> getUsers();
}

abstract class userAvatarDataSource {
  Future<Either<String, List<AvatarUsers>>> getAvatarUsers();
}

class DioProviderUsersInfo extends userDataSource {
  @override
  Future<Either<String, List<Users>>> getUsers() async {
    final Dio dio = locator.get();
    try {
      var resposne = await dio.get('users');

      List<dynamic> json = resposne.data;
      List<Users> usersList = json.map((e) => Users.fromMapJson(e)).toList();
      return Right(usersList);
    } on DioExceptionType {
      throw ApiExeption(DioExceptionType.connectionError.index, DioExceptionType.connectionError.name);
    } catch (ex) {
      throw left(ApiExeption(0, 'unknown error'));
    }
  }
}

class DioProviderAvatarsInfo extends userAvatarDataSource {
  @override
  Future<Either<String, List<AvatarUsers>>> getAvatarUsers() async {
    final Dio dio = locator.get();
    try {
      var resposne = await dio.get('users');

      List<dynamic> json = resposne.data;
      List<AvatarUsers> avatarList =
          json.map((e) => AvatarUsers.fromMapJson(e)).toList();
      return Right(avatarList);
    } on DioExceptionType {
      throw ApiExeption(DioExceptionType.connectionError.index, DioExceptionType.connectionError.name);
    } catch (ex) {
      throw left(ApiExeption(0, 'unknown error'));
    }
  }
}
