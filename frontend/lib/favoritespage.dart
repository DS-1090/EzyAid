import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'fontprovider.dart';
class FavoritesPage extends StatefulWidget {
  final List<String> favs;
  const FavoritesPage({super.key, required this.favs});
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}
class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final fontSize = Provider.of<FontSizeProvider>(context).fontSize;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite Schemes",
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize + 2, // Slightly larger for title
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.lightBlue.shade700,
      ),
      body: widget.favs.isEmpty
          ? Center(
        child: Text(
          "No favorites yet 🥲",
          style: TextStyle(fontSize: fontSize),
        ),
      )
          : ListView.builder(
        itemCount: widget.favs.length,
        itemBuilder: (context, index) {
          final schemeName = widget.favs[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Card(
              color: Colors.lightBlue.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 6,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  schemeName,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}