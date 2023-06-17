import 'package:flutter/material.dart';
import 'package:map_app/themes/color_theme.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/tracker.png',
          height: 30.0,
        ),
        const SizedBox(width: 8.0),
        const Text(
          'Travel Tracker',
          style: TextStyle(
            color: ColorTheme.backgroundColor,
            fontWeight: FontWeight.w900,
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}
