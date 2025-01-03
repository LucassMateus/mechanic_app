import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mechanic_app/app/core/interfaces/valuable.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/dtos/service_car_details_dto.dart';

class ServiceModel implements Valuable {
  ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.items,
    Set<ServiceCarDetailsDto>? carsDetails,
  }) : carsDetails = carsDetails ?? {};

  final int id;
  final String name;
  final String description;
  final Set<ItemModel> items;
  final Set<ServiceCarDetailsDto> carsDetails;

  Map<String, dynamic> upSave() {
    return {
      'name': name,
      'description': description,
    };
  }

  ServiceModel copyWith({
    int? id,
    String? name,
    String? description,
    Set<ItemModel>? items,
    Set<ServiceCarDetailsDto>? carsDetails,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      items: items ?? this.items,
      carsDetails: carsDetails ?? this.carsDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      items: Set<ItemModel>.from(
          map['items']?.map((x) => ItemModel.fromMap(x)) ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceModel.fromJson(String source) =>
      ServiceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ServiceModel(id: $id, name: $name, description: $description, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServiceModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        setEquals(other.items, items) &&
        setEquals(other.carsDetails, carsDetails);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ description.hashCode ^ items.hashCode;
  }

  @override
  double getValue() {
    return items.fold(
      0,
      (previousValue, element) => previousValue + element.cost,
    );
  }
}
