
import 'package:flutter/material.dart';
import 'package:frontend/langprovider.dart';
import 'package:provider/provider.dart';
import 'welcomepage.dart';
import 'fontprovider.dart';
import 'favoritesprovider.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FavoritesProvider()),

      ChangeNotifierProvider(create: (_) => LanguageProvider()),

      ChangeNotifierProvider(create: (context) => FontSizeProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => const WelcomePage(),
      },
    ),
  ),
);