import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Map<String, dynamic>> favorites;

  const FavoriteScreen({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorit")),
      body:
          favorites.isEmpty
              ? const Center(child: Text("Belum ada item favorit"))
              : ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final item = favorites[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(
                        item['image'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item['label']),
                      subtitle: Text(
                        "Calories: ${item['calories'].toStringAsFixed(0)} | Time: ${item['totalTime']} min",
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
