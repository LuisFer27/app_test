//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mysql1/mysql1.dart';

class MySQLService {
  static const String db = "test";
  static const String user = "root";
  static const String pass = "";
  static const String host = "localhost";
  static const int port = 3306;

  static Future<MySqlConnection> connectToMySQL() async {
    try {
      // Configuración de la conexión MySQL
      final settings = ConnectionSettings(
        host: host,
        port: port,
        db: db,
        user: user,
        password: pass,
      );
      // Conectar a MySQL
      MySqlConnection connection = await MySqlConnection.connect(settings);

      return connection;
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

  static Future<void> closeConnection(MySqlConnection connection) async {
    await connection.close();
  }
}
