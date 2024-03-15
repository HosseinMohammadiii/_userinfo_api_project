import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_api_project/Bloc/home_bloc.dart';
import 'package:flutter_api_project/Models/avatar_users.dart';
import 'package:flutter_api_project/Pages/account_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../Bloc/home_event.dart';
import '../Bloc/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // Running The HomeRequest Event To Receive Data From The Server
    BlocProvider.of<HomeBloc>(context).add(HomeRequest());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4e6f1),
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: AppBar(
          backgroundColor: const Color(0xfff4e6f1),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                //State ErrorHomeState When No User Connection Internet
                if (state is ErrorHomeState) ...{
                  SliverFillRemaining(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          state.errorMessage,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              BlocProvider.of<HomeBloc>(context)
                                  .add(HomeRequest());
                            });
                          },
                          child: const Text(
                            'Retry',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                },

                //State LoadingHomeState To Waiting Receive Informatio From The Server
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

                //State ResponseHomeState To Receive Response From The Server
                if (state is ResponseHomeState) ...{
                  //Using User State Fold Widget Function To Troubleshooting And Receiving Information
                  state.users.fold(
                    (exeption) {
                      return exeptionMessage(exeption);
                    },
                    (usersList) {
                      //Using avatarUsersPageOne State Fold Widget Function To Troubleshooting And Receiving Information
                      return state.avatarUsersPageOne.fold(
                        (exeption) {
                          return exeptionMessage(exeption);
                        },
                        (avatarUser) {
                          //Using avatarUsersPageTwo State Fold Widget Function To Troubleshooting And Receiving Information
                          return state.avatarUsersPageTwo.fold(
                            (exeption) {
                              return exeptionMessage(exeption);
                            },
                            (avatarUserTwo) {
                              //Merging Two Lists At One List
                              List<AvatarUsers> avatar =
                                  avatarUser + avatarUserTwo;

                              return SliverPadding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                sliver: SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    childCount: avatar.length - 2,
                                    (context, index) {
                                      //Button To Go To The AccountPage And Send Information User
                                      return GestureDetector(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AccountPage(
                                              avatarUsers: avatar[index],
                                              users: usersList[index],
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 90,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 5),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(
                                                  avatar[index].avatar,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 100,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 5),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color:
                                                      const Color(0xffb5c6e0),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    //Display User First Name And Last Name
                                                    Expanded(
                                                      child: Text(
                                                          'Name: ${avatar[index].firstname + avatar[index].lastname}'),
                                                    ),
                                                    //Display User City Name
                                                    Expanded(
                                                      child: Text(
                                                          'City: ${usersList[index].city}'),
                                                    ),
                                                    //Display User Email Address
                                                    Expanded(
                                                      child: Text(
                                                          'Email: ${avatar[index].email}'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          );
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
