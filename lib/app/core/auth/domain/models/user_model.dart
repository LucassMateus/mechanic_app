class UserModel {
  String? usuario;
  String? senha;
  bool? salvaLogin;
  String? token;

  UserModel({this.usuario, this.senha, this.salvaLogin, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    usuario = json['user'];
    senha = json['password'];
    salvaLogin = json['saveLogin'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = usuario;
    data['password'] = senha;
    data['saveLogin'] = salvaLogin;
    data['token'] = token;
    return data;
  }

  @override
  String toString() =>
      'User(usuario: $usuario, senha: $senha, salvaLogin: $salvaLogin)';
}
