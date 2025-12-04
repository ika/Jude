import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc_font.dart';
import '../bloc/bloc_italic.dart';
import '../bloc/bloc_scroll.dart';
import '../bloc/bloc_size.dart';
import '../bloc/bloc_theme.dart';
import '../fonts/list.dart';
import '../globals.dart';
import '../main/model.dart';
import '../main/queries.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  List<Main> list = List<Main>.empty();

  Future<List<Main>>? filteredSearch;
  Future<List<Main>>? blankSearch;
  Future<List<Main>>? results;

  late String enterdKeyWord;
  late bool themeState;
  late String contents;

  @override
  void initState() {
    super.initState();
    blankSearch = Future.value([]);
    filteredSearch = blankSearch;
    enterdKeyWord = '';
    themeState = context.read<ThemeBloc>().state;
    contents = '';
  }

  Future<void> runFilter(String enterdKeyWord) async {
    enterdKeyWord.isEmpty
        ? results = blankSearch
        : results = MainQueries().getSearchedValues(enterdKeyWord);

    //   // Print a Future<List> from database
    //   results?.then((List<Rev> list) {
    //     for (var i = 0; i < list.length; i++) {
    //       debugPrint(list[i].t.toString());
    //     }
    //   });

    setState(() {
      filteredSearch = results;
    });
  }

  Future emptyInputDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        // Schedule a delayed dismissal of the alert dialog after 3 seconds
        Future.delayed(
          Duration(milliseconds: Globals.navigatorDialogDelay),
          () {
            if (context.mounted) {
              Navigator.of(context).pop(); // Close the dialog
            }
          },
        );

        return const AlertDialog(
          content: SingleChildScrollView(
            child: Center(
              child: Text(
                'Enter a search text!',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }

  // String highLiteSearchWord(String t, String m) {
  //   if (m.isEmpty) return t;
  //   final pattern = RegExp(RegExp.escape(m), caseSensitive: false);
  //   String s = t.replaceAllMapped(pattern, (match) => '[[${match.group(0)!}]]');
  //   //return replaceMarkersWithAnsi(s, '\x1B[43m');
  //   //return replaceMarkersWithHtml(s, '#FFF176');
  //   return s;
  // }

  // String replaceMarkersWithHtml(String input, String colorHex) {
  //   // colorHex example: '#FFF176' or 'yellow'
  //   final pattern = RegExp(r'\[\[(.*?)\]\]');
  //   return input.replaceAllMapped(
  //     pattern,
  //     (m) => '<span style="background-color:$colorHex">${m[1]}</span>',
  //   );
  // }

  // String replaceMarkersWithAnsi(String input, String ansiBgCode) {
  //   // ansiBgCode example: '\x1B[43m' for yellow background
  //   const reset = '\x1B[0m';
  //   final pattern = RegExp(r'\[\[(.*?)\]\]');
  //   return input.replaceAllMapped(pattern, (m) => '$ansiBgCode${m[1]}$reset');
  // }

  RichText highLiteSearchWord(String t, String m, BuildContext context) {
    int idx = t.toLowerCase().indexOf(m.toLowerCase());

    if (idx != -1) {
      return RichText(
        text: TextSpan(
          text: t.substring(0, idx),
          style: TextStyle(
            fontFamily: fontsList[context.read<FontBloc>().state],
            fontStyle: (context.read<ItalicBloc>().state)
                ? FontStyle.italic
                : FontStyle.normal,
            fontSize: context.read<SizeBloc>().state,
            color: (themeState) ? Colors.black : Colors.white,
          ),
          children: [
            TextSpan(
              text: t.substring(idx, idx + m.length),
              style: TextStyle(
                fontFamily: fontsList[context.read<FontBloc>().state],
                fontStyle: (context.read<ItalicBloc>().state)
                    ? FontStyle.italic
                    : FontStyle.normal,
                fontSize: context.read<SizeBloc>().state,
                color: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
              ),
            ),
            TextSpan(
              text: t.substring(idx + m.length),
              style: TextStyle(
                fontFamily: fontsList[context.read<FontBloc>().state],
                fontStyle: (context.read<ItalicBloc>().state)
                    ? FontStyle.italic
                    : FontStyle.normal,
                fontSize: context.read<SizeBloc>().state,
                color: themeState ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
      );
    } else {
      return RichText(
        text: TextSpan(
          text: t,
          style: TextStyle(
            fontFamily: fontsList[context.read<FontBloc>().state],
            fontStyle: (context.read<ItalicBloc>().state)
                ? FontStyle.italic
                : FontStyle.normal,
            fontSize: context.read<SizeBloc>().state,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.surface,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          'Search',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back),
          onTap: () {
            Future.delayed(Duration(milliseconds: Globals.navigatorDelay), () {
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            });
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Search...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      (contents.isEmpty)
                          ? emptyInputDialog(context)
                          : runFilter(contents);
                    },
                  ),
                ),
                // onTap: () {
                //   filteredSearch = Future.value([]);
                // },
                onChanged: (value) {
                  contents = value;
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<Main>>(
                  future: filteredSearch,
                  builder: (context, AsyncSnapshot<List<Main>> snapshot) {
                    if (snapshot.hasData) {
                      list = snapshot.data!;
                      return ListView.separated(
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: highLiteSearchWord(
                              list[index].t,
                              contents,
                              context,
                            ),
                            onTap: () {
                              context.read<ScrollBloc>().add(
                                UpdateScroll(index: list[index].id - 1),
                              );

                              Future.delayed(
                                Duration(milliseconds: Globals.navigatorDelay),
                                () {
                                  if (context.mounted) {
                                    Navigator.pushNamed(context, '/root');
                                  }
                                },
                              );
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
