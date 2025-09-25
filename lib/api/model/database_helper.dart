import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'animal_scan_data.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("animal.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE animal_scan_data (
      Id INTEGER PRIMARY KEY AUTOINCREMENT,
      ImageHome TEXT,
      ImagePath TEXT,
      AnimalInfo TEXT NOT NULL,
      DateTime TEXT,
      AnimalActionType INTEGER NOT NULL,
      IsHistory INTEGER NOT NULL,
      IsFavorite INTEGER NOT NULL
    )
  ''');
  }

  // Insert
  Future<int> create(AnimalScanData animalScanData) async {
    final db = await instance.database;
    return await db.insert('animal_scan_data', animalScanData.toMap());
  }

  // Get all
  Future<List<AnimalScanData>> readAllAnimalScanData() async {
    final db = await instance.database;
    final result = await db.query('animal_scan_data');
    return result.map((json) => AnimalScanData.fromMap(json)).toList();
  }

  // Update
  Future<int> update(AnimalScanData animalScanData) async {
    final db = await instance.database;
    return db.update(
      'animal_scan_data',
      animalScanData.toMap(),
      where: 'id = ?',
      whereArgs: [animalScanData.id],
    );
  }

  // Delete
  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'animal_scan_data',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Close
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
