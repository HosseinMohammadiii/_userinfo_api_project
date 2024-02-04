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
