import 'dart:convert';

import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';
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
  final Set<ServiceModel> additionalServices;

  @override
  double getValue() {
    double value = 0;
    final services = [...this.services, ...additionalServices];

    for (final service in services) {
      value += service.items.fold(
        0,
        (previousValue, element) => previousValue + element.getValue(),
      );
    }

    for (final item in additionalItems) {
      value += item.getValue();
    }

    return value;
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
      additionalServices: Set<ServiceModel>.from(
          map['additionalServices']?.map((x) => ServiceModel.fromMap(x)) ??
              const []),
      clientName: map['clientName'],
      car: CarModel.fromMap(map['car']),
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      services: Set<ServiceModel>.from(
        map['services']?.map((x) => ServiceModel.fromMap(x)) ?? const [],
      ),
      additionalItems: Set<ItemModel>.from(
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
