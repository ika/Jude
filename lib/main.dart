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
        (await getApplicationDocumentsDirectory()).path),
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
        BlocProvider<ScrollBloc>(
          create: (context) => ScrollBloc(),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<FontBloc>(
          create: (context) => FontBloc(),
        ),
        BlocProvider<ItalicBloc>(
          create: (context) => ItalicBloc(),
        ),
        BlocProvider<SizeBloc>(
          create: (context) => SizeBloc(),
        ),
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
              '/search': (context) => const SearchPage()
            },
          );
        },
      ),
    );
  }
}

class DbLoader {
  final String dataBaseName = Constants.mainBaseName;

  Future<void> initialiseDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dataBaseName);

    bool exists = await databaseExists(path);

    // if (exists) {
    //   await deleteDatabase(path);
    //   exists = false;
    // }

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data =
          await rootBundle.load(join("assets/databases", dataBaseName));

      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }
  }
}