
import 'dart:convert';

import '../../../cars/domain/models/car_model.dart';

class CustomerModel {
  CustomerModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.email,
    this.cars,
  });

  final int id;
  final String name;
  final String phoneNumber;
  final String? email;
  final List<CarModel>? cars;


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'cars': cars?.map((x) => x.toMap()).toList(),
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      phoneNumber: map['phone'] ?? '',
      email: map['address'],
      cars: List<CarModel>.from(map['cars']?.map((x) => CarModel.fromMap(x)) ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) => CustomerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerModel(id: $id, name: $name, phoneNumber: $phoneNumber, email: $email, cars: $cars)';
  }
}
