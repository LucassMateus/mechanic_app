import '../../../../cars/domain/models/car_model.dart';
import '../../../../items/domain/models/item_model.dart';

abstract interface class IServicesSaveService {
  Future<void> call(String name, String description, int hoursAmount,
      List<ItemModel> items, Map<CarModel, double> pricePerCar);
}
