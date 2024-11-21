import 'package:flutter/material.dart';
import '../controllers/login_controller.dart';
import 'vehicle_list/vehicle_list_screen.dart';

class LoginScreen extends StatelessWidget {
  final LoginController _controller = LoginController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Apellido'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_controller.authenticate(
                  firstNameController.text,
                  lastNameController.text,
                )) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => VehicleListScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Credenciales inválidas')),
                  );
                }
              },
              child: Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }
}
