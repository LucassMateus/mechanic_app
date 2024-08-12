import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';

class ServiceModel {
  ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.hoursAmount,
    required this.items,
    required this.pricePerCar,
  });

  final int id;
  final String name;
  final String description;
  final int hoursAmount;
  final List<ItemModel> items;
  final Map<CarModel, double> pricePerCar;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'hoursAmount': hoursAmount,
      'items': items.map((x) => x.toMap()).toList(),
      'pricePerCar': pricePerCar,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      hoursAmount: map['quantity_hours']?.toInt() ?? 0,
      items: List<ItemModel>.from(
          map['items']?.map((x) => ItemModel.fromMap(x)) ?? const []),
      pricePerCar: Map<CarModel, double>.from(map['pricePerCar'] ?? const {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceModel.fromJson(String source) =>
      ServiceModel.fromMap(json.decode(source));

  ServiceModel copyWith({
    int? id,
    String? name,
    String? description,
    int? hoursAmount,
    List<ItemModel>? items,
    Map<CarModel, double>? pricePerCar,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      hoursAmount: hoursAmount ?? this.hoursAmount,
      items: items ?? this.items,
      pricePerCar: pricePerCar ?? this.pricePerCar,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ServiceModel &&
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.hoursAmount == hoursAmount &&
      listEquals(other.items, items) &&
      mapEquals(other.pricePerCar, pricePerCar);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      hoursAmount.hashCode ^
      items.hashCode ^
      pricePerCar.hashCode;
  }
}
