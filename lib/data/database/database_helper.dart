import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:submission_dicoding_app/data/model/restaurant.dart';
import 'package:submission_dicoding_app/data/model/restaurant_detail.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;
  static const String _tableName = 'favorites';

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'favorite_db.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
                id TEXT PRIMARY KEY,
                name TEXT, 
                pictureId TEXT,
                city TEXT,
                rating REAL
              )''',
        );
      },
      version: 1,
    );

    return db;
  }

  Future<bool> insertFavoriteRestaurant({
    required RestaurantDetail restaurantDetail,
  }) async {
    final Database db = await database;
    final response = await db.insert(_tableName, restaurantDetail.toDBMap());

    if (response < 0) {
      return false;
    }

    return true;
  }

  Future<bool> deleteFavoriteRestaurant({
    required String id,
  }) async {
    final Database db = await database;
    final response = await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (response < 0) {
      return false;
    }

    return true;
  }

  Future<List<Restaurant>> getFavoriteRestaurant() async {
    try {
      final Database db = await database;

      List<Map<String, dynamic>> results = await db.query(
        _tableName,
      );

      return results.map((item) => Restaurant.fromMap(item)).toList();
    } on DatabaseException catch (_) {
      rethrow;
    }
  }

  Future<bool> isFavoriteRestaurant({
    required String id,
  }) async {
    try {
      final Database db = await database;

      List<Map<String, dynamic>> results = await db.query(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
      );

      if (results.isEmpty) {
        return false;
      }

      return true;
    } on DatabaseException catch (_) {
      rethrow;
    }
  }
}
