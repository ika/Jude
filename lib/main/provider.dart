

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constants.dart';

class MainProvider {
  final String _dbName = Constants.mainBaseName;


  MainProvider.internal();

  static final MainProvider _instance = MainProvider.internal();
  static Database? _database;

  factory MainProvider() => _instance;

  Future<Database> get database async {
    _database ??= await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _dbName);

    // if (!await databaseExists(path)) {
    //   try {
    //     await Directory(dirname(path)).create(recursive: true);
    //   } catch (_) {}
    //
    //   ByteData data = await rootBundle.load(join("assets", _dbName));
    //   List<int> bytes =
    //       data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    //   await File(path).writeAsBytes(bytes, flush: true);
    //
    //   await Future.delayed(const Duration(milliseconds: 500));
    //
    //  // debugPrint('DATABASE LOADED');
    // }
    if (await databaseExists(path)) {
      Database db = await openDatabase(path);
      return db;
    } else {
      throw Exception('Database not found');
    }
  }

  Future close() async {
    return _database!.close();
  }
}
