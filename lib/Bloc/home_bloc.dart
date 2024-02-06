import 'package:flutter_api_project/Bloc/home_event.dart';
import 'package:flutter_api_project/Bloc/home_state.dart';
import 'package:flutter_api_project/Data/users_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final userDataSource _user = locator.get(instanceName: "first");
  final userAvatarDataSource _userAvatar = locator.get(instanceName: "two");
  HomeBloc() : super(InitationHomeState()) {
    on<HomeRequest>(
      (event, emit) async {
        emit(LoadingHomeState());
        var user = await _user.getUsers();
        var avatarPageOne = await _userAvatar.getAvatarUsersPageOne();
        var avatarPageTwo = await _userAvatar.getAvatarUsersPageTwo();
        emit(
          ResponseHomeState(
            user,
            avatarPageOne,
            avatarPageTwo,
          ),
        );
      },
    );
  }
}
