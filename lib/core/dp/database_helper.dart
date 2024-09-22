import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? db;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (db != null) return db!;
    db = await initDB();
    return db!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'qr_code_data.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE qr_codes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertQRCode(String data) async {
    final db = await database;
    await db.insert(
      'qr_codes',
      {'data': data},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> fetchQRCodes() async {
    final db = await database;
    return await db.query('qr_codes');
  }

  Future<void> deleteQRCode(int id) async {
    final db = await database;
    await db.delete(
      'qr_codes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
