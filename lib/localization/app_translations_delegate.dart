import 'dart:async';

import 'package:employee/localization/app_translations.dart';
import 'package:employee/localization/application.dart';
import 'package:flutter/material.dart';

class AppTranslationsDelegate extends LocalizationsDelegate<AppTranslations> {
  final Locale newLocale;

  const AppTranslationsDelegate({required this.newLocale});

  @override
  bool isSupported(Locale locale) {
    return application.supportedLanguagesCodes.contains(locale.languageCode);
  }

  @override
  Future<AppTranslations> load(Locale locale) {
    return AppTranslations.load(newLocale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppTranslations> old) {
    return true;
  }
}
