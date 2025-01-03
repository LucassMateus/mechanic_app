import 'package:flutter/cupertino.dart';
import 'package:mechanic_app/app/core/controllers/base_controller.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/services/get/i_car_get_service.dart';
import 'package:mechanic_app/app/modules/registration/services/domain/dtos/service_car_details_dto.dart';

import '../../../../../core/state/base_state.dart';

class RemovedCarDetailsState extends SuccessState {
  final ServiceCarDetailsDto carDetails;

  RemovedCarDetailsState(this.carDetails, data) : super(data: data);
}

class ServicesPricePerCarController extends BaseController {
  ServicesPricePerCarController(this.carGetService) : super(InitialState());

  @protected
  final ICarGetService carGetService;

  final Set<CarModel> cars = {};
  // final List<CarModel> selectedCars = [];
  // final Map<CarModel, double> pricesPerCar = {};
  // final Map<CarModel, double> hoursPerCar = {};
  final Set<ServiceCarDetailsDto> carsDetails = {};

  Future<void> init(Set<ServiceCarDetailsDto> initialCarsDetails) async {
    update(LoadingState());

    _clearAll();
    final result = await carGetService();
    cars.addAll(result);

    carsDetails.clear();
    carsDetails.addAll(initialCarsDetails);

    update(const SuccessState(data: null));
  }

  List<CarModel> filterCars(String searchTerm) {
    return cars
        .where((e) => e.model.toLowerCase().contains(searchTerm))
        .toList();
  }

  void _clearAll() {
    cars.clear();
    carsDetails.clear();
  }

  void removeCarDetails(ServiceCarDetailsDto carDetails) {
    carsDetails.remove(carDetails);
    update(RemovedCarDetailsState(carDetails, null));
  }
}
