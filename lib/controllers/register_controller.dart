import 'package:persistencia/controllers/login_controller.dart';
import '../models/user.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class RegisterController {
  final LoginController _loginController = LoginController();

  // Función para encriptar el apellido del usuario (como contraseñas)
  String _encryptPassword(String lastName) {
    final bytes = utf8.encode(lastName);
    final digest = sha512.convert(bytes);
    return digest.toString();
  }

  // Registrar un usuario en la base de datos
  Future<bool> registerUser(String firstName, String lastName) async {
    if (firstName.isEmpty || lastName.isEmpty) {
      return false;
    }

    // Verificar si el usuario ya existe en la base de datos
    bool userExists = await _loginController.isUserExist(firstName);
    if (userExists) {
      return false;
    }

    // Encriptar el apellido antes de guardarlo
    final encryptedLastName = _encryptPassword(lastName);

    // Crear el nuevo usuario
    User newUser =
        User(id: null, firstName: firstName, lastName: encryptedLastName);

    // Agregar el usuario a la base de datos
    await _loginController.addUser(firstName, encryptedLastName);

    return true;
  }
}
