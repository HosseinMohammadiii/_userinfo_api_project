import '../Models/users.dart';
import 'package:dartz/dartz.dart';

abstract class HomeState {}

class InitationHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class ResponseHomeState extends HomeState {
  ResponseHomeState(
    this.users,
  );
  Either<String, List<Users>> users;
}
