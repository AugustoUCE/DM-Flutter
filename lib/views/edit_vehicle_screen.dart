import 'package:flutter/material.dart';
import '../models/Vehicle.dart';

class EditVehicleScreen extends StatefulWidget {
  final Vehicle vehicle;
  final Function(Vehicle) onVehicleEdited;

  const EditVehicleScreen({
    super.key,
    required this.vehicle,
    required this.onVehicleEdited,
  });

  @override
  EditVehicleScreenState createState() => EditVehicleScreenState();
}

class EditVehicleScreenState extends State<EditVehicleScreen> {
  late TextEditingController letterController;
  late TextEditingController numberController;
  late TextEditingController brandController;
  late TextEditingController costController;
  late TextEditingController dateController;
  late String selectedColor;
  late bool isActive;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    letterController =
        TextEditingController(text: widget.vehicle.plate.split('-')[0]);
    numberController =
        TextEditingController(text: widget.vehicle.plate.split('-')[1]);
    brandController = TextEditingController(text: widget.vehicle.brand);
    costController =
        TextEditingController(text: widget.vehicle.cost.toString());
    dateController = TextEditingController(
        text:
            '${widget.vehicle.manufactureDate.year}-${widget.vehicle.manufactureDate.month.toString().padLeft(2, '0')}-${widget.vehicle.manufactureDate.day.toString().padLeft(2, '0')}');
    selectedColor = widget.vehicle.color;
    isActive = widget.vehicle.isActive;
    selectedDate = widget.vehicle.manufactureDate;
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
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
      appBar: AppBar(title: const Text('Editar Vehículo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                  );
                  print(vehicle.toString());
                  widget.onVehicleEdited(vehicle);
                  Navigator.pop(context);
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
