import 'dart:convert';

class ServiceCarsModel {
  final int id;
  final int serviceId;
  final int carId;
  final double price;
  final double hours;

  ServiceCarsModel({
    required this.id,
    required this.serviceId,
    required this.carId,
    this.price = 0,
    this.hours = 0,
  });

  ServiceCarsModel copyWith({
    int? id,
    int? serviceId,
    int? carId,
  }) {
    return ServiceCarsModel(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      carId: carId ?? this.carId,
    );
  }

  Map<String, dynamic> upSave() {
    return {
      'serviceId': serviceId,
      'carId': carId,
      'price': price,
      'hours': hours,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'serviceId': serviceId,
      'carId': carId,
      'price': price,
      'hours': hours,
    };
  }

  factory ServiceCarsModel.fromMap(Map<String, dynamic> map) {
    return ServiceCarsModel(
      id: map['id']?.toInt() ?? 0,
      serviceId: map['serviceId']?.toInt() ?? 0,
      carId: map['carId']?.toInt() ?? 0,
      price: map['price']?.toDouble() ?? 0,
      hours: map['hours']?.toDouble() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceCarsModel.fromJson(String source) =>
      ServiceCarsModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ServiceCarsModel(id: $id, serviceId: $serviceId, carId: $carId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServiceCarsModel &&
        other.id == id &&
        other.serviceId == serviceId &&
        other.carId == carId &&
        other.price == price &&
        other.hours == hours;
  }

  @override
  int get hashCode => id.hashCode ^ serviceId.hashCode ^ carId.hashCode;
}
