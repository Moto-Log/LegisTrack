import 'package:flutter/material.dart';

class AnimatedBottomNavigationBar extends StatelessWidget {
  final List<IconData> icons;
  final int activeIndex;
  final Function(int) onTap;

  AnimatedBottomNavigationBar({
    required this.icons,
    required this.activeIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: activeIndex,
      onTap: onTap,
      items: icons.map((icon) => BottomNavigationBarItem(icon: Icon(icon))).toList(),
    );
  }
}