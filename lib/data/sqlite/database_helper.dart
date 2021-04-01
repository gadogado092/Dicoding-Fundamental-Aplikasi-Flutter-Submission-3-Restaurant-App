import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;

  DatabaseHelper._createObject();

  static Database _database;

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createObject();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database;
  }

  static String _tableFavoriteRestaurant = 'favorite_restaurant';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurant_db.db',
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableFavoriteRestaurant (
               id TEXT PRIMARY KEY,
               name TEXT, 
               city TEXT,
               pictureId TEXT,
               rating REAL
             )''',
        );
      },
      version: 1,
    );

    return db;
  }

  Future<void> insertFavoriteRestaurant(Restaurant restaurant) async {
    final Database db = await database;
    await db.insert(_tableFavoriteRestaurant, restaurant.toJsonSql());
  }

  Future<void> deleteFavoriteRestaurant(Restaurant restaurant) async {
    final db = await database;

    await db.delete(
      _tableFavoriteRestaurant,
      where: 'id = ?',
      whereArgs: [restaurant.id],
    );
  }

  Future<List<Restaurant>> getFavoriteRestaurant() async {
    final Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query(_tableFavoriteRestaurant);

    List<Restaurant> listData = results.isNotEmpty
        ? results.map((item) => Restaurant.fromJson(item)).toList()
        : [];

    return listData;
  }

  Future<bool> checkFavoriteStatus(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query(_tableFavoriteRestaurant);

    List<Restaurant> list =
        results.map((res) => Restaurant.fromJson(res)).toList();
    bool status = false;
    for (var i = 0; i < list.length; i++) {
      if (list[i].id == id) {
        return true;
      } else {
        status = false;
      }
    }
    return status;
  }
}
