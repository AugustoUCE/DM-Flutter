import 'package:flutter/material.dart';
import 'package:flutter_app/views/vehicle_list/vehicle_list_screen.dart';
import 'views/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehículos App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: VehicleListScreen(),
    );
  }
}
