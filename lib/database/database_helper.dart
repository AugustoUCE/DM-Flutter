import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user.dart';

class DatabaseHelper {
  static const _databaseName = "usuarios.db";
  static const _databaseVersion = 1;
  static const table = 'usuarios';

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  // Crear o abrir la base de datos
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Abrir la base de datos y crear la tabla
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // Crear la tabla de usuarios
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table(
        id INTEGER PRIMARY KEY,
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL
      )
    ''');
  }

  // Insertar un usuario
  Future<int> insertUser(User user) async {
    Database db = await database;
    return await db.insert(table, user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Obtener todos los usuarios
  Future<List<User>> getUsers() async {
    Database db = await database;
    var result = await db.query(table);
    return result.isNotEmpty ? result.map((c) => User.fromMap(c)).toList() : [];
  }

  // Actualizar un usuario
  Future<int> updateUser(User user) async {
    Database db = await database;
    return await db
        .update(table, user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  // Eliminar un usuario
  Future<int> deleteUser(int id) async {
    Database db = await database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
