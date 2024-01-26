import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mysql1/mysql1.dart';

class MySQLService {
  static Future<MySqlConnection> connectToMySQL() async {
    try {
      await dotenv.load();
      final settings = ConnectionSettings(
        host: dotenv.env['DB_HOST']!,
        port: int.parse(dotenv.env['DB_PORT']!),
        user: dotenv.env['DB_USERNAME']!,
        db: dotenv.env['DB_DATABASE']!,
        password: dotenv.env['DB_PASSWORD']!,
      );
      return await MySqlConnection.connect(settings);
    } catch (e) {
      print('Error de conexión: $e');
      throw Exception(
          'No se pudo conectar a MySQL. Verifica la configuración.');
    }
  }

  static Future<Results> queryDatabase(
    MySqlConnection connection,
    String email,
    String password,
  ) async {
    return await connection.query(
      'SELECT * FROM users WHERE email = ? AND password = ?',
      [email, password],
    );
  }

  static void closeConnection(MySqlConnection connection) {
    connection.close();
  }
}
