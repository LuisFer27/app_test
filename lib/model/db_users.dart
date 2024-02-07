import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBUsers {
  static Database? _database;
  static final DBUsers instance = DBUsers._privateConstructor();

  DBUsers._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    // Si la base de datos no existe, créala
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'your_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            email TEXT,
            nombre TEXT,
            primer_apellido TEXT,
            segundo_apellido TEXT,
            contrasena TEXT,
            nombre_usuario TEXT
          )
        ''');
      },
    );
  }

  // Método para insertar un usuario en la base de datos
  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert('users', user);
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserByUsername(String username) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'nombre_usuario = ?',
      whereArgs: [username],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<int> updateUser(
      int? id,
      String nombre,
      String primerApellido,
      String segundoApellido,
      String nombre_usuario,
      String email,
      String contrasena) async {
    final db = await instance.database;
    final data = {
      'nombre': nombre,
      'primer_apellido': primerApellido,
      'segundo_apellido': segundoApellido,
      'nombre_usuario': nombre_usuario,
      'email': email,
      'contrasena': contrasena, // Corregir el nombre del parámetro aquí
    };

    return await db.update('users', data, where: 'id = ?', whereArgs: [id]);
  }
}
