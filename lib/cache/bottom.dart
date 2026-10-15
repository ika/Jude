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
          color: Theme.of(context).canvasColor,
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
                BottomSheetDragHandle(),
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
                // Go To Entry action
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
                    leading: Container(
                      width: leadingSize,
                      height: leadingSize,
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'G',
                          style: TextStyle(
                            color: colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    title: const Text('Go To Entry'),
                    onTap: () async {
                      Navigator.pop(context);
                      context.read<ScrollBloc>().add(
                            UpdateScroll(index: model.id! - 1),
                          );
                      Navigator.pushNamed(context, '/root');
                    },
                  ),
                ),
                // Delete Entry action
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
                    leading: Container(
                      width: leadingSize,
                      height: leadingSize,
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'D',
                          style: TextStyle(
                            color: colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    title: const Text('Delete Entry'),
                    onTap: () async {
                      Navigator.pop(context);
                      confirmDialog(context, 'Delete this Entry?').then((value) {
                        if (value) {
                          var futureReturn =
                              cacheQueries.deleteCacheEntry(model.id!);
                          futureReturn.then((_) {
                            onReturnSuccess();
                            Future.delayed(
                              Duration(microseconds: Globals.navigatorDelay),
                              () {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Entry Deleted!'),
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
            child: const Text(
              'Yes',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () => Navigator.of(context).pop(true),
          ),
          TextButton(
            child: const Text(
              'No',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
      context: context,
    );
  }
}
