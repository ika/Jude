part of 'page.dart';

class BottomSheetCacheWidget extends StatelessWidget {
  final Cache model;
  final VoidCallback onReturnSuccess;

  const BottomSheetCacheWidget({
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
                    leading: _CacheActionBadge(
                      label: 'G',
                      colorScheme: colorScheme,
                      size: leadingSize,
                    ),
                    title: Text(loc.cacheGoToEntry),
                    onTap: () async {
                      Navigator.pop(context);
                      context.read<ScrollBloc>().add(
                        UpdateScroll(index: model.id! - 1),
                      );

                      Navigator.pushNamed(context, '/root');
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
                    leading: _CacheActionBadge(
                      label: 'D',
                      colorScheme: colorScheme,
                      size: leadingSize,
                    ),
                    title: Text(loc.cacheDeleteEntry),
                    onTap: () async {
                      Navigator.pop(context);
                      confirmDialog(context, loc.cacheDeleteEntryPrompt).then((
                        value,
                      ) {
                        if (value) {
                          final futureReturn = cacheQueries.deleteCacheEntry(
                            model.id!,
                          );
                          futureReturn.then((_) {
                            onReturnSuccess();
                            Future.delayed(
                              Duration(microseconds: Globals.navigatorDelay),
                              () {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(loc.cacheEntryDeleted),
                                    ),
                                  );
                                }
                              },
                            );
                          });
                        }
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

  Future confirmDialog(BuildContext context, String title) async {
    return showDialog(
      builder: (context) => AlertDialog(
        title: Text(title),
        actions: [
          TextButton(
            child: Text(
              AppLocalizations.of(context)!.commonYes,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () => Navigator.of(context).pop(true),
          ),
          TextButton(
            child: Text(
              AppLocalizations.of(context)!.commonNo,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
      context: context,
    );
  }
}

class _CacheActionBadge extends StatelessWidget {
  const _CacheActionBadge({
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
