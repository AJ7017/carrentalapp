class Car {
  final String model;
  final double distance;
  final double fuelCapacity;
  final double pricePerHour;

  Car({required this.model, required this.distance, required this.fuelCapacity, required this.pricePerHour});

   factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      model: map['model'],
      distance: _parseDouble(map['distance']), 
      fuelCapacity: _parseDouble(map['fuelCapacity']),
      pricePerHour: _parseDouble(map['pricePerHour']),
    );
  }

  static double _parseDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0; 
    } else {
      return 0.0; 
    }
  }
}