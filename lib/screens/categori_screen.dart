import 'package:flutter/material.dart';
import 'package:recipe_app/constants/constant_function.dart';
import 'package:recipe_app/constants/favorite_list.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  final categories = ["Sarapan", "Makan Siang", "Makan Malam", "Cepat Saji"];
  final apiMap = {
    "Sarapan": "Breakfast",
    "Makan Siang": "Chicken",
    "Makan Malam": "Beef",
    "Cepat Saji": "Burger",
  };

  bool isFavorited(Map<String, dynamic> item) {
    return favoriteList.any((fav) => fav['label'] == item['label']);
  }

  void toggleFavorite(Map<String, dynamic> item) {
    setState(() {
      if (isFavorited(item)) {
        favoriteList.removeWhere((fav) => fav['label'] == item['label']);
      } else {
        favoriteList.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kategori")),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final apiQuery = apiMap[category]!;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 8),

                SizedBox(
                  height: 240,
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: ConstantFunction.getResponse(apiQuery),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("Tidak ada data"));
                      }

                      final data = snapshot.data!;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final item = data[index];
                          return Container(
                            width: 150,
                            margin: const EdgeInsets.only(right: 12),
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      item['image'],
                                      width: double.infinity,
                                      height: 90,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['label'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Calories: ${item['calories'].toStringAsFixed(0)}",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          "Time: ${item['totalTime']} min",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(height: 4),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            icon: Icon(
                                              isFavorited(item)
                                                  ? Icons.bookmark
                                                  : Icons.bookmark_border,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              toggleFavorite(item);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
