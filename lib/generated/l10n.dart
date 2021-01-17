// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Test`
  String get appName {
    return Intl.message(
      'Test',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `The current theme is {mode} mode`
  String themeMode(Object mode) {
    return Intl.message(
      'The current theme is $mode mode',
      name: 'themeMode',
      desc: '',
      args: [mode],
    );
  }

  /// `darkColor`
  String get darkColor {
    return Intl.message(
      'darkColor',
      name: 'darkColor',
      desc: '',
      args: [],
    );
  }

  /// `lightColor`
  String get lightColor {
    return Intl.message(
      'lightColor',
      name: 'lightColor',
      desc: '',
      args: [],
    );
  }

  /// `Switch language to Chinese`
  String get changeLanguage {
    return Intl.message(
      'Switch language to Chinese',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `City management`
  String get cityManagement {
    return Intl.message(
      'City management',
      name: 'cityManagement',
      desc: '',
      args: [],
    );
  }

  /// `Current City`
  String get currentCity {
    return Intl.message(
      'Current City',
      name: 'currentCity',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'HK'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}