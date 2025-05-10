

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'fontprovider.dart';
import 'favoritesprovider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favs = context.watch<FavoritesProvider>().favorites;
    final fontSize = context.watch<FontSizeProvider>().fontSize;

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Schemes", style: TextStyle(fontSize: fontSize + 2,  color: Colors.white, )),
        backgroundColor: Colors.lightBlue.shade600,
          iconTheme: const IconThemeData(color: Colors.white)
      ),
      body: favs.isEmpty
          ? Center(child: Text("No favorites yet :(", style: TextStyle(fontSize: fontSize)))
          : ListView.builder(
        itemCount: favs.length,
        itemBuilder: (context, index) {
          final schemeName = favs[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Card(
              elevation: 4,
              color: Colors.lightBlue.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                title: Text(
                  schemeName,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.redAccent,
                  tooltip: 'Remove from Favorites',
                  onPressed: () => context.read<FavoritesProvider>().removeFavorite(schemeName),
                ),
              ),
            ),
          )
          ;
        },
      ),
    );
  }
}
