import 'package:mechanic_app/app/modules/registration/services/domain/dtos/service_car_details_dto.dart';

import '../../../items/domain/models/item_model.dart';

class ServiceSaveDto {
  String name;
  String description;
  Set<ItemModel> items = {};
  Set<ServiceCarDetailsDto> carsDetails = {};

  ServiceSaveDto({this.name = '', this.description = ''});

  void setName(String? name) {
    this.name = name ?? '';
  }

  void setDescription(String? description) {
    this.description = description ?? '';
  }

  @override
  int get hashCode => name.hashCode ^ description.hashCode;

  @override
  String toString() =>
      'ServiceSaveDto(name: $name, description: $description, carsDetails: $carsDetails)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServiceSaveDto &&
        other.name == name &&
        other.description == description;
  }
}
