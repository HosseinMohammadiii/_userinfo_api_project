class AvatarUsers {
  AvatarUsers({
    required this.avatar,
  });
  String avatar;

  factory AvatarUsers.fromMapJson(Map<String, dynamic> jsonObject) =>
      AvatarUsers(
        avatar: jsonObject['avatar'],
      );
}
