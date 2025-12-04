import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Future<String> getVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  String aboutContent(String version) => """
    <h1>About</h1>
    <p>This is an independent translation of the letter of Jude. It was translated from Latin using the text of the Nova Vulgata, while comparing it with other respected translations.</p>
    
    <p>Version: $version</p>
    
    <h2>Programmer and Translator</h2>
     <p>Ian K Armstrong, B.Th. (U.N.I.S.A)</p>
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
            textDecoration: TextDecoration.underline),
        "ul": Style(margin: Margins.symmetric(vertical: 5.0)),
        "li": Style(
            fontSize: FontSize(16.0),
            margin: Margins.symmetric(vertical: 2.0),
            color: Theme.of(context).colorScheme.onSurface),
        "p": Style(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: FontSize(16.0),
          fontWeight: FontWeight.normal,
          margin: Margins.symmetric(vertical: 10.0),
        ),
      };

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getVersion(),
      builder: (context, snapshot) {
        final version = snapshot.data ?? 'Unknown';
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
            title: Text(
              'About',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  //color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Html(
                  data: aboutContent(version),
                  style: htmlStyles(context),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
