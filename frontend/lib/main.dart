import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'welcomepage.dart';
import 'fontprovider.dart';

void main() => runApp(

    MultiProvider(
    providers: [
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