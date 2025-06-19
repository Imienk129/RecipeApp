import 'package:flutter/material.dart';
import 'package:recipe_app/constants/constant_function.dart';
import 'package:recipe_app/constants/favorite_list.dart';
import 'package:recipe_app/screens/recipe_detail_screen.dart';

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
                    color: Color.fromARGB(255, 248, 142, 43),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 200,
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
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => RecipeDetailScreen(recipe: item),
                                ),
                              );
                            },
                            child: Container(
                              width: 120,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 2,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(10),
                                    ),
                                    child: Image.network(
                                      item['image'],
                                      height: 70,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['label'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          "Kal: ${item['calories'].toStringAsFixed(0)}",
                                          style: const TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          "Wkt: ${item['totalTime']} m",
                                          style: const TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            icon: Icon(
                                              isFavorited(item)
                                                  ? Icons.bookmark
                                                  : Icons.bookmark_border,
                                              color: const Color.fromARGB(
                                                255,
                                                248,
                                                142,
                                                43,
                                              ),
                                              size: 16,
                                            ),
                                            onPressed:
                                                () => toggleFavorite(item),
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
