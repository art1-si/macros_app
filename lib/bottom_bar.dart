import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final List<BottomNavBarItem> items;
  final ValueChanged<int> onTap;
  final int currentIndex;
  final Color backgroundColor;
  final double iconSize;
  final Color selectedItemColor;
  final Color unselectedItemColor;

  const BottomNavBar({
    Key key,
    this.items,
    this.onTap,
    this.currentIndex,
    this.backgroundColor,
    this.iconSize,
    this.selectedItemColor,
    this.unselectedItemColor,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BottomNavBarItem {
  const BottomNavBarItem({
    this.icon,
    this.title,
    this.backgroundColor,
  });

  final Widget icon;
  final Widget title;
  final Color backgroundColor;
}
