import 'package:mechanic_app/app/core/models/document_service.dart';

class BudgetModel extends DocumentService {
  BudgetModel({
    required this.id,
    required super.clientName,
    required super.car,
    required super.date,
    required super.services,
    required super.additionalItems,
    required super.additionalHours,
    required super.observations,
    required super.status,
  });

  final int id;

  @override
  double getValor() {
    throw UnimplementedError();
  }
}
