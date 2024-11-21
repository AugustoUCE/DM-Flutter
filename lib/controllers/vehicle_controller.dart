import '../models/vehicle.dart';

class VehicleController {
  final List<Vehicle> vehicles = [
    Vehicle(
      plate: 'ABC-123',
      brand: 'Toyota',
      manufactureDate: DateTime(2020, 5, 12),
      color: 'Blanco',
      cost: 20000.0,
      isActive: true,
    ),
    Vehicle(
      plate: 'DEF-456',
      brand: 'Honda',
      manufactureDate: DateTime(2018, 7, 20),
      color: 'Negro',
      cost: 18000.0,
      isActive: false,
    ),
    Vehicle(
      plate: 'GHI-789',
      brand: 'Ford',
      manufactureDate: DateTime(2021, 3, 15),
      color: 'Azul',
      cost: 25000.0,
      isActive: true,
    ),
  ];

  void addVehicle(Vehicle vehicle) {
    vehicles.add(vehicle);
  }
}
