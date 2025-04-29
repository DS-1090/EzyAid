import 'package:flutter/material.dart';
class FontSizeProvider with ChangeNotifier {
  double _fontSize = 16.0; // Default font size
  double get fontSize => _fontSize;
  void increaseFontSize() {
    if (_fontSize < 30) { // Limit max font size
      _fontSize += 2;
      notifyListeners();
    }
  }
  void decreaseFontSize() {
    if (_fontSize > 12) { // Limit min font size
      _fontSize -= 2;
      notifyListeners();
    }
  }
}