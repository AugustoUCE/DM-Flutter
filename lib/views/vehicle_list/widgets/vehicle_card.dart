import 'package:flutter/material.dart';
import 'package:flutter_app/models/vehicle.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({
    super.key,
    required this.vehicle,
    required this.onVehicleSelected,
  });

  final Vehicle vehicle;
  final Function(Vehicle p1) onVehicleSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.black87,
          radius: 25,
          child: Icon(
            Icons.directions_car,
            color: Colors.white,
          ),
        ),
        title: Row(
          children: [
            Text(
              vehicle.plate,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(width: 8),
            Badge(
              label: Text(vehicle.isActive ? 'Activo' : 'Inactivo'),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              backgroundColor:
                  vehicle.isActive ? Colors.lightGreen : Colors.redAccent,
            )
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            AtributeRow(atribute: 'Marca', value: vehicle.brand),
            AtributeRow(
                atribute: 'Fabricación',
                value: vehicle.manufactureDate.year.toString()),
            AtributeRow(atribute: 'Costo', value: vehicle.cost.toString()),
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
  }
}

class AtributeRow extends StatelessWidget {
  const AtributeRow({
    super.key,
    required this.atribute,
    required this.value,
  });

  final String atribute;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$atribute:  ',
          style: const TextStyle(color: Colors.black54, fontSize: 16),
        ),
        Text(
          value,
          style: const TextStyle(color: Colors.black87, fontSize: 16),
        ),
      ],
    );
  }
}
