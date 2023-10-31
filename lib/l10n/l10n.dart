import 'package:flutter/material.dart';

class L10n {
  static final all = [
    Locale('en'),
    Locale('pl'),
    Locale('zh'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'en':
        return '🇺🇸';
      case 'pl':
        return '🇵🇱';
      case 'zh':
        return '🇨🇳';
      default:
        return '🇺🇸';
    }
  }
}
