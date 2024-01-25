import 'package:mysql1/mysql1.dart';

class DataBaseController {
  late MySqlConnection _connection;

// Función para conectar a MySQL
  Future<void> _connectToMySQL() async {
    final settings = ConnectionSettings(
      host: 'tu_host_mysql', // Reemplaza con la dirección de tu servidor MySQL
      port: 3306, // Puerto por defecto de MySQL
      user: 'tu_usuario',
      db: 'tu_base_de_datos',
      password: 'tu_contraseña',
    );

    _connection = await MySqlConnection.connect(settings);
  }
}
