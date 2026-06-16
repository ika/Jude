import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'about/page.dart';
import 'bloc/bloc_font.dart';
import 'bloc/bloc_italic.dart';
import 'bloc/bloc_scroll.dart';
import 'bloc/bloc_size.dart';
import 'bloc/bloc_theme.dart';
import 'cache/page.dart';
import 'constants.dart';
import 'fonts/fonts.dart';
import 'main/page.dart';
import 'search/search.dart';
import 'theme/apptheme.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isLinux || Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );

  DbLoader().initialiseDatabase().then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ScrollBloc>(create: (context) => ScrollBloc()),
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
        BlocProvider<FontBloc>(create: (context) => FontBloc()),
        BlocProvider<ItalicBloc>(create: (context) => ItalicBloc()),
        BlocProvider<SizeBloc>(create: (context) => SizeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, bool>(
        builder: (context, state) {
          return MaterialApp(
            locale: const Locale('en'),
            debugShowCheckedModeBanner: false,
            title: 'The Revelation of John',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state ? ThemeMode.light : ThemeMode.dark,
            initialRoute: '/root',
            routes: {
              '/root': (context) => const MainPage(),
              '/cache': (context) => const CachePage(),
              '/fonts': (context) => const FontsPage(),
              '/theme': (context) => const ThemePage(),
              '/about': (context) => const AboutPage(),
              '/search': (context) => const SearchPage(),
            },
          );
        },
      ),
    );
  }
}

// if (exists) {
//   await deleteDatabase(path);
//   exists = false;
// }

class DbLoader {
  final String dataBaseName = Constants.mainBaseName;

  Future<void> initialiseDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, dataBaseName);
    final exists = await databaseExists(path);

    // Load asset bytes once
    final ByteData data = await rootBundle.load(
      join('assets/databases', dataBaseName),
    );
    final List<int> bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );

    // If DB doesn't exist, just copy asset
    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      await File(path).writeAsBytes(bytes, flush: true);
      //return;
    } else {
      // If exists
      // Write asset to a temporary file so we can open and read its PRAGMA
      final tmpDir = await getTemporaryDirectory();
      final tmpPath = join(tmpDir.path, 'tmp_$dataBaseName');
      await File(tmpPath).writeAsBytes(bytes, flush: true);

      try {
        final assetDb = await databaseFactory.openDatabase(tmpPath);
        final existingDb = await databaseFactory.openDatabase(path);

        final assetRes = await assetDb.rawQuery('PRAGMA user_version;');
        final existingRes = await existingDb.rawQuery('PRAGMA user_version;');

        final assetVersion = _extractVersion(assetRes);
        final existingVersion = _extractVersion(existingRes);

        await assetDb.close();
        await existingDb.close();

        debugPrint('ASSET_VER: $assetVersion');
        debugPrint('EXISTING_VER: $existingVersion');

        if (assetVersion > existingVersion) {
          // Replace the existing DB with the newer asset DB
          await File(path).writeAsBytes(bytes, flush: true);
        }
      } catch (_) {
        // On any error, keep the existing DB (or handle logging as needed)
      } finally {
        try {
          await File(tmpPath).delete();
        } catch (_) {}
      }
    }
  }

  int _extractVersion(List<Map<String, Object?>> res) {
    if (res.isNotEmpty) {
      final row = res.first;
      final value = row.values.first;
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? 0;
    }
    return 0;
  }
}
