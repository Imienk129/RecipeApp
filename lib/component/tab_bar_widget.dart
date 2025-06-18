import 'package:flutter/material.dart';
import 'package:recipe_app/constants/constant_function.dart';
import 'package:recipe_app/constants/favorite_list.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            height: h * .05,
            child: TabBar(
              unselectedLabelColor: Colors.red,
              labelColor: Colors.white,
              dividerColor: Colors.white,
              indicator: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              labelPadding: EdgeInsets.symmetric(horizontal: w * .012),
              tabs: const [
                TabItem(title: 'Ayam'),
                TabItem(title: 'Daging'),
                TabItem(title: 'Ikan'),
                TabItem(title: 'Burger'),
              ],
            ),
          ),
          SizedBox(height: h * .02),
          SizedBox(
            height: h * 0.4, // tambahkan tinggi agar muat tombol favorite
            child: const TabBarView(
              children: [
                HomeTabBarView(recipe: 'Chicken'),
                HomeTabBarView(recipe: 'Beef'),
                HomeTabBarView(recipe: 'Fish'),
                HomeTabBarView(recipe: 'Burger'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  final String title;
  const TabItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(child: Text(title, style: const TextStyle(fontSize: 10))),
      ),
    );
  }
}

class HomeTabBarView extends StatefulWidget {
  final String recipe;
  const HomeTabBarView({super.key, required this.recipe});

  @override
  State<HomeTabBarView> createState() => _HomeTabBarViewState();
}

class _HomeTabBarViewState extends State<HomeTabBarView> {
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
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: ConstantFunction.getResponse(widget.recipe),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Terjadi kesalahan saat memuat data'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Tidak ada data ditemukan'));
        }

        final data = snapshot.data!;
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 10),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final snap = data[index];
            return Container(
              width: w * 0.6,
              margin: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        width: w,
                        height: h * 0.18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(snap['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorited(snap)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () => toggleFavorite(snap),
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.01),
                  Text(
                    snap['label'],
                    style: TextStyle(
                      fontSize: w * 0.035,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: h * 0.005),
                  Text(
                    "Kalori: ${snap['calories'].toStringAsFixed(0)} • Waktu: ${snap['totalTime']} menit",
                    style: TextStyle(fontSize: w * 0.03, color: Colors.grey),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 10),
        );
      },
    );
  }
}
