import 'package:flutter/material.dart';
import 'package:flutter_api_project/Models/avatar_users.dart';
import 'package:flutter_api_project/Models/users.dart';
import 'package:typewritertext/typewritertext.dart';

class AboutUserWidget extends StatelessWidget {
  AboutUserWidget({
    super.key,
    required this.avatarUsers,
    required this.users,
    required this.onChange,
  });

  // Getting The User Information From HomePage
  AvatarUsers avatarUsers;
  Users users;

//Changes The Function to Use Another Page
  Function() onChange;

  @override
  Widget build(BuildContext context) {
//Text Method To Display User Descriptive Information
    Text aboutUser(
      AvatarUsers avatarUsers,
      Users users,
    ) {
      Text about = Text(
        'Hi My name is ${avatarUsers.firstname + avatarUsers.lastname}.I living ${users.city} city.I am the owner of a company called ${users.companyname}.',
        textAlign: TextAlign.justify,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
      );
      return about;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Text Animation
          TypeWriterText(
            text: aboutUser(avatarUsers, users),
            duration: const Duration(milliseconds: 50),
          ),
          GestureDetector(
            //Use Function onChange
            onTap: () => onChange(),
            child: Container(
              width: 120,
              height: 40,
              margin: const EdgeInsets.only(top: 30, bottom: 60, right: 260),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 23, 133, 133),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 14,
                    child: Image.asset('images/left-arrow_3vtq.png'),
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
        ],
      ),
    );
  }
}
