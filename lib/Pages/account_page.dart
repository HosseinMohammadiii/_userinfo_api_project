import 'package:flutter/material.dart';
import 'package:flutter_api_project/Models/avatar_users.dart';
import 'package:flutter_api_project/Models/users.dart';

class AccountPage extends StatefulWidget {
  AccountPage({
    super.key,
    // required this.avatarUsers,
    // required this.users,
  });
  // AvatarUsers avatarUsers;
  // Users users;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.0, 0.2, curve: Curves.linear),
  );
  late final Animation<double> _animationSize = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.1, 0.6, curve: Curves.linear),
  );
  late final Animation<double> _animationSize2 = CurvedAnimation(
    parent: AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward(),
    curve: const Interval(0.5, 0.6, curve: Curves.linear),
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();
  }

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
                sizeFactor: _animationSize,
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('sssssss'),
                      Text('sssssss'),
                      Text('sssssss'),
                      Text('sssssss'),
                    ],
                  ),
                ),
              ),
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
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://reqres.in/img/faces/1-image.jpg',
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
