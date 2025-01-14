import 'package:xml/xml.dart';
import '../models/User.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import '../database/database_helper.dart';
import 'package:flutter/material.dart';

class LoginController {
  LoginController._singleton();
  static final LoginController _mismaInstancia = LoginController._singleton();
  factory LoginController() => _mismaInstancia;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> saveJsonToFile() async {
    List<User> users = await _dbHelper.getUsers();
    String jsonString = jsonEncode(users.map((user) => user.toJson()).toList());
    if (Platform.isAndroid) {
      if (await _checkPermissions()) {
        try {
          final directory = Directory('/storage/emulated/0/Download');
          final file = File('${directory.path}/users.json');
          await file.writeAsString(jsonString);
          print('Archivo guardado en: ${file.path}');
        } catch (e) {
          print('Error al guardar el archivo: $e');
        }
      } else {
        print('Permiso de almacenamiento denegado');
      }
    }
  }

  Future<bool> loginUser(String firstName, String lastName) async {
    try {
      List<User> users = await _dbHelper.getUsers();
      for (User user in users) {
        if (user.firstName == firstName && user.lastName == lastName) {
          print('Inicio de sesión exitoso');
          return true;
        }
      }
      print('Credenciales incorrectas');
      return false;
    } catch (e) {
      print('Error al iniciar sesión: $e');
      return false;
    }
  }

  Future<void> registerUser(String firstName, String lastName) async {
    try {
      User newUser = User(id: null, firstName: firstName, lastName: lastName);
      await _dbHelper.insertUser(newUser);
      print('Usuario registrado exitosamente');
    } catch (e) {
      print('Error al registrar usuario: $e');
    }
  }

  Future<void> updateUser(int id, String firstName, String lastName) async {
    try {
      User updatedUser = User(id: id, firstName: firstName, lastName: lastName);
      await _dbHelper.updateUser(updatedUser);
      print('Usuario actualizado exitosamente');
    } catch (e) {
      print('Error al actualizar usuario: $e');
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      await _dbHelper.deleteUser(id);
      print('Usuario eliminado exitosamente');
    } catch (e) {
      print('Error al eliminar usuario: $e');
    }
  }

  Future<bool> _checkPermissions() async {
    // Implementa la lógica para verificar permisos de almacenamiento
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    return status.isGranted;
    
  }
}
