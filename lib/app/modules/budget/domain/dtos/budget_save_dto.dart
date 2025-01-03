import 'package:mechanic_app/app/core/models/document_service.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';
import 'package:mechanic_app/app/modules/registration/customers/domain/models/customer_model.dart';
import 'package:mechanic_app/app/modules/registration/items/domain/models/item_model.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/models/service_model.dart';

class BudgetSaveDto {
  CustomerModel? _customer;
  CarModel? car;
  DateTime? date;
  Set<ServiceModel> services = {};
  Set<ItemModel> additionalItems = {};
  double additionalHours = 0;
  String observations = '';
  DocumentStatus status = DocumentStatus.pending;

  set customer(CustomerModel? value) {
    customer = value;
    car = null;
  }

  CustomerModel? get customer => _customer;
  List<CarModel> get customerCars => _customer?.cars ?? [];
}
