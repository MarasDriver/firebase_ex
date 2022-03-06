class Cars {
  Cars({required this.model, required this.brand});

  Cars.fromJson(Map<String, Object?> json)
      : this(
          model: json['model']! as String,
          brand: json['brand']! as String,
        );

  String? model;
  String? brand;

  Map<String, Object?> toJson() {
    return {
      'model': model,
      'brand': brand,
    };
  }
}
