import 'package:flutter/material.dart';
import 'package:flutter_app/models/vehicle.dart';
import 'package:flutter_app/views/vehicle_list/widgets/vehicle_list_body.dart';
import '../../controllers/vehicle_controller.dart';
import '../add_vehicle_screen.dart';

class VehicleListScreen extends StatelessWidget {
  final VehicleController _controller = VehicleController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Vehículos')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AddVehicleScreen(controller: _controller)),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder<List<Vehicle>>(
        valueListenable: _controller.vehicles,
        builder: (context, vehicles, _) {
          return VehicleListBody(
            vehicles: vehicles,
            onVehicleSelected: (vehicle) {
              // Acción al seleccionar un vehículo
              print("Vehículo seleccionado: ${vehicle.plate}");
            },
          );
        },
      ),
    );
  }
}
