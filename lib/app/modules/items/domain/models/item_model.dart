import 'dart:convert';

class ItemModel {
  ItemModel({
    required this.code,
    required this.description,
    required this.cost,
  });

  final int code;
  final String description;
  final double cost;

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'description': description,
      'cost': cost,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      code: map['code']?.toInt() ?? 0,
      description: map['description'] ?? '',
      cost: map['cost']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source));
}
