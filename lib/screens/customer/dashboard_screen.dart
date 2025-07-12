import 'package:feme/core/textstyles.dart';
import 'package:feme/models/contact_model.dart';
import 'package:feme/routes/routes.dart';
import 'package:feme/screens/video_call/video_call_main.dart';
import 'package:feme/widgets/bottom_navigation.dart';
import 'package:feme/widgets/coin_sumary_card.dart';
import 'package:feme/widgets/contact_card.dart';
import 'package:feme/widgets/contact_list.dart';
import 'package:flutter/material.dart';

class CustomerDashboardScreen extends StatefulWidget {
  const CustomerDashboardScreen({super.key});

  @override
  State<CustomerDashboardScreen> createState() =>
      _CustomerDashboardScreenState();
}

class _CustomerDashboardScreenState extends State<CustomerDashboardScreen> {
  int _selectedIndex = 0;

  // void _onNavItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //     // Navigate or switch view if needed
  //   });
  // }

  List<Contact> get onlineAndFavorite =>
      contactList.where((c) => c.isOnline && c.isFavorite).toList();

  List<Contact> get onlineOnly =>
      contactList.where((c) => c.isOnline && !c.isFavorite).toList();

  List<Contact> get busy =>
      contactList.where((c) => c.status == 'busy').toList();

  List<Contact> get offline =>
      contactList.where((c) => c.status == 'offline').toList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          actions: const [
            Icon(Icons.notifications_none_outlined, color: Color(0xff4B5563)),
            SizedBox(width: 10),
            Icon(Icons.menu, color: Color(0xff4B5563)),
            SizedBox(width: 20),
          ],
          elevation: 4,
          title: const Text(
            'Dashboard',
            style: TextStyle(
              color: Color(0xff111827),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar(currentIndex: 0),
        body: Container(
          color: Color(0xffF9FAFB),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CoinSummaryCard(
                  totalBalance: 2450,
                  available: 2200,
                  pending: 250,
                  onViewTransactions: () {
                    Navigator.pushNamed(context, AppRoutes.transactionSummary);
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text('Executives', style: AppTextStyles.heading3),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.executives);
                      },
                      child: Text('View All', style: AppTextStyles.link),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    children: [
                      if (onlineAndFavorite.isNotEmpty) ...[
                        _buildSectionHeader(
                          label: 'Online + Favourite',
                          isFavorite: true,
                          icon: Icons.star,
                          status: 'online',
                        ),
                        ...onlineAndFavorite.map(
                          (c) => ContactCard(
                            name: c.name,
                            role: c.role,
                            imageUrl: c.imageUrl,
                            isOnline: c.isOnline,
                            isFavorite: c.isFavorite,
                            onAudioCall: () {},
                            onVideoCall: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const VideoCallPage()),
                              );
                            },
                          ),
                        ),
                      ],
                      if (onlineOnly.isNotEmpty) ...[
                        _buildSectionHeader(
                          icon: Icons.circle,
                          label: 'Online',
                          isFavorite: false,
                          status: 'online',
                        ),
                        ...onlineOnly.map(
                          (c) => ContactCard(
                            name: c.name,
                            role: c.role,
                            imageUrl: c.imageUrl,
                            isOnline: c.isOnline,
                            isFavorite: c.isFavorite,
                            onAudioCall: () {},
                            onVideoCall: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const VideoCallPage()),
                              );
                            },
                          ),
                        ),
                      ],
                      if (busy.isNotEmpty) ...[
                        _buildSectionHeader(
                          icon: Icons.schedule,
                          label: 'Busy',
                          isFavorite: false,
                          status: 'busy',
                        ),
                        ...busy.map(
                          (c) => ContactCard(
                            name: c.name,
                            role: c.role,
                            imageUrl: c.imageUrl,
                            isOnline: false,
                            isFavorite: c.isFavorite,
                            onAudioCall: () {},
                            onVideoCall: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const VideoCallPage()),
                              );
                            },
                          ),
                        ),
                      ],
                      if (offline.isNotEmpty) ...[
                        _buildSectionHeader(
                          icon: Icons.remove_circle_outline,
                          label: 'Offline',
                          status: 'offline',
                          isFavorite: false,
                        ),
                        ...offline.map(
                          (c) => ContactCard(
                            name: c.name,
                            role: c.role,
                            imageUrl: c.imageUrl,
                            isOnline: false,
                            isFavorite: c.isFavorite,
                            onAudioCall: () {},
                            onVideoCall: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const VideoCallPage()),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildSectionHeader({
  required IconData icon,
  required String label,
  required String status,
  required bool isFavorite,
}) {
  Color getStatusColor() {
    if (isFavorite && status == 'online') {
      return const Color(0xffEAB308); // gold for Online + Favorite
    } else if (status == 'online') {
      return Colors.green;
    } else if (status == 'offline') {
      return Colors.red;
    } else if (status == 'busy') {
      return const Color(0xffEAB308); // gold for Busy
    } else {
      return Colors.grey;
    }
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        Icon(icon, color: getStatusColor(), size: 20),
        const SizedBox(width: 6),
        Text(label, style: AppTextStyles.label),
      ],
    ),
  );
}
