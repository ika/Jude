part of 'page.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onReturnSuccess});

  final VoidCallback onReturnSuccess;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 150.0,
            child: DrawerHeader(
              decoration: const BoxDecoration(),
              child: Baseline(
                baseline: 80,
                baselineType: TextBaseline.alphabetic,
                child: Text(
                  'Index',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.bookmark,
              color: Theme.of(context).colorScheme.primary,
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Bookmarks',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            dense: true,
            onTap: () {
              Globals.cacheSelector = 1;
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  if (context.mounted) {
                    Navigator.pushNamed(context, '/cache').then((_) {
                      onReturnSuccess();
                    });
                  }
                },
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.highlight,
              color: Theme.of(context).colorScheme.primary,
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Highlights',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            dense: true,
            onTap: () {
              Globals.cacheSelector = 2;
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  if (context.mounted) {
                    Navigator.pushNamed(context, '/cache').then((_) {
                      onReturnSuccess();
                    });
                  }
                },
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.primary,
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text('Search', style: Theme.of(context).textTheme.bodyLarge),
            dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  if (context.mounted) {
                    Navigator.pushNamed(context, '/search');
                  }
                },
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.font_download,
              color: Theme.of(context).colorScheme.primary,
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text('Fonts', style: Theme.of(context).textTheme.bodyLarge),
            dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  if (context.mounted) {
                    Navigator.pushNamed(context, '/fonts').then((_) {
                      onReturnSuccess();
                    });
                  }
                },
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.palette,
              color: Theme.of(context).colorScheme.primary,
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text('Theme', style: Theme.of(context).textTheme.bodyLarge),
            dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  if (context.mounted) {
                    Navigator.pushNamed(context, '/theme');
                  }
                },
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Theme.of(context).colorScheme.primary,
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text('About', style: Theme.of(context).textTheme.bodyLarge),
            dense: true,
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  if (context.mounted) {
                    Navigator.pushNamed(context, '/about');
                  }
                },
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.share,
              color: Theme.of(context).colorScheme.primary,
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text('Share', style: Theme.of(context).textTheme.bodyLarge),
            dense: true,
            onTap: () {
              Navigator.pop(context);
              _onShareLink();
            },
          ),
        ],
      ),
    );
  }

  void _onShareLink() async {
    String uri =
        'https://play.google.com/store/apps/details?id=org.armstrong.ika.galatians';
    await SharePlus.instance.share(
      ShareParams(title: 'Galatians', uri: Uri.parse(uri)),
    );
  }
}
