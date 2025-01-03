import '../../../cars/domain/models/car_model.dart';

class ServiceCarDetailsDto {
  final CarModel car;
  double hoursPerCar;
  double pricePerCar;

  ServiceCarDetailsDto(
    this.car, {
    this.hoursPerCar = 0,
    this.pricePerCar = 0,
  });

  void setHoursPerCar(double? hours) {
    hoursPerCar = hours ?? hoursPerCar;
  }

  void setPricePerCar(double? price) {
    pricePerCar = price ?? pricePerCar;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServiceCarDetailsDto &&
        other.car == car &&
        other.hoursPerCar == hoursPerCar &&
        other.pricePerCar == pricePerCar;
  }

  @override
  int get hashCode =>
      car.hashCode ^ hoursPerCar.hashCode ^ pricePerCar.hashCode;
}
