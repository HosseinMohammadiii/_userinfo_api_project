// class Users {
//   int userId;
//   int id;
//   // String name;
//   // String username;
//   // String email;
//   String title;
//   String? body;
//   Users(
//     this.userId,
//     this.id,
//     this.title,
//     this.body,
//     // this.email,
//   );
//   factory Users.fromMapJson(Map<String, dynamic> jsonObject) {
//     return Users(
//       jsonObject['userId'],
//       jsonObject['id'],
//       jsonObject['title'],
//       jsonObject['body'],
//     );
//   }
// }
// class Users {
//   int userId;
//   int id;
//   String title;
//   String? body;

//   Users({
//     required this.userId,
//     required this.id,
//     required this.title,
//     this.body,
//   });

//   factory Users.fromJson(Map<String, dynamic> json) => Users(
//         userId: json["userId"],
//         id: json["id"],
//         title: json["title"],
//         body: json["body"],
//       );

//   // Map<String, dynamic> toJson() => {
//   //       "userId": userId,
//   //       "id": id,
//   //       "title": title,
//   //       "body": body,
//   //     };
// }

class Users {
  Users({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.lat,
    required this.lng,
  });
  int id;
  String name;
  String username;
  String email;
  String street;
  String suite;
  String city;
  String zipcode;
  String lat;
  String lng;

  factory Users.fromMapJson(Map<String, dynamic> jsonObject) => Users(
        id: jsonObject['id'],
        name: jsonObject['name'],
        username: jsonObject['username'],
        email: jsonObject['email'],
        street: jsonObject['address']['street'],
        suite: jsonObject['address']['suite'],
        city: jsonObject['address']['city'],
        zipcode: jsonObject['address']['zipcode'],
        lat: jsonObject['address']['geo']['lat'],
        lng: jsonObject['address']['geo']['lng'],
      );
}
