import 'package:flutter/material.dart';

class KPSizes {
  static const double defaultSizeDragContainerHeight = 5;
  static const double defaultSizeLearningExtContainer = 20;
  static const double defaultSizeLearningModeBar = 32;
  static const double defaultResultWordListOnTest = 40;
  static const double defaultSizeFiltersList = 44;
  static const double defaultSizeSearchBarIcons = 50;
  static const double defaultJishoAPIContainer = 52;
  static const double defaultSizeActionButton = 60;
  static const double defaultSizeWordItemOnResultTest = 60;
  static const double actionButtonsWordDetail = 55;
  static const double appBarHeight = 80;
  static const double listStudyHeight = 85;
  static const double defaultSizeDragContainerWidth = 90;
  static const double customButtonHeight = 100;
  static const double defaultSizeWinRateBarChart = 110;
  static const double customButtonWidth = 110;
  static const double defaultJishoGIF = 124;
  static const double defaultSizeWinRateChart = 128;
  static const double appIcon = 150;
  static const double maxHeightForLastSeenDates = 256;
  static const double maxHeightValidationCircle = 256;

  static const double minimumHeight = 750;

  static const int numberOfWordInTest = 30;
  static const int numberOfPredictedWords = 20;
}

class LazyLoadingLimits {
  static const int folderList = 12;
  static const int kanList = 12;
  static const int wordBadgeList = 100;
  static const int wordTileList = 40;
  static const int grammarPointList = 20;
  static const int testHistory = 20;
  static const int wordHistory = 20;
}

class KPChartSize {
  static const double small = 8;
  static const double medium = 12;
  static const double large = 32;
}

class KPMargins {
  static const double margin2 = 2;
  static const double margin4 = 4;
  static const double margin8 = 8;
  static const double margin10 = 10;
  static const double margin12 = 12;
  static const double margin16 = 16;
  static const double margin18 = 18;
  static const double margin24 = 24;
  static const double margin26 = 26;
  static const double margin32 = 32;
  static const double margin48 = 48;
  static const double margin64 = 64;
}

class KPFontSizes {
  static const double fontSize12 = 12;
  static const double fontSize14 = 14;
  static const double fontSize16 = 16;
  static const double fontSize18 = 18;
  static const double fontSize20 = 20;
  static const double fontSize24 = 24;
  static const double fontSize26 = 26;
  static const double fontSize32 = 32;
  static const double fontSize48 = 48;
  static const double fontSize64 = 64;
}

class KPRadius {
  static const double radius4 = 4;
  static const double radius8 = 8;
  static const double radius16 = 16;
  static const double radius24 = 24;
  static const double radius32 = 32;
}

class KPAnimations {
  static const double dxCardInfo = 2;

  static const int wordItemDuration = 25;
  static const int ms200 = 200;
  static const int ms300 = 300;
  static const int ms400 = 400;
}

class KPColors {
  static const Color secondaryDarkerColor = Color(0xFFD32F2F);
  static const Color secondaryColor = Color(0xFFE57373);

  static final Color primaryDark = Colors.grey.shade900;
  static final Color midGrey = Colors.grey.shade500;
  static const Color accentLight = Colors.black;
  static final Color subtleLight = Colors.grey.shade600;
  static final Color subtleDark = Colors.grey.shade600;

  static const Color darkRed = Color(0xFFD32F2F);
  static const Color darkMidRed = Color(0xFFC62828);
  static const Color midRed = Color(0xFFB71C1C);
  static const Color lightMidRed = Color(0xFFFF7043);
  static const Color darkOrange = Color(0xFFF57C00);
  static const Color darkMidOrange = Color(0xFFEF6C00);
  static const Color darkAmber = Color(0xFFFFB300);
  static const Color darkMidAmber = Color(0xFFFFA000);
  static const Color darkOlive = Color(0xFF827717);
  static const Color darkGreen = Color(0xFF388E3C);
}

class LanguageObj {
  final String code;
  final String name;

  const LanguageObj(this.code, this.name);
}

class CountryLanguages {
  static const Map<String, Set<LanguageObj>> countryLanguage = {
    'en': {
      LanguageObj('af', 'Afrikaans'),
      LanguageObj('ar', 'Arabic'),
      LanguageObj('az', 'Azerbaijani'),
      LanguageObj('be', 'Belarusian'),
      LanguageObj('bg', 'Bulgarian'),
      LanguageObj('bs', 'Bosnian'),
      LanguageObj('ca', 'Catalan'),
      LanguageObj('cs', 'Czech'),
      LanguageObj('cy', 'Welsh'),
      LanguageObj('da', 'Danish'),
      LanguageObj('de', 'German'),
      LanguageObj('el', 'Greek'),
      LanguageObj('en', 'English'),
      LanguageObj('es', 'Spanish'),
      LanguageObj('et', 'Estonian'),
      LanguageObj('eu', 'Basque'),
      LanguageObj('fa', 'Persian'),
      LanguageObj('fi', 'Finnish'),
      LanguageObj('fil', 'Filipino'),
      LanguageObj('fr', 'French'),
      LanguageObj('ga', 'Irish'),
      LanguageObj('gl', 'Galician'),
      LanguageObj('he', 'Hebrew'),
      LanguageObj('hi', 'Hindi'),
      LanguageObj('hr', 'Croatian'),
      LanguageObj('hu', 'Hungarian'),
      LanguageObj('hy', 'Armenian'),
      LanguageObj('id', 'Indonesian'),
      LanguageObj('is', 'Icelandic'),
      LanguageObj('it', 'Italian'),
      LanguageObj('ja', 'Japanese'),
      LanguageObj('ka', 'Georgian'),
      LanguageObj('ko', 'Korean'),
      LanguageObj('lt', 'Lithuanian'),
      LanguageObj('lv', 'Latvian'),
      LanguageObj('mg', 'Malagasy'),
      LanguageObj('mi', 'Maori'),
      LanguageObj('mk', 'Macedonian'),
      LanguageObj('mn', 'Mongolian'),
      LanguageObj('ms', 'Malay'),
      LanguageObj('mt', 'Maltese'),
      LanguageObj('ne', 'Nepali'),
      LanguageObj('nl', 'Dutch'),
      LanguageObj('nn', 'Norwegian Nynorsk'),
      LanguageObj('no', 'Norwegian'),
      LanguageObj('om', 'Oromo'),
      LanguageObj('or', 'Oriya'),
      LanguageObj('pa', 'Punjabi'),
      LanguageObj('pl', 'Polish'),
      LanguageObj('pt', 'Portuguese'),
      LanguageObj('ro', 'Romanian'),
      LanguageObj('ru', 'Russian'),
      LanguageObj('sk', 'Slovak'),
      LanguageObj('sl', 'Slovenian'),
      LanguageObj('sq', 'Albanian'),
      LanguageObj('sr', 'Serbian'),
      LanguageObj('sv', 'Swedish'),
      LanguageObj('sw', 'Swahili'),
      LanguageObj('ta', 'Tamil'),
      LanguageObj('te', 'Telugu'),
      LanguageObj('th', 'Thai'),
      LanguageObj('tr', 'Turkish'),
      LanguageObj('uk', 'Ukrainian'),
      LanguageObj('uz', 'Uzbek'),
      LanguageObj('vi', 'Vietnamese'),
      LanguageObj('zh', 'Chinese'),
    },
    'es': {
      LanguageObj('af', 'Afrikáans'),
      LanguageObj('ar', 'Árabe'),
      LanguageObj('az', 'Azerbaiyano'),
      LanguageObj('be', 'Bielorruso'),
      LanguageObj('bg', 'Búlgaro'),
      LanguageObj('bs', 'Bosnio'),
      LanguageObj('ca', 'Catalán'),
      LanguageObj('cs', 'Checo'),
      LanguageObj('cy', 'Galés'),
      LanguageObj('da', 'Danés'),
      LanguageObj('de', 'Alemán'),
      LanguageObj('el', 'Griego'),
      LanguageObj('en', 'Inglés'),
      LanguageObj('es', 'Español'),
      LanguageObj('et', 'Estonio'),
      LanguageObj('eu', 'Vasco'),
      LanguageObj('fa', 'Persa'),
      LanguageObj('fi', 'Finlandés'),
      LanguageObj('fil', 'Filipino'),
      LanguageObj('fr', 'Francés'),
      LanguageObj('ga', 'Irlandés'),
      LanguageObj('gl', 'Gallego'),
      LanguageObj('he', 'Hebreo'),
      LanguageObj('hi', 'Hindi'),
      LanguageObj('hr', 'Croata'),
      LanguageObj('hu', 'Húngaro'),
      LanguageObj('hy', 'Armenio'),
      LanguageObj('id', 'Indonesio'),
      LanguageObj('is', 'Islandés'),
      LanguageObj('it', 'Italiano'),
      LanguageObj('ja', 'Japonés'),
      LanguageObj('ka', 'Georgiano'),
      LanguageObj('ko', 'Coreano'),
      LanguageObj('lt', 'Lituano'),
      LanguageObj('lv', 'Letón'),
      LanguageObj('mg', 'Malgache'),
      LanguageObj('mi', 'Maorí'),
      LanguageObj('mk', 'Macedonio'),
      LanguageObj('mn', 'Mongol'),
      LanguageObj('ms', 'Malayo'),
      LanguageObj('mt', 'Maltés'),
      LanguageObj('ne', 'Nepalí'),
      LanguageObj('nl', 'Holandés'),
      LanguageObj('nn', 'Nynorsk noruego'),
      LanguageObj('no', 'Noruego'),
      LanguageObj('om', 'Oromo'),
      LanguageObj('or', 'Oriya'),
      LanguageObj('pa', 'Panyabí'),
      LanguageObj('pl', 'Polaco'),
      LanguageObj('pt', 'Portugués'),
      LanguageObj('ro', 'Rumano'),
      LanguageObj('ru', 'Ruso'),
      LanguageObj('sk', 'Eslovaco'),
      LanguageObj('sl', 'Esloveno'),
      LanguageObj('sq', 'Albanés'),
      LanguageObj('sr', 'Serbio'),
      LanguageObj('sv', 'Sueco'),
      LanguageObj('sw', 'Swahili'),
      LanguageObj('ta', 'Tamil'),
      LanguageObj('te', 'Telugu'),
      LanguageObj('th', 'Tailandés'),
      LanguageObj('tr', 'Turco'),
      LanguageObj('uk', 'Ucraniano'),
      LanguageObj('uz', 'Uzbeko'),
      LanguageObj('vi', 'Vietnamita'),
      LanguageObj('zh', 'Chino'),
    },
    'de': {
      LanguageObj('af', 'Afrikaans'),
      LanguageObj('ar', 'Arabisch'),
      LanguageObj('az', 'Aserbaidschanisch'),
      LanguageObj('be', 'Belarussisch'),
      LanguageObj('bg', 'Bulgarisch'),
      LanguageObj('bs', 'Bosnisch'),
      LanguageObj('ca', 'Katalanisch'),
      LanguageObj('cs', 'Tschechisch'),
      LanguageObj('cy', 'Walisisch'),
      LanguageObj('da', 'Dänisch'),
      LanguageObj('de', 'Deutsch'),
      LanguageObj('el', 'Griechisch'),
      LanguageObj('en', 'Englisch'),
      LanguageObj('es', 'Spanisch'),
      LanguageObj('et', 'Estnisch'),
      LanguageObj('eu', 'Baskisch'),
      LanguageObj('fa', 'Persisch'),
      LanguageObj('fi', 'Finnisch'),
      LanguageObj('fil', 'Filipino'),
      LanguageObj('fr', 'Französisch'),
      LanguageObj('ga', 'Irisch'),
      LanguageObj('gl', 'Galizisch'),
      LanguageObj('he', 'Hebräisch'),
      LanguageObj('hi', 'Hindi'),
      LanguageObj('hr', 'Kroatisch'),
      LanguageObj('hu', 'Ungarisch'),
      LanguageObj('hy', 'Armenisch'),
      LanguageObj('id', 'Indonesisch'),
      LanguageObj('is', 'Isländisch'),
      LanguageObj('it', 'Italienisch'),
      LanguageObj('ja', 'Japanisch'),
      LanguageObj('ka', 'Georgisch'),
      LanguageObj('ko', 'Koreanisch'),
      LanguageObj('lt', 'Litauisch'),
      LanguageObj('lv', 'Lettisch'),
      LanguageObj('mg', 'Madagassisch'),
      LanguageObj('mi', 'Maori'),
      LanguageObj('mk', 'Mazedonisch'),
      LanguageObj('mn', 'Mongolisch'),
      LanguageObj('ms', 'Malaiisch'),
      LanguageObj('mt', 'Maltesisch'),
      LanguageObj('ne', 'Nepalesisch'),
      LanguageObj('nl', 'Niederländisch'),
      LanguageObj('nn', 'Norwegisch Nynorsk'),
      LanguageObj('no', 'Norwegisch'),
      LanguageObj('om', 'Oromo'),
      LanguageObj('or', 'Oriya'),
      LanguageObj('pa', 'Punjabi'),
      LanguageObj('pl', 'Polnisch'),
      LanguageObj('pt', 'Portugiesisch'),
      LanguageObj('ro', 'Rumänisch'),
      LanguageObj('ru', 'Russisch'),
      LanguageObj('sk', 'Slowakisch'),
      LanguageObj('sl', 'Slowenisch'),
      LanguageObj('sq', 'Albanisch'),
      LanguageObj('sr', 'Serbisch'),
      LanguageObj('sv', 'Schwedisch'),
      LanguageObj('sw', 'Swahili'),
      LanguageObj('ta', 'Tamilisch'),
      LanguageObj('te', 'Telugu'),
      LanguageObj('th', 'Thailändisch'),
      LanguageObj('tr', 'Türkisch'),
      LanguageObj('uk', 'Ukrainisch'),
      LanguageObj('uz', 'Usbekisch'),
      LanguageObj('vi', 'Vietnamesisch'),
      LanguageObj('zh', 'Chinesisch'),
    },
  };
}
