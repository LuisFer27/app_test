import 'package:sqflite/sqflite.dart' as sql;
import 'package:app_test/constructor/tables.dart';

class DBCategories {
  static Future<void> createTables(sql.Database database) async {
    await TableCreator.createDataTables(database);
  }

  static Future<sql.Database> db() async {
    return TableCreator.db();
  }

  static Future<int> createData(String title, String? desc) async {
    final db = await DBCategories.db();
    final data = {'title': title, 'desc': desc};
    final id = await db.insert('categories', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await DBCategories.db();
    return db.query('categories', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSingleData(int id) async {
    final db = await DBCategories.db();
    return db.query('categories', where: "id=?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateData(int id, String title, String? desc) async {
    final db = await DBCategories.db();
    final data = {
      'title': title,
      'desc': desc,
      'createdAt': DateTime.now().toString()
    };
    final result =
        await db.update('categories', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteData(int id) async {
    final db = await DBCategories.db();
    try {
      await db.delete('categories', where: "id=?", whereArgs: [id]);
    } catch (e) {}
  }
}
