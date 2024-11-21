import 'package:flutter/material.dart';
import 'package:flutter_app/models/vehicle.dart';

class VehicleListBody extends StatelessWidget {
  final List<Vehicle> vehicles;
  final Function(Vehicle) onVehicleSelected;

  const VehicleListBody({
    super.key,
    required this.vehicles,
    required this.onVehicleSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (vehicles.isEmpty) {
      return const Center(
        child: Text(
          'No hay vehículos registrados.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: vehicles.length,
      itemBuilder: (context, index) {
        final vehicle = vehicles[index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors
                  .black87, // Asume que el color es un código hexadecimal (#FF0000)
              radius: 25,
              child: Icon(
                Icons.directions_car,
                color: Colors.white,
              ),
            ),
            title: Text(
              vehicle.plate,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Marca: ${vehicle.brand}',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                Text(
                  'Fabricación: ${vehicle.manufactureDate.year}',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                Text(
                  'Costo: \$${vehicle.cost.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                Text(
                  'Estado: ${vehicle.isActive ? "Activo" : "Inactivo"}',
                  style: TextStyle(
                    color: vehicle.isActive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 20,
            ),
            onTap: () => onVehicleSelected(vehicle),
          ),
        );
      },
    );
  }
}
