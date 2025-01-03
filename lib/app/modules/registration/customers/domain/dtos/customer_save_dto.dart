import '../../../cars/domain/models/car_model.dart';

class CustomerSaveDto {
  CustomerSaveDto({
    this.name,
    this.phoneNumber,
    this.email,
    this.cars = const [],
  });

  String? name;
  String? phoneNumber;
  String? email;
  List<CarModel> cars;

  void setName(String? value) => name = value;

  void setPhoneNumber(String? value) => phoneNumber = value;

  void setEmail(String? value) => email = value;

  void setCars(List<CarModel>? value) => cars = value ?? [];
}
