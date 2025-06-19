import 'package:flutter/material.dart';
import 'package:recipe_app/constants/favorite_list.dart';
import 'package:recipe_app/screens/recipe_detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  void removeFromFavorites(int index) {
    setState(() {
      favoriteList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorit Saya")),
      body:
          favoriteList.isEmpty
              ? const Center(child: Text("Belum ada makanan favorit."))
              : ListView.builder(
                itemCount: favoriteList.length,
                itemBuilder: (context, index) {
                  final item = favoriteList[index];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RecipeDetailScreen(recipe: item),
                        ),
                      );
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item['image'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(item['label']),
                    subtitle: Text(
                      "Kalori: ${item['calories'].toStringAsFixed(0)} • Waktu: ${item['totalTime']} menit",
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.bookmark_remove,
                        color: Colors.red,
                      ),
                      onPressed: () => removeFromFavorites(index),
                    ),
                  );
                },
              ),
    );
  }
}
