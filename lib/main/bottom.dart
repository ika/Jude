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
    final loc = AppLocalizations.of(context)!;
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
      top: false,
      child: Container(
        constraints: BoxConstraints(maxHeight: mq.size.height * 0.9),
        decoration: BoxDecoration(
          color: theme.canvasColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '${loc.appTitle} ${model.id}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          model.text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
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
                  child: ListTile(
                    contentPadding: tileContentPadding,
                    leading: _ActionBadge(
                      label: 'B',
                      colorScheme: colorScheme,
                      size: leadingSize,
                    ),
                    title: Text(loc.mainBookmarkVerse),
                    onTap: () async {
                      Navigator.pop(context);
                      final bookModel = Cache(
                        id: model.id,
                        text: model.text,
                        code: 1,
                      );
                      cacheQueries.doesCacheEntryExist(model.id!).then((value) {
                        if (context.mounted) {
                          if (value < 1) {
                            final futureReturn = cacheQueries.saveCacheEntry(
                              bookModel,
                            );
                            futureReturn.then((_) {
                              onReturnSuccess();
                              Future.delayed(
                                Duration(microseconds: Globals.navigatorDelay),
                                () {
                                  if (context.mounted) {
                                    scaffoldMessenger.showSnackBar(
                                      SnackBar(
                                        content: Text(loc.mainBookmarkAdded),
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
                                  scaffoldMessenger.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        loc.mainBookmarkAlreadyExists,
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          }
                        }
                      });
                    },
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
                  child: ListTile(
                    contentPadding: tileContentPadding,
                    leading: _ActionBadge(
                      label: 'H',
                      colorScheme: colorScheme,
                      size: leadingSize,
                    ),
                    title: Text(loc.mainHighlightVerse),
                    onTap: () async {
                      Navigator.pop(context);
                      final bookModel = Cache(
                        id: model.id,
                        text: model.text,
                        code: 2,
                      );
                      cacheQueries.doesCacheEntryExist(model.id!).then((value) {
                        if (context.mounted) {
                          if (value < 1) {
                            final futureReturn = cacheQueries.saveCacheEntry(
                              bookModel,
                            );
                            futureReturn.then((_) {
                              onReturnSuccess();
                              Future.delayed(
                                Duration(microseconds: Globals.navigatorDelay),
                                () {
                                  if (context.mounted) {
                                    scaffoldMessenger.showSnackBar(
                                      SnackBar(
                                        content: Text(loc.mainHighlightAdded),
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
                                  scaffoldMessenger.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        loc.mainHighlightAlreadyExists,
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          }
                        }
                      });
                    },
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
                  child: ListTile(
                    contentPadding: tileContentPadding,
                    leading: _ActionBadge(
                      label: 'C',
                      colorScheme: colorScheme,
                      size: leadingSize,
                    ),
                    title: Text(loc.mainCopyVerse),
                    onTap: () async {
                      final copyText = <String>[model.text];
                      final sb = StringBuffer()..writeAll(copyText);

                      Clipboard.setData(
                        ClipboardData(text: sb.toString()),
                      ).then((_) {
                        Future.delayed(
                          Duration(milliseconds: Globals.navigatorLongDelay),
                          () {
                            if (context.mounted) {
                              scaffoldMessenger.showSnackBar(
                                SnackBar(content: Text(loc.mainTextCopied)),
                              );
                            }
                          },
                        );
                      });
                    },
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

class _ActionBadge extends StatelessWidget {
  const _ActionBadge({
    required this.label,
    required this.colorScheme,
    required this.size,
  });

  final String label;
  final ColorScheme colorScheme;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
