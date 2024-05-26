class ResponseApi {
  bool? success;
  dynamic data;
  dynamic error;
  dynamic message;

  ResponseApi({this.success, this.data, this.error, this.message});

  ResponseApi.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    data = json['Data'];
    error = json['Error'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Success'] = success;
    data['Data'] = data;
    data['Error'] = error;
    data['Message'] = message;
    return data;
  }

  @override
  String toString() =>
      'ResponseApi: success: $success, data: $data, error: $error, message: $message';
}
