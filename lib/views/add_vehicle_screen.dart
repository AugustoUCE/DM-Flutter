import 'dart:io';

import 'package:flutter/material.dart';
import 'package:persistencia/controllers/database_controller.dart';
import '../models/Vehicle.dart';
import '../controllers/vehicle_controller.dart';

class AddVehicleScreen extends StatefulWidget {
  final VehicleController controller;

  const AddVehicleScreen({
    super.key,
    required this.controller,
  });

  @override
  AddVehicleScreenState createState() => AddVehicleScreenState();
}

class AddVehicleScreenState extends State<AddVehicleScreen> {
  final TextEditingController letterController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  String selectedColor = 'Blanco';
  bool isActive = false;
  DateTime? selectedDate;
  String? imagePath;

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        dateController.text =
            '${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Vehículo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  String? path = await VehicleController().capturePhoto();
                  setState(() {
                    imagePath = path;
                  });
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: imagePath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            File(imagePath!),
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(
                          Icons.camera_alt,
                          size: 48,
                          color: Colors.grey,
                        ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: letterController,
                      maxLength: 3,
                      decoration: const InputDecoration(labelText: 'Letras'),
                      textCapitalization: TextCapitalization.characters,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: numberController,
                      maxLength: 4,
                      decoration: const InputDecoration(labelText: 'Números'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              TextField(
                controller: brandController,
                decoration: const InputDecoration(labelText: 'Marca'),
              ),
              GestureDetector(
                onTap: () => _pickDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    controller: dateController,
                    decoration: const InputDecoration(
                      labelText: 'Fecha de Fabricación',
                    ),
                  ),
                ),
              ),
              DropdownButtonFormField(
                value: selectedColor,
                items: ['Blanco', 'Negro', 'Azul']
                    .map((color) =>
                        DropdownMenuItem(value: color, child: Text(color)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedColor = value as String;
                  });
                },
                decoration: const InputDecoration(labelText: 'Color'),
              ),
              TextField(
                controller: costController,
                decoration: const InputDecoration(labelText: 'Costo'),
                keyboardType: TextInputType.number,
              ),
              SwitchListTile(
                title: const Text('Activo'),
                value: isActive,
                onChanged: (value) {
                  setState(() {
                    isActive = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (selectedDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Por favor selecciona una fecha.')),
                    );
                    return;
                  }
                  final plate =
                      '${letterController.text}-${numberController.text}';
                  final vehicle = Vehicle(
                    plate: plate,
                    brand: brandController.text,
                    manufactureDate: selectedDate!,
                    color: selectedColor,
                    cost: double.parse(costController.text),
                    isActive: isActive,
                    imagePath: imagePath,
                  );
                  Navigator.pop(context, vehicle);
                  // DatabaseController().insertVehicle(vehicle);
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
