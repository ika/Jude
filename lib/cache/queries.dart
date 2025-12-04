import 'dart:async';
import 'package:sqflite/sqflite.dart';

import '../constants.dart';
import 'model.dart';
import 'provider.dart';

// List<Cache> noneFound() {
//   List<Cache> returnList = [];
//
//   final defList = Cache(id: 0, text: '', code: 0);
//
//   returnList.add(defList);
//
//   return returnList;
// }

class CacheQueries {
  final CacheProvider provider = CacheProvider();
  final String _dbTable = Constants.cacheTableName;

  Future<void> saveCacheEntry(Cache model) async {
    final db = await provider.database;

    await db.insert(
      _dbTable,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteCacheEntry(int id) async {
    final db = await provider.database;
    await db.rawQuery('''DELETE FROM $_dbTable WHERE id=?''', [id]);
  }

  Future<void> deleteCacheAllbyCode(int code) async {
    final db = await provider.database;
    await db.rawQuery('''DELETE FROM $_dbTable WHERE code=?''', [code]);
  }

  Future<List<Cache>> getAllCacheList() async {
    final db = await provider.database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery('''SELECT * FROM $_dbTable''');

    List<Cache> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Cache(
                id: maps[i]['id'],
                text: maps[i]['text'],
                code: maps[i]['code'],
              );
            },
          )
        : [];
    return list;
  }

  Future<List<Cache>> getCacheListByCode(int code) async {
    final db = await provider.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        '''SELECT * FROM $_dbTable WHERE code=? ORDER BY id DESC''', [code]);

    List<Cache> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Cache(
                id: maps[i]['id'],
                text: maps[i]['text'],
                code: maps[i]['code'],
              );
            },
          )
        : [];
    return list;
  }

  Future<int> doesCacheEntryExist(int id) async {
    final db = await provider.database;

    var cnt = Sqflite.firstIntValue(
      await db.rawQuery('''SELECT MAX(id) FROM $_dbTable WHERE id=?''', [id]),
    );
    return cnt ?? 0;
  }
}
