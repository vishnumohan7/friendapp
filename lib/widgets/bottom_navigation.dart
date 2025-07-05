import 'package:feme/routes/routes.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.customerDashboard,
            );
            break;
          case 1:
            Navigator.pushReplacementNamed(context, AppRoutes.coins);
            break;
          case 2:
            // If you have a specific executives route, replace this
            Navigator.pushReplacementNamed(context, AppRoutes.executives);
            break;
          case 3:
            // If you have a reports route, replace this
            Navigator.pushReplacementNamed(context, AppRoutes.reports);
            break;
          case 4:
            // If you have a profile route, replace this
            Navigator.pushReplacementNamed(context, AppRoutes.profile);
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xff2563EB), // Blue
      unselectedItemColor: const Color(0xff9CA3AF), // Gray
      selectedFontSize: 12,
      unselectedFontSize: 12,
      iconSize: 24,
      showUnselectedLabels: true,
      elevation: 8,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
        BottomNavigationBarItem(
          icon: Icon(Icons.monetization_on_outlined),
          label: 'Coins',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Executives'),
        BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Reports'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
