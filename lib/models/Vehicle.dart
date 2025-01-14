class Vehicle {
  final int? id;
  final String plate;
  final String brand;
  final DateTime manufactureDate;
  final String color;
  final double cost;
  final bool isActive;

  Vehicle({
    required this.id,
    required this.plate,
    required this.brand,
    required this.manufactureDate,
    required this.color,
    required this.cost,
    required this.isActive,
  });
  //sqlite
    factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'],
      plate: map['plate'],
      brand: map['brand'],
      manufactureDate: DateTime.parse(map['manufactureDate']),
      color: map['color'],
      cost: map['cost'],
      isActive: map['isActive'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plate': plate,
      'brand': brand,
      'manufactureDate': manufactureDate.toIso8601String(),
      'color': color,
      'cost': cost,
      'isActive': isActive,
    };
  }
  //

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      plate: json['plate'],
      brand: json['brand'],
      manufactureDate: DateTime.parse(json['manufactureDate']),
      color: json['color'],
      cost: json['cost'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plate': plate,
      'brand': brand,
      'manufactureDate': manufactureDate.toIso8601String(),
      'color': color,
      'cost': cost,
      'isActive': isActive,
    };
  }
}
