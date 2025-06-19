import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xff2563EB), // Blue
      unselectedItemColor: const Color(0xff9CA3AF), // Gray
      selectedFontSize: 12,
      unselectedFontSize: 12,
      iconSize: 24,
      showUnselectedLabels: true,
      elevation: 8,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.monetization_on_outlined),
          label: 'Coins',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.groups),
          label: 'Executives',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart),
          label: 'Reports',
          
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
