import 'dart:convert';

class CarModel {
  CarModel({
    required this.model,
    required this.brand,
    required this.year,
  });

  final String model;
  final String brand;
  final int year;

  Map<String, dynamic> toMap() {
    return {
      'model': model,
      'brand': brand,
      'year': year,
    };
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      model: map['model'] ?? '',
      brand: map['brand'] ?? '',
      year: map['year']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarModel.fromJson(String source) =>
      CarModel.fromMap(json.decode(source));
}
