

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontSizeProvider with ChangeNotifier {
  double _fontSize = 16.0; // Default font size
  double get fontSize => _fontSize;

  FontSizeProvider() {
    _loadFontSize(); // Load saved size at startup
  }

  void _loadFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getDouble('fontSize') ?? 16.0;
    notifyListeners();
  }

  void increaseFontSize() async {
    if (_fontSize < 30) {
      _fontSize += 2;
      notifyListeners();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setDouble('fontSize', _fontSize);
    }
  }

  void decreaseFontSize() async {
    if (_fontSize > 12) {
      _fontSize -= 2;
      notifyListeners();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setDouble('fontSize', _fontSize);
    }
  }

  void resetFontSize() async {
    _fontSize = 16.0;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('fontSize');
  }
}
