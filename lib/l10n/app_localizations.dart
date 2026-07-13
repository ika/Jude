import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Jude'**
  String get appTitle;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutTitle;

  /// No description provided for @aboutHeading.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutHeading;

  /// No description provided for @aboutBody.
  ///
  /// In en, this message translates to:
  /// **'This is an independent translation of the letter of Jude. It was translated from Latin using the text of the Nova Vulgata, while comparing it with other respected translations.'**
  String get aboutBody;

  /// No description provided for @aboutProgrammerTranslatorHeading.
  ///
  /// In en, this message translates to:
  /// **'Programmer and Translator'**
  String get aboutProgrammerTranslatorHeading;

  /// No description provided for @aboutProgrammerTranslatorName.
  ///
  /// In en, this message translates to:
  /// **'Ian K Armstrong, B.Th. (U.N.I.S.A)'**
  String get aboutProgrammerTranslatorName;

  /// No description provided for @drawerIndex.
  ///
  /// In en, this message translates to:
  /// **'Index'**
  String get drawerIndex;

  /// No description provided for @drawerBookmarks.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get drawerBookmarks;

  /// No description provided for @drawerHighlights.
  ///
  /// In en, this message translates to:
  /// **'Highlights'**
  String get drawerHighlights;

  /// No description provided for @drawerSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get drawerSearch;

  /// No description provided for @drawerFonts.
  ///
  /// In en, this message translates to:
  /// **'Fonts'**
  String get drawerFonts;

  /// No description provided for @drawerTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get drawerTheme;

  /// No description provided for @drawerAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get drawerAbout;

  /// No description provided for @drawerShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get drawerShare;

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTitle;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get searchPlaceholder;

  /// No description provided for @searchEnterTextPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please enter text to search.'**
  String get searchEnterTextPrompt;

  /// No description provided for @searchNoResults.
  ///
  /// In en, this message translates to:
  /// **'No search results.'**
  String get searchNoResults;

  /// No description provided for @mainBookmarkVerse.
  ///
  /// In en, this message translates to:
  /// **'Bookmark verse'**
  String get mainBookmarkVerse;

  /// No description provided for @mainBookmarkAdded.
  ///
  /// In en, this message translates to:
  /// **'Bookmark added'**
  String get mainBookmarkAdded;

  /// No description provided for @mainBookmarkAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'Bookmark already exists'**
  String get mainBookmarkAlreadyExists;

  /// No description provided for @mainHighlightVerse.
  ///
  /// In en, this message translates to:
  /// **'Highlight verse'**
  String get mainHighlightVerse;

  /// No description provided for @mainHighlightAdded.
  ///
  /// In en, this message translates to:
  /// **'Highlight added'**
  String get mainHighlightAdded;

  /// No description provided for @mainHighlightAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'Highlight already exists'**
  String get mainHighlightAlreadyExists;

  /// No description provided for @mainCopyVerse.
  ///
  /// In en, this message translates to:
  /// **'Copy verse'**
  String get mainCopyVerse;

  /// No description provided for @mainTextCopied.
  ///
  /// In en, this message translates to:
  /// **'Text copied'**
  String get mainTextCopied;

  /// No description provided for @cacheGoToEntry.
  ///
  /// In en, this message translates to:
  /// **'Go to entry'**
  String get cacheGoToEntry;

  /// No description provided for @cacheDeleteEntry.
  ///
  /// In en, this message translates to:
  /// **'Delete entry'**
  String get cacheDeleteEntry;

  /// No description provided for @cacheDeleteEntryPrompt.
  ///
  /// In en, this message translates to:
  /// **'Delete this entry?'**
  String get cacheDeleteEntryPrompt;

  /// No description provided for @cacheEntryDeleted.
  ///
  /// In en, this message translates to:
  /// **'Entry deleted!'**
  String get cacheEntryDeleted;

  /// No description provided for @cacheDeleteAllEntriesPrompt.
  ///
  /// In en, this message translates to:
  /// **'Delete all entries?'**
  String get cacheDeleteAllEntriesPrompt;

  /// No description provided for @cacheAllEntriesDeleted.
  ///
  /// In en, this message translates to:
  /// **'All entries deleted'**
  String get cacheAllEntriesDeleted;

  /// No description provided for @commonYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get commonYes;

  /// No description provided for @commonNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get commonNo;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get commonNormal;

  /// No description provided for @commonItalic.
  ///
  /// In en, this message translates to:
  /// **'Italic'**
  String get commonItalic;

  /// No description provided for @themeTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme switcher'**
  String get themeTitle;

  /// No description provided for @themeBlueDelight.
  ///
  /// In en, this message translates to:
  /// **'Blue delight'**
  String get themeBlueDelight;

  /// No description provided for @themeAquaBlue.
  ///
  /// In en, this message translates to:
  /// **'Aqua blue'**
  String get themeAquaBlue;

  /// No description provided for @themePinkSakura.
  ///
  /// In en, this message translates to:
  /// **'Pink sakura'**
  String get themePinkSakura;

  /// No description provided for @themeGreenForest.
  ///
  /// In en, this message translates to:
  /// **'Green forest'**
  String get themeGreenForest;

  /// No description provided for @themeSepia.
  ///
  /// In en, this message translates to:
  /// **'Sepia'**
  String get themeSepia;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @fontsSamplePsalm23.
  ///
  /// In en, this message translates to:
  /// **'The Lord is my shepherd, I lack nothing.'**
  String get fontsSamplePsalm23;

  /// No description provided for @fontsSampleShepherd.
  ///
  /// In en, this message translates to:
  /// **'The Lord is my shepherd.'**
  String get fontsSampleShepherd;

  /// No description provided for @fontsSizeTitle.
  ///
  /// In en, this message translates to:
  /// **'Font size {size}'**
  String fontsSizeTitle(String size);

  /// No description provided for @fontsAdjustSizeTitle.
  ///
  /// In en, this message translates to:
  /// **'Adjust font size'**
  String get fontsAdjustSizeTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
