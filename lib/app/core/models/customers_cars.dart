import 'dart:convert';

class CustomersCarsModel {
  final int id;
  final int customerId;
  final int carId;

  CustomersCarsModel({
    required this.id,
    required this.customerId,
    required this.carId,
  });

  CustomersCarsModel copyWith({
    int? id,
    int? customerId,
    int? carId,
  }) {
    return CustomersCarsModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      carId: carId ?? this.carId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'carId': carId,
    };
  }

  Map<String, dynamic> upSave() {
    return {
      'customerId': customerId,
      'carId': carId,
    };
  }

  factory CustomersCarsModel.fromMap(Map<String, dynamic> map) {
    return CustomersCarsModel(
      id: map['id']?.toInt() ?? 0,
      customerId: map['customerId']?.toInt() ?? 0,
      carId: map['carId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomersCarsModel.fromJson(String source) =>
      CustomersCarsModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'CustomersCarsModel(id: $id, customerId: $customerId, carId: $carId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomersCarsModel &&
        other.id == id &&
        other.customerId == customerId &&
        other.carId == carId;
  }

  @override
  int get hashCode => id.hashCode ^ customerId.hashCode ^ carId.hashCode;
}
