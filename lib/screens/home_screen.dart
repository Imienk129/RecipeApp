import 'package:flutter/material.dart';
import 'package:recipe_app/component/home_app_bar.dart';
import 'package:recipe_app/component/tab_bar_widget.dart';
import 'package:recipe_app/constants/images_path.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(w * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeAppBar(),
            const SizedBox(height: 10),

            // Gambar Explore
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                ImagesPath.explore,
                height: h * 0.25,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Kategori",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text("Lihat semua", style: TextStyle(color: Colors.red)),
              ],
            ),

            const SizedBox(height: 10),

            const TabBarWidget(),
          ],
        ),
      ),
    );
  }
}
