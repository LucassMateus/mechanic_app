class UserLoginDto {
  String? userName;
  String? password;

  UserLoginDto({
    this.userName,
    this.password,
  });

  void setUserName(String? value) => userName = value;
  void setpassword(String? value) => password = value;
}
