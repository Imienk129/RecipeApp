import 'package:flutter/material.dart';
import 'package:recipe_app/constants/favorite_list.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

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
                    leading: Image.network(
                      item['image'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item['label']),
                    subtitle: Text(
                      "Calories: ${item['calories'].toStringAsFixed(0)}, Time: ${item['totalTime']} min",
                    ),
                  );
                },
              ),
    );
  }
}
