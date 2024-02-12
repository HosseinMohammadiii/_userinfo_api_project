import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_api_project/Models/avatar_users.dart';
import 'package:flutter_api_project/Models/users.dart';
import 'package:flutter_api_project/Util/api_exeption.dart';
import 'package:flutter_api_project/Util/dio_provider.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.asNewInstance();

Future<void> getItUserInit() async {
  locator.registerSingleton<Dio>(DioProviderUsers.createDioInfo(),
      instanceName: "first");
  locator.registerFactory<userDataSource>(() => DioProviderUsersInfo(),
      instanceName: "first");
  locator.registerSingleton<Dio>(DioProviderAvatars.createDioAvatar(),
      instanceName: "two");
  locator.registerFactory<userAvatarDataSource>(() => DioProviderAvatarsInfo(),
      instanceName: "two");
}

abstract class userDataSource {
  Future<Either<String, List<Users>>> getUsers();
}

abstract class userAvatarDataSource {
  Future<Either<String, List<AvatarUsers>>> getAvatarUsersPageOne();
  Future<Either<String, List<AvatarUsers>>> getAvatarUsersPageTwo();
}

class DioProviderUsersInfo extends userDataSource {
  @override
  Future<Either<String, List<Users>>> getUsers() async {
    final Dio dio = locator.get(instanceName: "first");

    try {
      var resposne = await dio.get('users');

      List<dynamic> json = resposne.data;
      List<Users> usersList = json.map((e) => Users.fromMapJson(e)).toList();
      return Right(usersList);
    } on DioException catch (e) {
      throw ApiExeption(e.hashCode, e.message);
    } catch (ex) {
      throw left(ApiExeption(0, 'unknown error'));
    }
  }
}

class DioProviderAvatarsInfo extends userAvatarDataSource {
  final Dio dio = locator.get(instanceName: "two");
  @override
  Future<Either<String, List<AvatarUsers>>> getAvatarUsersPageOne() async {
    try {
      Map<String, int> qParams = {'page': 1};
      var resposne = await dio.get(
        'users',
        queryParameters: qParams,
      );

      List<dynamic> json = resposne.data['data'];
      List<AvatarUsers> avatarList =
          json.map((e) => AvatarUsers.fromMapJson(e)).toList();
      return Right(avatarList);
    } on DioExceptionType {
      throw ApiExeption(DioExceptionType.connectionError.index,
          DioExceptionType.connectionError.name);
    } catch (ex) {
      throw left(ApiExeption(0, 'unknown error'));
    }
  }

  @override
  Future<Either<String, List<AvatarUsers>>> getAvatarUsersPageTwo() async {
    try {
      Map<String, int> qParams = {'page': 2};
      var resposne = await dio.get(
        'users',
        queryParameters: qParams,
      );

      List<dynamic> json = resposne.data['data'];
      List<AvatarUsers> avatarList =
          json.map((e) => AvatarUsers.fromMapJson(e)).toList();
      return Right(avatarList);
    } on DioExceptionType {
      throw ApiExeption(DioExceptionType.connectionError.index,
          DioExceptionType.connectionError.name);
    } catch (ex) {
      throw left(ApiExeption(0, 'unknown error'));
    }
  }
}
