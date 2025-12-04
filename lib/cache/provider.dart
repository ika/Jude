import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constants.dart';

class CacheProvider {
  final String _dbName = Constants.cacheBaseName;
  final String _dbTable = Constants.cacheTableName;

  CacheProvider.internal();

  static dynamic _database;

  static final CacheProvider _instance = CacheProvider.internal();

  factory CacheProvider() => _instance;

  Future<Database> get database async {
    _database ??= await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _dbName);

    late Database database;

    bool exists = await databaseExists(path);

    if (!exists) {
      database = await openDatabase(
        path,
        version: 1,
        onOpen: (db) async {},
        onCreate: (Database db, int version) async {
          await db.execute('''
                CREATE TABLE IF NOT EXISTS $_dbTable (
                    id INTEGER PRIMARY KEY,
                    text TEXT DEFAULT '',
                    code INTEGER DEFAULT 0
                )
            ''');
        },
      );

      return database;
    } else {
      return database = await openDatabase(path);
    }
  }

  Future close() async {
    return _database!.close();
  }
}
