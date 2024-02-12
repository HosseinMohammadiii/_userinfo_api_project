import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_project/Models/avatar_users.dart';
import 'package:flutter_api_project/Models/users.dart';
import 'package:flutter_api_project/Widgets/about_user.dart';

class AccountPage extends StatefulWidget {
  AccountPage({
    super.key,
    required this.avatarUsers,
    required this.users,
  });

  // Getting The User Information From HomePage
  AvatarUsers avatarUsers;
  Users users;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with TickerProviderStateMixin {
//This Animation To Display User Information Container Box
  late final Animation<double> _sizeAnimation1 = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.1, 0.6, curve: Curves.linear),
  );

//This Animation To Display Image User
  late final Animation<double> _animationSize2 = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.5, 0.6, curve: Curves.linear),
  );

  //Controller For Control Animations
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..forward();

  //This Logical Is For Display AccountPage Or AboutUser Widget
  bool isTurn = false;

  //This Logical Is For Display Animations
  bool isAnimate = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 100),
                height: MediaQuery.sizeOf(context).height,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffb9dcf2),
                ),
              ),
              SizeTransition(
                sizeFactor: _sizeAnimation1,
                axisAlignment: 1,
                child: Container(
                  height: 500,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xffebf4f5),
                        Color(0xffb5c6e0),
                      ],
                      transform: GradientRotation(90),
                      tileMode: TileMode.mirror,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: isTurn == false
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            //Widget Text For Display Name And LastName User
                            Text(
                              widget.avatarUsers.firstname +
                                  widget.avatarUsers.lastname,
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff062828),
                              ),
                            ),

                            //Widget Row For Display Location Information User
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 13,
                                  child: Image.network(
                                      'https://s8.uupload.ir/files/maps-and-flags_15n1.png'),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  widget.users.city,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff062828),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),

                            //Widgets DelayedDisplay For Display User Informatio(Email,Phone Number,Website)
                            DelayedDisplay(
                              delay: isAnimate
                                  ? const Duration(seconds: 2)
                                  : Duration.zero,
                              fadingDuration: isAnimate
                                  ? const Duration(milliseconds: 800)
                                  : Duration.zero,
                              child: _boxShowInfoUser(
                                image:
                                    'https://s8.uupload.ir/files/email_0ttg_r9cf.png',
                                text: widget.avatarUsers.email,
                              ),
                            ),
                            DelayedDisplay(
                              delay: isAnimate
                                  ? const Duration(seconds: 3)
                                  : Duration.zero,
                              fadingDuration: isAnimate
                                  ? const Duration(milliseconds: 800)
                                  : Duration.zero,
                              child: _boxShowInfoUser(
                                image:
                                    'https://s8.uupload.ir/files/phone-call_1zmq_xzzl.png',
                                text: widget.users.phone,
                              ),
                            ),
                            DelayedDisplay(
                              delay: isAnimate
                                  ? const Duration(seconds: 4)
                                  : Duration.zero,
                              fadingDuration: isAnimate
                                  ? const Duration(milliseconds: 800)
                                  : Duration.zero,
                              child: _boxShowInfoUser(
                                image:
                                    'https://s8.uupload.ir/files/global_osni_xhi7.png',
                                text: widget.users.website,
                              ),
                            ),

                            //Widget DelayedDisplay For Display Button More User Information
                            DelayedDisplay(
                              delay: isAnimate
                                  ? const Duration(milliseconds: 4700)
                                  : Duration.zero,
                              fadingDuration: isAnimate
                                  ? const Duration(milliseconds: 800)
                                  : Duration.zero,
                              slidingBeginOffset: const Offset(0, -0.3),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (isTurn == true) {
                                          setState(() {
                                            isTurn = false;
                                          });
                                        } else {
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Container(
                                        width: 120,
                                        height: 40,
                                        margin: const EdgeInsets.only(
                                            top: 20, bottom: 60),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 23, 133, 133),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 14,
                                              child: Image.network(
                                                  'https://s8.uupload.ir/files/left-arrow_3vtq.png'),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            const Text(
                                              'Back',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isTurn = true;
                                        });
                                      },
                                      child: Container(
                                        width: 120,
                                        height: 40,
                                        margin: const EdgeInsets.only(
                                            top: 20, bottom: 60),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 23, 133, 133),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'More',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            SizedBox(
                                              height: 14,
                                              child: Image.network(
                                                  'https://s8.uupload.ir/files/right-arrow_(1)_b463.png'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : AboutUserWidget(
                          avatarUsers: widget.avatarUsers,
                          users: widget.users,
                          onChange: () {
                            setState(() {
                              isTurn = false;
                              isAnimate = false;
                            });
                          },
                        ),
                ),
              ),

              //Widget Positioned For Display Image User
              Positioned(
                bottom: 420,
                child: SizeTransition(
                  sizeFactor: _animationSize2,
                  axisAlignment: 1,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 6,
                      ),
                      borderRadius: BorderRadius.circular(80),
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.avatarUsers.avatar,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//Widget Container For Create User Information Box(Email,Phone Number,Website)
  Container _boxShowInfoUser({required String image, required String text}) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 23, 133, 133),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 25,
            child: Image.network(image),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xff062828),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
