import 'package:bottom_navigation_indicator/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';

class FirstExample extends StatefulWidget {
  const FirstExample({super.key});

  @override
  State<FirstExample> createState() => _FirstExampleState();
}

class _FirstExampleState extends State<FirstExample> {
  final _items = _ExampleFeatures();
  final _selectedColor = Colors.deepPurple;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(
          _items._bottomBarTitle.length,
          _items._bottomBarTitle,
          _items._bottomIcons,
          _selectedColor,
          Colors.white,
          Colors.transparent,
          _items._pages),
    );
  }
}

class _ExampleFeatures {
  final List<String> _bottomBarTitle = [
    "Home",
    "Categories",
    "Market",
    "Profile",
  ];

  final List<IconData> _bottomIcons = [
    Icons.home,
    Icons.category,
    Icons.shopify_outlined,
    Icons.person
  ];

  final List<Widget> _pages = [
    const Scaffold(
      body: Center(
        child: Text("Home"),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text("Categories"),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text("Market"),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text("Profile"),
      ),
    ),
  ];
}
