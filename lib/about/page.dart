import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../l10n/app_localizations.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  String aboutContent(AppLocalizations loc) =>
      """
    <h1>${loc.aboutHeading}</h1>
    <p>${loc.aboutBody}</p>
    <h2>${loc.aboutProgrammerTranslatorHeading}</h2>
     <p>${loc.aboutProgrammerTranslatorName}</p>
  """;

  Map<String, Style> htmlStyles(BuildContext context) => {
    "h1": Style(
      color: Theme.of(context).colorScheme.primary,
      fontSize: FontSize(20.0),
      fontWeight: FontWeight.bold,
      margin: Margins.symmetric(vertical: 10.0),
    ),
    "h2": Style(
      color: Theme.of(context).colorScheme.primary,
      fontSize: FontSize(18.0),
      fontWeight: FontWeight.bold,
      margin: Margins.symmetric(vertical: 10.0),
    ),
    "a": Style(
      color: Theme.of(context).colorScheme.secondary,
      textDecoration: TextDecoration.underline,
    ),
    "ul": Style(margin: Margins.symmetric(vertical: 5.0)),
    "li": Style(
      fontSize: FontSize(16.0),
      margin: Margins.symmetric(vertical: 2.0),
      color: Theme.of(context).colorScheme.onSurface,
    ),
    "p": Style(
      color: Theme.of(context).colorScheme.onSurface,
      fontSize: FontSize(16.0),
      fontWeight: FontWeight.normal,
      margin: Margins.symmetric(vertical: 10.0),
    ),
  };

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
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
                Theme.of(context).colorScheme.surface,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          loc.aboutTitle,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Html(data: aboutContent(loc), style: htmlStyles(context)),
          ),
        ),
      ),
    );
  }
}
