class AvatarUsers {
  AvatarUsers({
    required this.avatar,
    required this.firstname,
  });
  String avatar;
  String firstname;

  factory AvatarUsers.fromMapJson(Map<String, dynamic> jsonObject) =>
      AvatarUsers(
        avatar: jsonObject['avatar'],
        firstname: jsonObject['first_name'],
      );
}
