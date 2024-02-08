import 'package:flutter/material.dart';
import 'package:flutter_api_project/Bloc/home_bloc.dart';
import 'package:flutter_api_project/Models/avatar_users.dart';

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
                      return exeptionMessage(exeption);
                    },
                    (usersList) {
                      return state.avatarUsersPageOne.fold(
                        (exeption) {
                          return exeptionMessage(exeption);
                        },
                        (avatarUser) {
                          return state.avatarUsersPageTwo.fold((exeption) {
                            return exeptionMessage(exeption);
                          }, (avatarUserTwo) {
                            List<AvatarUsers> avatar =
                                avatarUser + avatarUserTwo;
                            return SliverPadding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  childCount: avatar.length - 2,
                                  (context, index) {
                                    return Row(
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 90,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 5),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                              avatar[index].avatar,
                                              fit: BoxFit.cover,
                                            ),
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
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                                              Text(avatar[index].firstname),
                                              Text(usersList[index].email),
                                              Text(usersList[index].city),
                                              Text(
                                                  usersList[index].companyname),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            );
                          });
                        },
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

//Widget For Display Exeption Message
  SliverToBoxAdapter exeptionMessage(String exeption) {
    return SliverToBoxAdapter(
      child: Center(
        child: Text('The Exeption Message:$exeption'),
      ),
    );
  }
}
