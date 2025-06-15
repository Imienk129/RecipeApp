import 'package:flutter/material.dart';
import 'package:recipe_app/component/home_app_bar.dart';
import 'package:recipe_app/component/text_field_widget.dart';
import 'package:recipe_app/constants/images_path.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeAppBar(),
                SizedBox(height: h * 0.022),
                TextFieldWidget(),
                SizedBox(height: h * 0.022),
                Container(
                  height: h * .25,
                  width: w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImagesPath.explore),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox(height: h * .023),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Kategori",
                      style: TextStyle(
                        fontSize: w * .045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('Lihat semua'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
