class CarSaveDto {
  CarSaveDto({
    this.model,
    this.brand,
    this.year,
  });

  String? model;
  String? brand;
  int? year;

  void setModel(String? value) => model = value;
  void setBrand(String? value) => brand = value;
  void setYear(String? value) => year = int.tryParse(value ?? '');
}
