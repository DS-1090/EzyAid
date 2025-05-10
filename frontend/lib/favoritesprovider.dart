import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  List<String> _favorites = [];

  List<String> get favorites => _favorites;

  FavoritesProvider() {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favorites = prefs.getStringList('favorite_schemes') ?? [];
    notifyListeners();
  }

  Future<void> addFavorite(String scheme) async {
    if (!_favorites.contains(scheme)) {
      _favorites.add(scheme);
      await _save();
    }
  }

  Future<void> removeFavorite(String scheme) async {
    _favorites.remove(scheme);
    await _save();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorite_schemes', _favorites);
    notifyListeners();
  }

  bool isFavorite(String scheme) => _favorites.contains(scheme);
}
