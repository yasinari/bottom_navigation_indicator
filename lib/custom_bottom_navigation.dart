import 'package:bottom_navigation_indicator/main.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar(
      int itemCount,
      List<String>? itemTitle,
      List<IconData>? itemIcon,
      Color? selecteditemColor,
      Color? unSelectedItemColor,
      Color? backGroundColor,
      List<Widget>? pages,
      {super.key})
      : _itemCount = itemCount,
        _itemIcon = itemIcon,
        _itemTitle = itemTitle,
        _selectedItemColor = selecteditemColor,
        _unSelectedItemColor = unSelectedItemColor,
        _backGroundColor = backGroundColor,
        _pages = pages;

  // ignore: prefer_typing_uninitialized_variables
  final _itemCount;
  final List<String>? _itemTitle;
  final List<IconData>? _itemIcon;
  final Color? _selectedItemColor;
  final Color? _unSelectedItemColor;
  final Color? _backGroundColor;
  final List<Widget>? _pages;
  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _controller;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this)
      ..repeat(reverse: true);
  }

  void _changeSelectedIndex(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget._pages != null
          ? PageView(
              controller: _pageController,
              children: widget._pages!,
              onPageChanged: (value) => _changeSelectedIndex(value),
            )
          : const Center(
              child: Text("!null data"),
            ),
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Container(
          //shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          color:
              widget._backGroundColor ?? Theme.of(context).colorScheme.surface,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: widget._itemCount,
            itemExtent: MediaQuery.of(context).size.width * 0.25,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      _changeSelectedIndex(index);
                      _pageController.animateToPage(_selectedIndex,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    });
                  },
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    switchInCurve: Curves.easeInExpo,
                    //switchOutCurve: Curves.bounceOut,
                    child: _selectedIndex == index
                        ? _SelectedItem(
                            selectedItemColor:
                                widget._selectedItemColor ?? Colors.grey,
                            selectedIcon:
                                widget._itemIcon?[index] ?? Icons.cancel,
                            itemTitle: widget._itemTitle?[index] ?? "")
                        : _UnSelectedItem(
                            itemIcon: widget._itemIcon?[index] ?? Icons.cancel,
                            unSelectedItemColor:
                                widget._unSelectedItemColor ?? Colors.grey),
                  ));
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class _SelectedItem extends StatelessWidget {
  const _SelectedItem(
      {required this.selectedItemColor,
      required this.selectedIcon,
      required this.itemTitle});
  final Color selectedItemColor;
  final IconData selectedIcon;
  final String itemTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: selectedItemColor,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.003,
          ),
        ),
        Expanded(
            child: Icon(
          selectedIcon,
          color: selectedItemColor,
        )),
        Expanded(
            child: Text(
          itemTitle,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: selectedItemColor, fontWeight: FontWeight.w600),
        ))
      ],
    );
  }
}

class _UnSelectedItem extends StatelessWidget {
  const _UnSelectedItem(
      {required this.itemIcon, required this.unSelectedItemColor});
  final IconData itemIcon;
  final Color unSelectedItemColor;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.height * 0.1,
            child: Container(
                color: Colors.transparent, child: const SizedBox.shrink())),
        Column(
          children: [
            Expanded(
              child: Icon(
                itemIcon,
                color: unSelectedItemColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
