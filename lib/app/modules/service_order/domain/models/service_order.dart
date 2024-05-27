import 'dart:convert';

import 'package:mechanic_app/app/core/models/car_model.dart';
import 'package:mechanic_app/app/core/models/document_service.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/models/service_model.dart';

class ServiceOrderModel extends DocumentService {
  ServiceOrderModel({
    required this.startedDate,
    required this.conclusionDate,
    required this.additionalServices,
    required super.clientName,
    required super.car,
    required super.date,
    required super.services,
    required super.additionalItems,
    required super.additionalHours,
    required super.observations,
    required super.status,
  });

  final DateTime startedDate;
  final DateTime conclusionDate;
  final List<ServiceModel> additionalServices;

  @override
  double getValor() {
    throw UnimplementedError();
  }

  Map<String, dynamic> toMap() {
    return {
      'startedDate': startedDate.millisecondsSinceEpoch,
      'conclusionDate': conclusionDate.millisecondsSinceEpoch,
      'additionalServices': additionalServices.map((x) => x.toMap()).toList(),
      'clientName': clientName,
      'car': car.toMap(),
      'date': date.millisecondsSinceEpoch,
      'services': services.map((x) => x.toMap()).toList(),
      'additionalItems': additionalItems.map((x) => x.toMap()).toList(),
      'additionalHours': additionalHours,
      'observations': observations,
      'status': status,
    };
  }

  factory ServiceOrderModel.fromMap(Map<String, dynamic> map) {
    return ServiceOrderModel(
      startedDate: DateTime.fromMillisecondsSinceEpoch(map['startedDate']),
      conclusionDate:
          DateTime.fromMillisecondsSinceEpoch(map['conclusionDate']),
      additionalServices: List<ServiceModel>.from(
          map['additionalServices']?.map((x) => ServiceModel.fromMap(x)) ??
              const []),
      clientName: map['clientName'],
      car: CarModel.fromMap(map['car']),
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      services: List<ServiceModel>.from(
        map['services']?.map((x) => ServiceModel.fromMap(x)) ?? const [],
      ),
      additionalItems: List<ItemModel>.from(
        map['additionalItems']?.map((x) => ItemModel.fromMap(x)) ?? const [],
      ),
      additionalHours: map['additionalHours'],
      observations: map['observations'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceOrderModel.fromJson(String source) =>
      ServiceOrderModel.fromMap(json.decode(source));
}
