class Car {
  final String brand;
  final String model;
  final String year;
  final String price;
  final String imageUrl;

  Car({
    required this.brand,
    required this.model,
    required this.year,
    required this.price,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'brand': brand,
      'model': model,
      'year': year,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      brand: map['brand'] ?? '',
      model: map['model'] ?? '',
      year: map['year'] ?? '',
      price: map['price'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
