import 'package:bottom_navigation_indicator/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';

class FirstExample extends StatefulWidget {
  const FirstExample({super.key});

  @override
  State<FirstExample> createState() => _FirstExampleState();
}

class _FirstExampleState extends State<FirstExample> {
  final _items = _ExampleFeatures();
  final _selectedColor = Colors.blue;
  final _unselectedColor = Colors.white;
  final _bnBackColor = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(
          _items._bottomBarTitle.length,
          _items._bottomBarTitle,
          _items._bottomIcons,
          _selectedColor,
          _unselectedColor,
          _bnBackColor,
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
        child: _ExampleCard(
          title: "Home",
          color: LinearGradient(colors: [
            Color(0xff0f0c29),
            Color(0xff302b63),
            Color(0xff24243e),
          ]),
        ),
      ),
    ),
    const Scaffold(
      body: Center(
        child: _ExampleCard(
          title: "Categories",
          color: LinearGradient(colors: [Colors.red, Colors.black]),
        ),
      ),
    ),
    const Scaffold(
      body: Center(
        child: _ExampleCard(
          title: "Market",
          color: LinearGradient(colors: [Colors.red, Colors.black]),
        ),
      ),
    ),
    const Scaffold(
      body: Center(
        child: _ExampleCard(
          title: "Profile",
          color: LinearGradient(colors: [Colors.red, Colors.black]),
        ),
      ),
    ),
  ];
}

class _ExampleCard extends StatelessWidget {
  const _ExampleCard({String? title, LinearGradient? color})
      : _title = title,
        _color = color;

  final String? _title;
  final LinearGradient? _color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Container(
        decoration: BoxDecoration(
            gradient: _color, borderRadius: BorderRadius.circular(25)),
        child: Center(
            child: Text(
          _title ?? "",
          style: Theme.of(context).textTheme.headline3,
        )),
      ),
    );
  }
}
