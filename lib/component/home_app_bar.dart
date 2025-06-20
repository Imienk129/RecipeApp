import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Text(
          "Apa yang akan anda\nmasak hari ini?",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19,
            height: 1,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
