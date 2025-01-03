import 'dart:convert';

class UserModel {
  int id;
  String name;
  String email;
  String user;
  String password;
  bool admin;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.user,
    required this.password,
    required this.admin,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'user': user,
      'password': password,
      'admin': admin,
    };
  }

  Map<String, dynamic> upSave() {
    return {
      'name': name,
      'email': email,
      'user': user,
      'password': password,
      'admin': admin,
    };
  }

  factory UserModel.fromDbMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      user: map['user'],
      password: map['password'],
      admin: map['admin'] == 1 ? true : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromDbMap(json.decode(source));
}
