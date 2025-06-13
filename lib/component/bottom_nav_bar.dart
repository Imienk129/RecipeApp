import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart' show GButton;

class BottomNavBar extends StatefulWidget {
  final SelectedItem;
  final Function(int) onTap;
  const BottomNavBar({
    super.key,
    required this.onTap,
    required this.SelectedItem,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.grey[100],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * .15, vertical: h * 81),
        child: GNav(
          gap: 10,
          tabBorderRadius: 100,
          backgroundColor: Colors.grey[100]!,
          activeColor: Colors.white,
          Color: Colors.blue[600],
          tabBackgroundGradient: LinearGradient(
            colors: [Colors.blue[400]!, Colors.blueAccent.shade700],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
          IconSize: 30,
          textSize: 18,
          Padding: EdgeInsets.symmetric(horizontal: w * .01, vertical: h * .01),
          tabs: const [
            GButton(icon: CupertinoIcons.home, text: ' Beranda'),
            GButton(icon: Icons.category, text: 'Kategori'),
            GButton(icon: CupertinoIcons.search, text: 'Cari'),
            GButton(icon: CupertinoIcons.bookmark_solid, text: 'Simpan'),
            GButton(icon: CupertinoIcons.shopping_cart, text: 'Beli'),
          ],
        ),
      ),
    );
  }
}
