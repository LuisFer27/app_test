import 'package:app_test/constructor/tables.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DBUsers {
  static Future<void> createTables(sql.Database database) async {
    await TableCreator.createDataTables(database);
  }

  static Future<sql.Database> db() async {
    return TableCreator.db();
  }

  // Método para insertar un usuario en la base de datos
  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await DBUsers.db();
    await db.insert('users', user);
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await DBUsers.db();
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
    final db = await DBUsers.db();
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

  Future<Map<String, dynamic>?> getUserById(int userId) async {
    final db = await DBUsers.db();
    final result = await db.query(
      'users',
      where: 'id = ?', // Cambio aquí para buscar por ID
      whereArgs: [userId], // Cambio aquí para pasar el ID como argumento
    );
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserByEmailOrUsername(
      String emailOrUsername) async {
    final db = await DBUsers.db();
    final List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'email = ? OR nombre_usuario = ?',
      whereArgs: [emailOrUsername, emailOrUsername],
      limit: 1,
    );

    if (users.isNotEmpty) {
      return users.first;
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
    String contrasena,
    String? image, // Nuevo parámetro para la ruta de la imagen
  ) async {
    final db = await DBUsers.db();
    final data = {
      'nombre': nombre,
      'primer_apellido': primerApellido,
      'segundo_apellido': segundoApellido,
      'nombre_usuario': nombre_usuario,
      'email': email,
      'contrasena': contrasena,
      'image': image, // Incluir la ruta de la imagen en los datos actualizados
    };

    return await db.update('users', data, where: 'id = ?', whereArgs: [id]);
  }
}
