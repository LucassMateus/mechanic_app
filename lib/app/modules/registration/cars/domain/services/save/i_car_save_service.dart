abstract interface class ICarSaveService {
  Future<void> call(String model, String brand, int year);
}