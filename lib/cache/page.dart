import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc_scroll.dart';
import '../globals.dart';
import 'model.dart';
import 'queries.dart';

part 'bottom.dart';

final CacheQueries cacheQueries = CacheQueries();

class CachePage extends StatefulWidget {
  const CachePage({super.key});

  @override
  CachePageState createState() => CachePageState();
}

class CachePageState extends State<CachePage> {
  List<Cache> list = List<Cache>.empty();
  late Future<List<Cache>> _cacheFuture;

  String titleText = (Globals.cacheSelector == 1) ? 'Bookmarks' : 'Highlights';

  @override
  void initState() {
    super.initState();
    _cacheFuture = getCacheFuture();
  }

  Future<List<Cache>> getCacheFuture() {
    return cacheQueries.getCacheListByCode(Globals.cacheSelector);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Cache>>(
      future: _cacheFuture,
      builder: (context, AsyncSnapshot<List<Cache>> snapshot) {
        if (snapshot.hasData) {
          list = snapshot.data!;
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
                      Theme.of(context).colorScheme.surface
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              leading: GestureDetector(
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    Future.delayed(
                      Duration(milliseconds: Globals.navigatorDelay),
                      () {
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                    );
                  },
                ),
              ),
              title: Text(titleText,
                  style: TextStyle(fontWeight: FontWeight.w700)),
              actions: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => confirmDialog(context, 'Delete All Entries?')
                      .then((value) {
                    if (value) {
                      cacheQueries
                          .deleteCacheAllbyCode(Globals.cacheSelector)
                          .then((_) {
                        setState(() {
                          _cacheFuture = getCacheFuture();
                        });
                        Future.delayed(
                          Duration(microseconds: Globals.navigatorDelay),
                          () {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('All entries Deleted'),
                                ),
                              );
                            }
                          },
                        );
                      });
                    }
                  }),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    // contentPadding: const EdgeInsets.symmetric(
                    //     horizontal: 20.0, vertical: 10.0),
                    title: Text(
                      'Revelation',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Row(
                      children: [
                        Icon(Icons.linear_scale,
                            color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            list[index].text,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    // trailing: Icon(Icons.keyboard_arrow_right,
                    //     color: Theme.of(context).colorScheme.primary,
                    //     size: 20.0),
                    onTap: () {
                      // context.read<ScrollBloc>().add(
                      //       UpdateScroll(index: list[index].id! - 1),
                      //     );
                      // Navigator.of(context).pushNamed('/root');

                      final model = Cache(
                          id: list[index].id,
                          text: list[index].text,
                          code: Globals.cacheSelector);

                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (BuildContext bottomSheetContext) {
                          return BottomSheetCacheWidget(
                            model: model,
                            onReturnSuccess: () {
                              setState(() {
                                _cacheFuture = getCacheFuture();
                              });
                            },
                          );
                        },
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
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
}

Future confirmDialog(BuildContext context, String title) async {
  return showDialog(
    builder: (context) => AlertDialog(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      actions: [
        TextButton(
          child:
              Text('Yes', style: const TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () => Navigator.of(context).pop(true),
        ),
        TextButton(
          child:
              Text('No', style: const TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ],
    ),
    context: context,
  );
}
