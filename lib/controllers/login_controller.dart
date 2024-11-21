import '../models/user.dart';

class LoginController {
  final List<User> users = [
    User(firstName: 'John', lastName: 'Doe'),
    User(firstName: 'Jane', lastName: 'Smith'),
  ];

  bool authenticate(String firstName, String lastName) {
    return users.any((user) =>
    user.firstName == firstName && user.lastName == lastName);
  }
}
