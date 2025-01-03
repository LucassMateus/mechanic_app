import 'package:mechanic_app/app/modules/registration/services/domain/models/service_model.dart';

abstract interface class IServicesDeleteService {
  Future<void> call(ServiceModel service);
}
