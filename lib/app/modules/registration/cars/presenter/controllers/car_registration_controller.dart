import 'package:mechanic_app/app/core/controllers/base_controller.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/helpers/functions.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';

class CarRegistrationController extends BaseController {
  CarRegistrationController() : super(InitialState());

   final List<CarModel> _cars = [];
  final List<CarModel> _filteredCars = [];

  void getCars() {
    final newCostumers = generateCars(15);
    _cars.addAll(newCostumers);
    _filteredCars.addAll(_cars);

    update(SuccessState(data: _filteredCars));
  }

  void filterCar(String filterValue) {
    _filteredCars.clear();
    if (filterValue.isEmpty) {
      _filteredCars.addAll(_cars);
    } else {
      _filteredCars.addAll(_cars.where((item) {
        final filterLower = filterValue.toLowerCase();
        final modelMatches = item.model.toLowerCase().contains(filterLower);
        final brandMatches = item.brand.toLowerCase().contains(filterLower);
        final yearMatches = item.year.toString().contains(filterLower);

        return modelMatches || brandMatches || yearMatches;
      }).toList());
    }
    update(SuccessState(data: _filteredCars));
  }

  void removeCar(CarModel car) {
    _cars.remove(car);
    _filteredCars.remove(car);
    update(SuccessState(data: _filteredCars));
  }
}
