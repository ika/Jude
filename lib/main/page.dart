import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:share_plus/share_plus.dart';

import '../bloc/bloc_font.dart';
import '../bloc/bloc_italic.dart';
import '../bloc/bloc_scroll.dart';
import '../bloc/bloc_size.dart';
import '../cache/model.dart';
import '../cache/page.dart';
import '../constants.dart';
import '../fonts/list.dart';
import '../globals.dart';
import 'model.dart';
import 'queries.dart';

part 'bottom.dart';

part 'drawer.dart';

// Revelation

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  ItemScrollController initialScrollController = ItemScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Main> paragraphs = List<Main>.empty();
  late Future<List<Main>> _mainFuture;

  @override
  void initState() {
    super.initState();

    _mainFuture = getMainFuture();

    // get scroll position
    int scrollBlocState = context.read<ScrollBloc>().state;

    // reset scrolling
    context.read<ScrollBloc>().add(UpdateScroll(index: 0));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: Globals.navigatorLongDelay), () {
        if (initialScrollController.isAttached) {
          initialScrollController.scrollTo(
            index: scrollBlocState,
            duration: Duration(milliseconds: Globals.navigatorLongDelay),
            curve: Curves.easeInOutCubic,
          );
          //} else {
          // debugPrint("initialScrollController in NOT attached");
        }
      });
    });
  }

  Future<List<Main>> getMainFuture() async {
    await loadCacheMarkings();
    return MainQueries().getMainData();
  }

  void onReturnSuccess() {
    setState(() {
      _mainFuture = getMainFuture();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Main>>(
      future: _mainFuture,
      builder: (context, AsyncSnapshot<List<Main>> snapshot) {
        if (snapshot.hasData) {
          paragraphs = snapshot.data!;
          return Scaffold(
            key: scaffoldKey,
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
              leading: GestureDetector(
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Future.delayed(
                      Duration(milliseconds: Globals.navigatorDelay),
                      () {
                        scaffoldKey.currentState!.openDrawer();
                      },
                    );
                  },
                ),
              ),
              title: Text(
                Constants.projectName,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            drawer: MainDrawer(onReturnSuccess: onReturnSuccess),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ScrollablePositionedList.builder(
                itemCount: paragraphs.length,
                itemScrollController: initialScrollController,
                itemBuilder: (BuildContext context, int index) {
                  String verseText = paragraphs[index].t;
                  return ListTile(
                    title: Text(
                      verseText, // with footnote links
                      style: TextStyle(
                        fontFamily: fontsList[context.read<FontBloc>().state],
                        fontStyle: (context.read<ItalicBloc>().state)
                            ? FontStyle.italic
                            : FontStyle.normal,
                        fontSize: context.read<SizeBloc>().state,
                        backgroundColor: backgroundColor(paragraphs[index].id),
                      ),
                    ),
                    onTap: () {
                      final model = Cache(
                        id: paragraphs[index].id,
                        text: paragraphs[index].t,
                        code: Globals.cacheSelector,
                      );

                      //showPopupMenu(context, model);

                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (BuildContext bottomSheetContext) {
                          return BottomSheetWidget(
                            model: model,
                            onReturnSuccess: () {
                              var newFuture = getMainFuture();
                              setState(() {
                                _mainFuture = newFuture;
                              });
                              newFuture.then((_) {
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  initialScrollController.scrollTo(
                                    index: paragraphs[index].id - 1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeOut,
                                  );
                                });
                              });
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Color? backgroundColor(int d) {
    if (Globals.bookMarkList.contains(d)) {
      return Theme.of(context).colorScheme.primaryContainer;
    } else if (Globals.hightLightList.contains(d)) {
      return Theme.of(context).colorScheme.tertiaryContainer;
    }
    return null;
  }

  Future<void> loadCacheMarkings() async {
    final cacheList = await cacheQueries.getAllCacheList();

    Globals.bookMarkList.clear();
    Globals.hightLightList.clear();

    if (cacheList.isNotEmpty) {
      for (final cache in cacheList) {
        if (cache.code == 1) {
          Globals.bookMarkList.add(cache.id);
        } else if (cache.code == 2) {
          Globals.hightLightList.add(cache.id);
        }
      }
    }
  }
}
