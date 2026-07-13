// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Jude';

  @override
  String get aboutTitle => 'About';

  @override
  String get aboutHeading => 'About';

  @override
  String get aboutBody =>
      'This is an independent translation of the letter of Jude. It was translated from Latin using the text of the Nova Vulgata, while comparing it with other respected translations.';

  @override
  String get aboutProgrammerTranslatorHeading => 'Programmer and Translator';

  @override
  String get aboutProgrammerTranslatorName =>
      'Ian K Armstrong, B.Th. (U.N.I.S.A)';

  @override
  String get drawerIndex => 'Index';

  @override
  String get drawerBookmarks => 'Bookmarks';

  @override
  String get drawerHighlights => 'Highlights';

  @override
  String get drawerSearch => 'Search';

  @override
  String get drawerFonts => 'Fonts';

  @override
  String get drawerTheme => 'Theme';

  @override
  String get drawerAbout => 'About';

  @override
  String get drawerShare => 'Share';

  @override
  String get searchTitle => 'Search';

  @override
  String get searchPlaceholder => 'Search...';

  @override
  String get searchEnterTextPrompt => 'Please enter text to search.';

  @override
  String get searchNoResults => 'No search results.';

  @override
  String get mainBookmarkVerse => 'Bookmark verse';

  @override
  String get mainBookmarkAdded => 'Bookmark added';

  @override
  String get mainBookmarkAlreadyExists => 'Bookmark already exists';

  @override
  String get mainHighlightVerse => 'Highlight verse';

  @override
  String get mainHighlightAdded => 'Highlight added';

  @override
  String get mainHighlightAlreadyExists => 'Highlight already exists';

  @override
  String get mainCopyVerse => 'Copy verse';

  @override
  String get mainTextCopied => 'Text copied';

  @override
  String get cacheGoToEntry => 'Go to entry';

  @override
  String get cacheDeleteEntry => 'Delete entry';

  @override
  String get cacheDeleteEntryPrompt => 'Delete this entry?';

  @override
  String get cacheEntryDeleted => 'Entry deleted!';

  @override
  String get cacheDeleteAllEntriesPrompt => 'Delete all entries?';

  @override
  String get cacheAllEntriesDeleted => 'All entries deleted';

  @override
  String get commonYes => 'Yes';

  @override
  String get commonNo => 'No';

  @override
  String get commonOk => 'OK';

  @override
  String get commonNormal => 'Normal';

  @override
  String get commonItalic => 'Italic';

  @override
  String get themeTitle => 'Theme switcher';

  @override
  String get themeBlueDelight => 'Blue delight';

  @override
  String get themeAquaBlue => 'Aqua blue';

  @override
  String get themePinkSakura => 'Pink sakura';

  @override
  String get themeGreenForest => 'Green forest';

  @override
  String get themeSepia => 'Sepia';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get fontsSamplePsalm23 => 'The Lord is my shepherd, I lack nothing.';

  @override
  String get fontsSampleShepherd => 'The Lord is my shepherd.';

  @override
  String fontsSizeTitle(String size) {
    return 'Font size $size';
  }

  @override
  String get fontsAdjustSizeTitle => 'Adjust font size';
}
