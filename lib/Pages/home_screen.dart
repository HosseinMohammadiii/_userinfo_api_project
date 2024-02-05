import 'package:flutter/material.dart';
import 'package:flutter_api_project/Bloc/home_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../Bloc/home_event.dart';
import '../Bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomeRequest());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                if (state is LoadingHomeState) ...{
                  SliverPadding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    sliver: SliverList.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: const Color(0xffE1E1E1),
                          highlightColor: const Color(0xffF3F3F2),
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                                width: 90,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.blue,
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 265,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                },
                if (state is ResponseHomeState) ...{
                  state.users.fold(
                    (exeption) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Container(
                              height: 200,
                              width: 200,
                              color: Colors.amber,
                              child: Text(exeption)),
                        ),
                      );
                    },
                    (usersList) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: usersList.length,
                            (context, index) {
                              return Row(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 90,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    width: 273,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 40,
                                          spreadRadius: -40,
                                          offset: Offset(0, 20),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(usersList[index].name),
                                        Text(usersList[index].email),
                                        Text(usersList[index].city),
                                        Text(usersList[index].companyname),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                },
              ],
            ),
          );
        },
      ),
    );
  }
}
