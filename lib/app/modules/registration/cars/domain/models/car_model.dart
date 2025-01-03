import 'dart:convert';

class CarModel {
  CarModel({
    required this.id,
    required this.model,
    required this.brand,
    required this.year,
  });

  final int id;
  final String model;
  final String brand;
  final int year;

  String get fullName => '$brand | $model';
  String get fullNameWithYear => '$brand | $model | $year';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'model': model,
      'brand': brand,
      'year': year,
    };
  }

  Map<String, dynamic> upSave() {
    return {
      'model': model,
      'brand': brand,
      'year': year,
    };
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      id: map['id'] ?? '',
      model: map['model'] ?? '',
      brand: map['brand'] ?? '',
      year: map['year']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarModel.fromJson(String source) =>
      CarModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CarModel &&
        other.id == id &&
        other.model == model &&
        other.brand == brand &&
        other.year == year;
  }

  @override
  int get hashCode {
    return id.hashCode ^ model.hashCode ^ brand.hashCode ^ year.hashCode;
  }
}
