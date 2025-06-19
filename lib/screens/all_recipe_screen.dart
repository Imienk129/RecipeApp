import 'package:flutter/material.dart';
import 'package:recipe_app/constants/constant_function.dart';
import 'package:recipe_app/constants/favorite_list.dart';

class AllRecipeScreen extends StatefulWidget {
  const AllRecipeScreen({super.key});

  @override
  State<AllRecipeScreen> createState() => _AllRecipeScreenState();
}

class _AllRecipeScreenState extends State<AllRecipeScreen> {
  late Future<List<Map<String, dynamic>>> _recipesFuture;

  @override
  void initState() {
    super.initState();
    _recipesFuture = fetchAllRecipes();
  }

  Future<List<Map<String, dynamic>>> fetchAllRecipes() async {
    final List<Map<String, dynamic>> result = [];

    final chicken = await ConstantFunction.getResponse('chicken');
    final beef = await ConstantFunction.getResponse('beef');
    final fish = await ConstantFunction.getResponse('fish');
    final burger = await ConstantFunction.getResponse('burger');

    result.addAll(chicken);
    result.addAll(beef);
    result.addAll(fish);
    result.addAll(burger);

    return result;
  }

  void toggleFavorite(Map<String, dynamic> item) {
    setState(() {
      if (favoriteList.contains(item)) {
        favoriteList.remove(item);
      } else {
        favoriteList.add(item);
      }
    });
  }

  bool isFavorited(Map<String, dynamic> item) {
    return favoriteList.contains(item);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Semua Resep')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _recipesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Data tidak ditemukan.'));
          }

          final data = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.56,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 3,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image.network(
                        item['image'],
                        height: w * 0.23,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 3,
                      ),
                      child: Text(
                        item['label'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        "${item['calories'].toStringAsFixed(0)} cal",
                        style: const TextStyle(fontSize: 9, color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        "${item['totalTime']} min",
                        style: const TextStyle(fontSize: 9, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4, bottom: 4),
                        child: InkWell(
                          onTap: () => toggleFavorite(item),
                          child: Icon(
                            isFavorited(item)
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: const Color.fromARGB(255, 248, 142, 43),
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
