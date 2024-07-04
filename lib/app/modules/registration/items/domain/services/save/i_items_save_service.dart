abstract interface class IItemsSaveService {
  Future<void> call(int code, String description, double cost);

}