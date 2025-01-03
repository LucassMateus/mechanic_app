class ItemSaveDto {
  ItemSaveDto({
    this.code,
    this.description,
    this.cost,
  });

  int? code;
  String? description;
  double? cost;

  void setCode(String? value) => code = int.tryParse(value ?? '');

  void setDescription(String? value) => description = value;

  void setCost(String? value) => cost = double.tryParse(value ?? '');
}
