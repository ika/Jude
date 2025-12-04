part of 'page.dart';

class BottomSheetWidget extends StatelessWidget {
  final Cache model;
  final VoidCallback onReturnSuccess;

  const BottomSheetWidget({
    super.key,
    required this.model,
    required this.onReturnSuccess,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return SafeArea(
      top: false, // keep top area if you prefer
      child: Container(
        // Limit height so the sheet won't overflow the screen
        constraints: BoxConstraints(
          maxHeight: mq.size.height * 0.9,
        ),
        // Add background & shape consistent with modal sheet
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        // Ensure content is scrollable and padded for keyboard
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // important to avoid unbounded height
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).dividerColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                // Title / content
                // Text(
                //   'Item ${model.id}',
                //   style: Theme.of(context).textTheme.titleLarge,
                // ),
                // const SizedBox(height: 8),

                // Example body - replace with your actual content widgets
                Text(model.text),
                const SizedBox(height: 16),

                // Actions - wrap in Row with Flexible to avoid overflow
                // Row(
                //   children: [
                //     Expanded(
                //       child: ElevatedButton(
                //         onPressed: () {
                //           // example action
                //           onReturnSuccess();
                //           Navigator.of(context).pop();
                //         },
                //         child: const Text('Save'),
                //       ),
                //     ),
                //     const SizedBox(width: 12),
                //     Expanded(
                //       child: OutlinedButton(
                //         onPressed: () => Navigator.of(context).pop(),
                //         child: const Text('Cancel'),
                //       ),
                //     ),
                //   ],
                // ),
                ListTile(
                  leading: const Icon(Icons.bookmark_add),
                  title: const Text('Bookmark Verse'),
                  onTap: () async {
                    Navigator.pop(context);
                    Cache bookModel =
                        Cache(id: model.id, text: model.text, code: 1);
                    cacheQueries.doesCacheEntryExist(model.id!).then(
                      (value) {
                        if (context.mounted) {
                          if (value < 1) {
                            var futureReturn =
                                cacheQueries.saveCacheEntry(bookModel);
                            futureReturn.then((_) {
                              onReturnSuccess();
                              Future.delayed(
                                Duration(microseconds: Globals.navigatorDelay),
                                () {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Bookmark Added'),
                                      ),
                                    );
                                  }
                                },
                              );
                            });
                          } else {
                            Future.delayed(
                              Duration(microseconds: Globals.navigatorDelay),
                              () {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Bookmark Already Exists'),
                                    ),
                                  );
                                }
                              },
                            );
                          }
                        }
                      },
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.highlight),
                  title: const Text('Highlight Verse'),
                  onTap: () async {
                    Navigator.pop(context);
                    Cache bookModel =
                        Cache(id: model.id, text: model.text, code: 2);
                    cacheQueries.doesCacheEntryExist(model.id!).then(
                      (value) {
                        if (context.mounted) {
                          if (value < 1) {
                            var futureReturn =
                                cacheQueries.saveCacheEntry(bookModel);
                            futureReturn.then((_) {
                              onReturnSuccess();
                              Future.delayed(
                                Duration(microseconds: Globals.navigatorDelay),
                                () {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Highlight Added'),
                                      ),
                                    );
                                  }
                                },
                              );
                            });
                          } else {
                            Future.delayed(
                              Duration(microseconds: Globals.navigatorDelay),
                              () {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Highlight Already Exists'),
                                    ),
                                  );
                                }
                              },
                            );
                          }
                        }
                      },
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.copy),
                  title: const Text('Copy Verse'),
                  onTap: () async {
                    final copyText = <String>[model.text];

                    final sb = StringBuffer();
                    sb.writeAll(copyText);

                    Clipboard.setData(
                      ClipboardData(text: sb.toString()),
                    ).then(
                      (_) {
                        Future.delayed(
                          Duration(milliseconds: Globals.navigatorLongDelay),
                          () {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Text Copied'),
                                ),
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
