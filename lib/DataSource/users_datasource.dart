import 'package:dio/dio.dart';
import 'package:flutter_api_project/model/users.dart';

class DioProvider {
  Future<List<Users>?> getUsers() async {
    var dio = Dio();
    var resposne = await dio.get('https://jsonplaceholder.typicode.com/users');
    try {
      if (resposne.statusCode == 200) {
        List<dynamic> json = resposne.data;
        List<Users> usersList = json.map((e) => Users.fromMapJson(e)).toList();
        return usersList;
      }
    } catch (e) {
      print('Error:$e');
    }
    return null;
  }
}
