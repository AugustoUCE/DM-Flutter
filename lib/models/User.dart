class User {
  final int? id;
  final String firstName;
  final String lastName;

  User({this.id, required this.firstName, required this.lastName});

  // Convertir de un mapa (SQLite) a un objeto User
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
    );
  }

  // Convertir de un objeto User a un mapa (SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  // Convertir a JSON (si necesitas hacerlo)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  // Crear un objeto User desde un JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}
