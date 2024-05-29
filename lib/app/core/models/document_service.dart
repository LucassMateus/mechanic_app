import 'package:flutter/material.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/models/service_model.dart';

abstract class DocumentService {
  final String clientName;
  final CarModel car;
  final DateTime date;
  final List<ServiceModel> services;
  final List<ItemModel> additionalItems;
  final int additionalHours;
  final String observations;
  final DocumentStatus status;

  DocumentService({
    required this.clientName,
    required this.car,
    required this.date,
    required this.services,
    required this.additionalItems,
    required this.additionalHours,
    required this.observations,
    required this.status,
  });

  double getValor();
}

enum DocumentStatus {
  approved(
    color: Color.fromARGB(255, 139, 255, 106),
    icon: Icon(Icons.check_circle_outline, size: 28),
    name: 'Aprovado',
  ),
  scheduled(
    color: Colors.blueGrey,
    icon: Icon(Icons.calendar_month, size: 28),
    name: 'Agendado',
  ),
  pending(
    color: Colors.grey,
    icon: Icon(Icons.schedule, size: 28),
    name: 'Pendente',
  );

  final Color color;
  final Icon icon;
  final String name;

  const DocumentStatus({
    required this.color,
    required this.icon,
    required this.name,
  });
}
