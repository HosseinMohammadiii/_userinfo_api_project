import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_project/DataSource/users_datasource.dart';
import 'package:flutter_api_project/model/users.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Users>? users;
  var isLoaded = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    users = await DioProvider().getUsers();
    if (users != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                // var response = DioProvider().getUsers();
                // print(response);
              },
              child: Container(
                width: 100,
                height: 50,
                color: Colors.amber,
                child: Text('Print Data'),
              ),
            ),
            Visibility(
              visible: isLoaded,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: users?.length,
                  itemBuilder: (context, index) {
                    return Text('${users![index].name}');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
