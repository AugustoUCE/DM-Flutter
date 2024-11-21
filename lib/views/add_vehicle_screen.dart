import 'package:flutter/material.dart';
import '../controllers/vehicle_controller.dart';
import '../models/vehicle.dart';

class AddVehicleScreen extends StatelessWidget {
  final VehicleController _controller = VehicleController();
  final TextEditingController plateController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  String selectedColor = 'Blanco';
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Vehículo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: plateController,
              decoration: InputDecoration(labelText: 'Placa'),
            ),
            TextField(
              controller: brandController,
              decoration: InputDecoration(labelText: 'Marca'),
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Fecha de Fabricación (yyyy-mm-dd)'),
            ),
            DropdownButtonFormField(
              value: selectedColor,
              items: ['Blanco', 'Negro', 'Azul']
                  .map((color) => DropdownMenuItem(value: color, child: Text(color)))
                  .toList(),
              onChanged: (value) => selectedColor = value as String,
              decoration: InputDecoration(labelText: 'Color'),
            ),
            TextField(
              controller: costController,
              decoration: InputDecoration(labelText: 'Costo'),
              keyboardType: TextInputType.number,
            ),
            SwitchListTile(
              title: Text('Activo'),
              value: isActive,
              onChanged: (value) => isActive = value,
            ),
            ElevatedButton(
              onPressed: () {
                final vehicle = Vehicle(
                  plate: plateController.text,
                  brand: brandController.text,
                  manufactureDate: DateTime.parse(dateController.text),
                  color: selectedColor,
                  cost: double.parse(costController.text),
                  isActive: isActive,
                );
                _controller.addVehicle(vehicle);
                Navigator.pop(context);
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
