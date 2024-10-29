import 'dart:async';
import 'dart:io';
import 'package:crud_usuarios/entity/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  factory DBHelper() {
    return _instance;
  }

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'Users.db');
    return await openDatabase(path, version: 1, onCreate: _onCreateDatabase);
  }

  Future _onCreateDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        apellidos TEXT,
        email TEXT NOT NULL
      )
    ''');
  }

  // Método para obtener la ruta de la base de datos
  Future<String> getDatabasePath() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return join(documentsDirectory.path, 'Users.db');
  }

  // Métodos CRUD
  Future<int> createUser (User user) async {
    final db = await database;
    return await db.insert('users', user.toJson());
  }

  Future<List<User>> listUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User.fromJson(maps[i]);
    });
  }

  Future<void> updateUser (User user) async {
    final db = await database;
    await db.update('users', user.toJson(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<void> deleteUser (int id) async {
    final db = await database;
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}