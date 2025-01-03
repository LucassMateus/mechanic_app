import 'package:mechanic_app/app/core/database/app_db_context.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_db_set.dart';

class MockAppDbContext extends Mock implements AppDbContext {
  final mockCars = MockDbSet<CarModel>();

  MockAppDbContext() {
    when(() => cars).thenReturn(mockCars);
  }
}
