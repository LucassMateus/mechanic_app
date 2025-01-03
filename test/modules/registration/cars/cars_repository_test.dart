import 'package:mechanic_app/app/modules/registration/cars/domain/models/car_model.dart';
import 'package:mechanic_app/app/modules/registration/cars/domain/repositories/i_car_repository.dart';
import 'package:mechanic_app/app/modules/registration/cars/external/data_sources/car_local_dao.dart';
import 'package:mechanic_app/app/modules/registration/cars/infra/repositories/car_repository_impl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../core/database/mock_app_db_context.dart';
import '../../../core/database/sqlite_database_test_config.dart';

class MyTypeFake extends Fake implements CarModel {}

void main() {
  // late SqliteDatabaseTestConfig sqliteConfig;
  late CarsLocalDAO carsLocalDAO;
  late ICarRepository carRepository;
  late MockAppDbContext dbContext;

  setUpAll(
    () {
      registerFallbackValue(MyTypeFake());
      SqliteDatabaseTestConfig();
      dbContext = MockAppDbContext();
      carsLocalDAO = CarsLocalDAO(dbContext: dbContext);
      carRepository = CarRepositoryImpl(localDAO: carsLocalDAO);
    },
  );

  tearDownAll(() async {
    // final cnx = await SqliteDbConnection.get().open();
    // await cnx.execute('DELETE FROM Cars');
    // await cnx.close();
  });

  group('Group test save', () {
    test('Should save a car', () async {
      //Arrange
      final saveCar = CarModel(
        id: -1,
        model: 'Teste',
        brand: 'Teste',
        year: 2999,
      );

      //Act
      await carRepository.save(saveCar);

      //Assert
      verify(() => carRepository.save(any())).called(1);
    });
  });

  group('Group test getAll', () {
    test('Should return a list of cars', () async {
      //Arrange
      //Act
      final cars = await carRepository.getAll();
      //Assert
      expect(cars, isA<List<CarModel>>());
    });

    test('Should return a exception', () async {});
  });
}
