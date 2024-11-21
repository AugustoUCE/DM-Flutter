import 'package:flutter/material.dart';
import 'package:flutter_app/models/vehicle.dart';
import 'package:flutter_app/views/vehicle_list/widgets/vehicle_list_body.dart';
import '../../controllers/vehicle_controller.dart';
import '../add_vehicle_screen.dart';

class VehicleListScreen extends StatefulWidget {
  @override
  _VehicleListScreenState createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  final VehicleController _controller = VehicleController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Vehículos')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddVehicleScreen()),
          ).then((_) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
      body: VehicleListBody(
        vehicles: _controller.vehicles,
        onVehicleSelected: (vehicle) {
          // Acción al seleccionar un vehículo (ej. ver detalles)
          print("Vehículo seleccionado: ${vehicle.plate}");
        },
      ),
    );
  }
}
