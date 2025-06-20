import 'dart:async';
import 'package:flutter/material.dart';
import 'package:recipe_app/component/home_app_bar.dart';
import 'package:recipe_app/component/tab_bar_widget.dart';
import 'package:recipe_app/constants/constant_function.dart';
import 'package:recipe_app/screens/all_recipe_screen.dart';
import 'package:recipe_app/screens/recipe_detail_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _currentPage = 0;
  List<Map<String, dynamic>> _images = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
    fetchImages();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void fetchImages() async {
    final chicken = await ConstantFunction.getResponse("chicken");
    final beef = await ConstantFunction.getResponse("beef");
    final fish = await ConstantFunction.getResponse("fish");
    final burger = await ConstantFunction.getResponse("burger");

    final result = [...chicken, ...beef, ...fish, ...burger];

    if (result.isNotEmpty) {
      setState(() {
        _images = result.take(10).toList();
      });
      startAutoScroll();
    }
  }

  void startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients && _images.isNotEmpty) {
        _currentPage++;
        if (_currentPage >= _images.length) _currentPage = 0;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(w * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeAppBar(),
            const SizedBox(height: 10),
            SizedBox(
              height: h * 0.25,
              child:
                  _images.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : PageView.builder(
                        controller: _pageController,
                        itemCount: _images.length,
                        itemBuilder: (context, index) {
                          final item = _images[index];
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
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  item['image'],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Kategori",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AllRecipeScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Lihat semua",
                    style: TextStyle(color: Color.fromARGB(255, 248, 142, 43)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Expanded(child: TabBarWidget()),
          ],
        ),
      ),
    );
  }
}
