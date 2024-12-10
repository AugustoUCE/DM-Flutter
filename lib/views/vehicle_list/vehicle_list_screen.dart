import 'package:flutter/material.dart';
import 'package:flutter_app/models/vehicle.dart';
import 'package:flutter_app/views/edit_vehicle_screen.dart';
import 'package:flutter_app/views/vehicle_list/widgets/vehicle_list_body.dart';
import '../../controllers/vehicle_controller.dart';
import '../add_vehicle_screen.dart';
import 'package:flutter_app/views/login_screen.dart';

class VehicleListScreen extends StatelessWidget {
  final VehicleController _controller = VehicleController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Vehículos',
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: const [
                      Icon(Icons.logout, color: Colors.black54),
                      SizedBox(width: 8),
                      Text('Cerrar Sesión'),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newVehicle = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddVehicleScreen(controller: _controller),
            ),
          );

          if (newVehicle != null) {
            _controller.addVehicle(newVehicle);
          }
        },
        child: const Icon(Icons.add_rounded),
      ),
      body: ValueListenableBuilder<List<Vehicle>>(
        valueListenable: _controller.vehicles,
        builder: (context, vehicles, _) {
          return VehicleListBody(
            vehicles: vehicles,
            onVehicleSelected: (vehicle) {
              print("Vehículo seleccionado: ${vehicle.plate}");
            },
            onVehicleDeleted: (vehicle) {
              _controller.removeVehicle(vehicle.plate);
            },
            onVehicleEdited: (vehicle) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditVehicleScreen(
                    vehicle: vehicle,
                    onVehicleEdited: (editedVehicle) {
                      _controller.editVehicle(editedVehicle,
                          vehicles.indexWhere((v) => v.plate == vehicle.plate));
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
