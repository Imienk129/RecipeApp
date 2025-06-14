import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.onTap,
    required this.selectedIndex,
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
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.05,
          vertical: h * 0.015,
        ),
        child: GNav(
          gap: 10,
          tabBorderRadius: 100,
          backgroundColor: Colors.grey[100]!,
          activeColor: Colors.white,
          color: Colors.blue[600],
          tabBackgroundGradient: LinearGradient(
            colors: [Colors.blue[400]!, Colors.blueAccent.shade700],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
          iconSize: 24,
          textSize: 16,
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.02,
            vertical: h * 0.015,
          ),
          tabs: const [
            GButton(icon: CupertinoIcons.home, text: "Beranda"),
            GButton(icon: Icons.category, text: "Kategori"),
            GButton(icon: CupertinoIcons.search, text: "Cari"),
            GButton(icon: CupertinoIcons.bookmark_solid, text: "Simpan"),
            GButton(icon: CupertinoIcons.shopping_cart, text: "Beli"),
          ],
          selectedIndex: widget.selectedIndex,
          onTabChange: widget.onTap,
        ),
      ),
    );
  }
}
