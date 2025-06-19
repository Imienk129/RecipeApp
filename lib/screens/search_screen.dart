import 'package:flutter/material.dart';
import 'package:recipe_app/constants/constant_function.dart';
import 'package:recipe_app/screens/recipe_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  Future<List<Map<String, dynamic>>>? _searchResults;

  void _onSearch() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _searchResults = ConstantFunction.getResponse(_controller.text.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(w * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: h * 0.06),
              child: Container(
                height: h * .086,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _controller,
                  onSubmitted: (_) => _onSearch(),
                  style: TextStyle(fontSize: w * .04, color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Masakan apa yang anda pikirkan..?",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: w * .03),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: const Color.fromARGB(255, 248, 142, 43),
                        size: w * .07,
                      ),
                      onPressed: _onSearch,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            if (_searchResults == null)
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.search,
                      size: h * 0.20,
                      color: const Color.fromARGB(255, 248, 142, 43),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Cari Resep",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              )
            else
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _searchResults,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Terjadi kesalahan"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Tidak ditemukan hasil"));
                  }

                  final data = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RecipeDetailScreen(recipe: item),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
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
                              "Kalori: ${item['calories'].toStringAsFixed(0)} • Waktu: ${item['totalTime']} min",
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
