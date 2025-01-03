import 'dart:convert';

class ServiceItemsModel {
  final int id;
  final int serviceId;
  final int itemId;

  ServiceItemsModel({
    required this.id,
    required this.serviceId,
    required this.itemId,
  });

  ServiceItemsModel copyWith({
    int? id,
    int? serviceId,
    int? itemId,
  }) {
    return ServiceItemsModel(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      itemId: itemId ?? this.itemId,
    );
  }

  Map<String, dynamic> upSave() {
    return {
      'serviceId': serviceId,
      'itemId': itemId,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'serviceId': serviceId,
      'itemId': itemId,
    };
  }

  factory ServiceItemsModel.fromMap(Map<String, dynamic> map) {
    return ServiceItemsModel(
      id: map['id']?.toInt() ?? 0,
      serviceId: map['serviceId']?.toInt() ?? 0,
      itemId: map['itemId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceItemsModel.fromJson(String source) =>
      ServiceItemsModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ServiceItemsModel(id: $id, serviceId: $serviceId, itemId: $itemId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServiceItemsModel &&
        other.id == id &&
        other.serviceId == serviceId &&
        other.itemId == itemId;
  }

  @override
  int get hashCode => id.hashCode ^ serviceId.hashCode ^ itemId.hashCode;
}
