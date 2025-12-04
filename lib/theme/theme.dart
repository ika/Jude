
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc_theme.dart';
import '../globals.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  ThemePageState createState() => ThemePageState();
}

class ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
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
            child: const Icon(Icons.arrow_back),
            onTap: () {
              Future.delayed(
                Duration(milliseconds: Globals.navigatorDelay),
                () {
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              );
            },
          ),
          title: Text('Theme Switcher',
              style: const TextStyle(fontWeight: FontWeight.w700)),
          // actions: [
          //   Switch(
          //     value: (context.read<ThemeBloc>()) ? true : false,
          //     onChanged: (bool value) {
          //       context.read<ThemeBloc>().add(ChangeTheme(value));
          //     },
          //   ),
          // ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Select a Theme',
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    onPressed: () => context
                        .read<ThemeBloc>()
                        .add(ChangeTheme(isDark: false)),
                    child: Text('Light'),
                  ),
                  const SizedBox(width: 10),
                  FilledButton(
                    onPressed: () => context
                        .read<ThemeBloc>()
                        .add(ChangeTheme(isDark: true)),
                    child: Text('Dark'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
