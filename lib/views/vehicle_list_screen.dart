import 'package:flutter/material.dart';
import '../controllers/vehicle_controller.dart';
import 'add_vehicle_screen.dart';

class VehicleListScreen extends StatefulWidget {
  @override
  _VehicleListScreenState createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  final VehicleController _controller = VehicleController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Vehículos')),
      body: ListView.builder(
        itemCount: _controller.vehicles.length,
        itemBuilder: (context, index) {
          final vehicle = _controller.vehicles[index];
          return ListTile(
            title: Text(vehicle.plate),
            subtitle: Text('${vehicle.brand} - ${vehicle.color}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddVehicleScreen()),
          ).then((_) => setState(() {}));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
