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
  final String status;

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
