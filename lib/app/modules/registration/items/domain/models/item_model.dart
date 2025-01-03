import 'dart:convert';

import 'package:mechanic_app/app/core/interfaces/valuable.dart';

class ItemModel implements Valuable {
  ItemModel({
    required this.id,
    required this.code,
    required this.description,
    required this.cost,
  });

  final int id;
  final int code;
  final String description;
  final double cost;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'description': description,
      'cost': cost,
    };
  }

  Map<String, dynamic> upSave() {
    return {
      'code': code,
      'description': description,
      'cost': cost,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id']?.toInt() ?? 0,
      code: map['code']?.toInt() ?? 0,
      description: map['description'] ?? '',
      cost: map['cost']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemModel &&
        other.id == id &&
        other.code == code &&
        other.description == description &&
        other.cost == cost;
  }

  @override
  int get hashCode {
    return id.hashCode ^ code.hashCode ^ description.hashCode ^ cost.hashCode;
  }

  @override
  double getValue() => cost;
}
