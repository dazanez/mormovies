import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      elevation: 1,
      destinations: const [
        NavigationDestination(
            icon: Icon(Icons.home_max_outlined), label: 'Home'),
        NavigationDestination(
            icon: Icon(Icons.label_outline), label: 'Categories'),
        NavigationDestination(
            icon: Icon(Icons.favorite_border_outlined), label: 'Favorites'),
        NavigationDestination(
            icon: Icon(Icons.settings_outlined), label: 'Settings')
      ],
    );
  }
}
