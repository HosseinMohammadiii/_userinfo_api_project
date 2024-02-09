class AvatarUsers {
  AvatarUsers({
    required this.avatar,
    required this.firstname,
    required this.lastname,
    required this.email,
  });
  String avatar;
  String firstname;
  String lastname;
  String email;

  factory AvatarUsers.fromMapJson(Map<String, dynamic> jsonObject) =>
      AvatarUsers(
        avatar: jsonObject['avatar'],
        firstname: jsonObject['first_name'],
        lastname: jsonObject['last_name'],
        email: jsonObject['email'],
      );
}
