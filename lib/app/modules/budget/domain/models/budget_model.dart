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
  double getValue() {
    double value = 0;

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
}
