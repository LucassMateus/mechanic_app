import 'dart:convert';

class UserModel {
  String? name;
  String? user;
  String? password;
  String? token;
  UserModel({
    this.name,
    this.user,
    this.password,
    this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'user': user,
      'password': password,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      user: map['userName'],
      password: map['password'],
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
