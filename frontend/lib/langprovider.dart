import 'package:flutter/material.dart';
class LanguageProvider extends ChangeNotifier {
  String _currentLanguage = 'te'; 

  String get currentLanguage => _currentLanguage;

  void setLanguage(String lang) {
    _currentLanguage = lang;
    notifyListeners();
  }
}
