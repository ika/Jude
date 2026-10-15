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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    const tileContentPadding = EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    );
    const leadingSize = 50.0;

    return SafeArea(
      top: false, // keep top area if you prefer
      child: Container(
        // Limit height so the sheet won't overflow the screen
        constraints: BoxConstraints(maxHeight: mq.size.height * 0.9),
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
                const BottomSheetDragHandle(),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      model.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Material(
                    child: ListTile(
                      contentPadding: tileContentPadding,
                      leading: Container(
                        width: leadingSize,
                        height: leadingSize,
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'B',
                            style: TextStyle(
                              color: colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      title: Text('Bookmark Verse'),
                      onTap: () async {
                        Navigator.pop(context);
                        Cache bookModel = Cache(
                          id: model.id,
                          text: model.text,
                          code: 1,
                        );
                        cacheQueries.doesCacheEntryExist(model.id!).then((
                          value,
                        ) {
                          if (value < 1) {
                            var futureReturn = cacheQueries.saveCacheEntry(
                              bookModel,
                            );
                            futureReturn.then((_) {
                              onReturnSuccess();
                              Future.delayed(
                                Duration(
                                  microseconds: Globals.navigatorDelay,
                                ),
                                () {
                                  scaffoldMessenger.showSnackBar(
                                    const SnackBar(
                                      content: Text('Bookmark Added'),
                                    ),
                                  );
                                },
                              );
                            });
                          } else {
                            Future.delayed(
                              Duration(microseconds: Globals.navigatorDelay),
                              () {
                                scaffoldMessenger.showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Bookmark Already Exists',
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        });
                      },
                    ),
                  ),
                ),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Material(
                    child: ListTile(
                      contentPadding: tileContentPadding,
                      leading: Container(
                        width: leadingSize,
                        height: leadingSize,
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'H',
                            style: TextStyle(
                              color: colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      title: Text('Highlight Verse'),
                      onTap: () async {
                        Navigator.pop(context);
                        Cache bookModel = Cache(
                          id: model.id,
                          text: model.text,
                          code: 2,
                        );
                        cacheQueries.doesCacheEntryExist(model.id!).then((
                          value,
                        ) {
                          if (value < 1) {
                            var futureReturn = cacheQueries.saveCacheEntry(
                              bookModel,
                            );
                            futureReturn.then((_) {
                              onReturnSuccess();
                              Future.delayed(
                                Duration(
                                  microseconds: Globals.navigatorDelay,
                                ),
                                () {
                                  scaffoldMessenger.showSnackBar(
                                    const SnackBar(
                                      content: Text('Highlight Added'),
                                    ),
                                  );
                                },
                              );
                            });
                          } else {
                            Future.delayed(
                              Duration(microseconds: Globals.navigatorDelay),
                              () {
                                scaffoldMessenger.showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Highlight Already Exists',
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        });
                      },
                    ),
                  ),
                ),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Material(
                    child: ListTile(
                      contentPadding: tileContentPadding,
                      leading: Container(
                        width: leadingSize,
                        height: leadingSize,
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'C',
                            style: TextStyle(
                              color: colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      title: Text('Copy Verse'),
                      onTap: () async {
                        Navigator.pop(context);
                        final copyText = <String>[model.text];

                        final sb = StringBuffer();
                        sb.writeAll(copyText);

                        Clipboard.setData(
                          ClipboardData(text: sb.toString()),
                        ).then((_) {
                          Future.delayed(
                            Duration(milliseconds: Globals.navigatorLongDelay),
                            () {
                              scaffoldMessenger.showSnackBar(
                                const SnackBar(content: Text('Text Copied')),
                              );
                            },
                          );
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
