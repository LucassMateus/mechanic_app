import '../../models/car_model.dart';

abstract interface class ICarsGetByCustomerService {
  Future<List<CarModel>> call(int id);
}
