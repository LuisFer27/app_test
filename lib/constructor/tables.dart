import 'package:sqflite/sqflite.dart' as sql;

class TableCreator {
  static Future<void> createDataTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE IF NOT EXISTS data(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        desc TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    """);
    await database.execute("""
      CREATE TABLE IF NOT EXISTS categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        desc TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    """);
  }

  static Future<sql.Database> db() async {
    try {
      final database = await sql.openDatabase("database_name.db", version: 1,
          onCreate: (sql.Database database, int version) async {
        await createDataTables(database);
      });

      // Asegurarse de que las tablas se creen antes de devolver la base de datos
      await createDataTables(database);

      return database;
    } catch (e) {
      print("Error al abrir la base de datos: $e");
      throw e;
    }
  }
}
