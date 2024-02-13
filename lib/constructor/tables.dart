import 'package:sqflite/sqflite.dart' as sql;

class TableCreator {
  static Future<void> createDataTables(sql.Database database) async {
    await createDataTable(database);
    await createCategoriesTable(database);
    await createProductTable(database);
    await createUserTable(database);
  }

  static Future<void> createUserTable(sql.Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            email TEXT,
            nombre TEXT,
            primer_apellido TEXT,
            segundo_apellido TEXT,
            contrasena TEXT,
            nombre_usuario TEXT,
            createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
          )
    """);
  }

  static Future<void> createProductTable(sql.Database database) async {
    //await database.execute("""CREATE TABLE IF NOT EXISTS products(
    //  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    //  id_category INTEGER,
    //  code TEXT,
    //  createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    //)
    //""");
    await database.execute("""CREATE TABLE IF NOT EXISTS products(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      desc TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """);
  }

  static Future<void> createDataTable(sql.Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS data(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      desc TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """);
  }

  static Future<void> createCategoriesTable(sql.Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS categories(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      desc TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase("test.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createDataTables(database);
    });
  }
}
