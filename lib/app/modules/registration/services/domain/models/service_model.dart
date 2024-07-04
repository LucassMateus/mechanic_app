import 'dart:convert';

import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';

class ServiceModel {
  ServiceModel({
    required this.name,
    required this.description,
    required this.hoursAmount,
    required this.items,
    required this.pricePerCar,
  });

  final String name;
  final String description;
  final int hoursAmount;
  final List<ItemModel> items;
  final Map<CarModel, double> pricePerCar;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'hoursAmount': hoursAmount,
      'items': items.map((x) => x.toMap()).toList(),
      'pricePerCar': pricePerCar,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      hoursAmount: map['hoursAmount']?.toInt() ?? 0,
      items: List<ItemModel>.from(
          map['items']?.map((x) => ItemModel.fromMap(x)) ?? const []),
      pricePerCar: Map<CarModel, double>.from(map['pricePerCar'] ?? const {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceModel.fromJson(String source) =>
      ServiceModel.fromMap(json.decode(source));
}
