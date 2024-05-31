
import '../../../cars/domain/models/car_model.dart';

class CustomerModel {
  CustomerModel({
    required this.name,
    required this.phoneNumber,
    this.email,
    required this.cars,
  });

  final String name;
  final String phoneNumber;
  final String? email;
  final List<CarModel> cars;

}
