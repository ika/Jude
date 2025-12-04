

import '../constants.dart';
import 'model.dart';
import 'provider.dart';


MainProvider mainProvider = MainProvider();
const String _dbTable = Constants.mainTableName;

class MainQueries {
  Future<List<Main>> getMainData() async {
    final db = await mainProvider.database;

    // add empty lines at the end
    List<Main> addedLines = [];

    final line = Main(id: 0, t: '');

    for (int l = 0; l <= 15; l++) {
      addedLines.add(line);
    }

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM $_dbTable");

    List<Main> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Main(
                id: maps[i]['id'],
                t: maps[i]['t'],
              );
            },
          )
        : [];

    if (list.isNotEmpty) {
      // final heading = Rev(
      //     id: 0,
      //     t: "The Revelation of John\n(I looked, and there was a door open into heaven)");
      //
      // list.insert(0, heading);
      list.insertAll(list.length, addedLines); // add empty lines
    }

    return list;
  }

  Future<List<Main>> getSearchedValues(String search) async {
    final db = await mainProvider.database;

    List<Main> returnList = [];
    final defList = Main(id: 0, t: 'No search results.');
    returnList.add(defList);

    var res = await db.rawQuery(
        '''SELECT * FROM $_dbTable WHERE t LIKE '%$search%' ORDER BY id ASC''');

    List<Main> list = res.isNotEmpty
        ? res.map((tableName) => Main.fromJson(tableName)).toList()
        : returnList;

    return list;
  }
}
