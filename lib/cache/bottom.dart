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
                  leading: const Icon(Icons.chevron_right),
                  title: const Text('Go To Entry'),
                  onTap: () async {
                    Navigator.pop(context);
                    context.read<ScrollBloc>().add(UpdateScroll(index: model.id! -1));

                    Navigator.pushNamed(context, '/root');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete_forever),
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
                                  SnackBar(
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
            child: Text('Yes',
                style: const TextStyle(fontWeight: FontWeight.bold)),
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
}
