import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart'; // Para usar Platform
import 'package:permission_handler/permission_handler.dart';
import '../models/user.dart';
import '../database/database_helper.dart';
import 'package:crypto/crypto.dart';

class LoginController {
  LoginController._singleton();
  static final LoginController _mismaInstancia = LoginController._singleton();
  factory LoginController() => _mismaInstancia;

  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // Obtener todos los usuarios de la base de datos
  Future<List<User>> getUsers() async {
    try {
      return await _dbHelper.getUsers();
    } catch (e) {
      print('Error al obtener usuarios: $e');
      return [];
    }
  }

  // Agregar un usuario
  Future<void> addUser(String firstName, String lastName) async {
    try {
      User newUser = User(id: null, firstName: firstName, lastName: lastName);
      await _dbHelper.insertUser(newUser);
      print('Usuario agregado exitosamente');
    } catch (e) {
      print('Error al agregar usuario: $e');
    }
  }

  // Verificar si el usuario existe en la base de datos (login)
  Future<bool> loginUser(String firstName, String lastName) async {
    try {
      // Encriptar el apellido ingresado
      final encryptedLastName =
          sha512.convert(utf8.encode(lastName)).toString();

      // Obtener todos los usuarios
      List<User> users = await _dbHelper.getUsers();

      // Verificar las credenciales
      for (User user in users) {
        print('Comparando con usuario: ${user.toJson()}');
        if (user.firstName == firstName && user.lastName == encryptedLastName) {
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

  // Función de registro (no lo he cambiado mucho, ya que parece funcionar correctamente)
  Future<void> registerUser(String firstName, String lastName) async {
    try {
      User newUser = User(id: null, firstName: firstName, lastName: lastName);
      await _dbHelper.insertUser(newUser);
      print('Usuario registrado exitosamente: ${newUser.toJson()}');
    } catch (e) {
      print('Error al registrar usuario: $e');
    }
  }

  // Verificar si un usuario existe por su primer nombre
  Future<bool> isUserExist(String firstName) async {
    try {
      List<User> users = await _dbHelper.getUsers();
      for (User user in users) {
        if (user.firstName == firstName) {
          return true; // El usuario ya existe
        }
      }
      return false; // El usuario no existe
    } catch (e) {
      print('Error al verificar existencia de usuario: $e');
      return false;
    }
  }

  // Guardar usuarios en un archivo JSON
  Future<void> saveJsonToFile() async {
    try {
      // Obtener los usuarios de la base de datos
      List<User> users = await getUsers();
      String jsonString =
          jsonEncode(users.map((user) => user.toJson()).toList());

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
      } else if (Platform.isWindows) {
        try {
          final directory = await getApplicationDocumentsDirectory();
          final path = directory.path;
          final file = File('$path/users.json');
          await file.writeAsString(jsonString);
          print('Archivo guardado en: $path/users.json');
        } catch (e) {
          print('Error al guardar el archivo: $e');
        }
      } else {
        print('Plataforma no soportada');
      }
    } catch (e) {
      print('Error al guardar el archivo JSON: $e');
    }
  }

  // Cargar los usuarios desde un archivo JSON
  Future<void> loadJsonFromFile() async {
    try {
      if (Platform.isAndroid || Platform.isWindows) {
        final directory = Platform.isAndroid
            ? Directory('/storage/emulated/0/Download')
            : await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/users.json');

        if (await file.exists()) {
          final jsonString = await file.readAsString();
          final List<dynamic> jsonList = jsonDecode(jsonString);
          // Limpiar la base de datos actual y cargar los datos desde el archivo
          List<User> loadedUsers =
              jsonList.map((json) => User.fromJson(json)).toList();
          // Aquí puedes hacer lo que necesites con los usuarios cargados, por ejemplo, guardarlos en la base de datos.
          print('Datos cargados exitosamente desde el archivo.');
        } else {
          print('El archivo no existe, se usará la lista predeterminada.');
        }
      } else {
        print('Plataforma no soportada para leer datos.');
      }
    } catch (e) {
      print('Error al cargar los datos: $e');
    }
  }

  // Verificar permisos para acceder a almacenamiento
  Future<bool> _checkPermissions() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    return status.isGranted;
  }

  // Guardar datos cuando la app se cierre
  void saveDataOnExit() {
    saveJsonToFile();
    print('Guardando datos antes de salir');
  }
}
