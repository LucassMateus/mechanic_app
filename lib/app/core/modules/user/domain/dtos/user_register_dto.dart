class UserRegisterDto {
  final String name;
  final String email;
  final String user;
  final String password;
  final bool admin;

  UserRegisterDto({
    required this.name,
    required this.email,
    required this.user,
    required this.password,
    this.admin = false,
  });
}
