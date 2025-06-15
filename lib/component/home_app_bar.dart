import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Text(
          "Apa yang akan kamu\nmasak hari ini?",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: w * .06,
            height: 1,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
