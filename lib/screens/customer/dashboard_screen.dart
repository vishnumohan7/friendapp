import 'package:feme/core/textstyles.dart';
import 'package:feme/models/user_model.dart';
import 'package:feme/providers/user_provider.dart';
import 'package:feme/routes/routes.dart';
import 'package:feme/screens/video_call/video_call_main.dart';
import 'package:feme/widgets/bottom_navigation.dart';
import 'package:feme/widgets/coin_sumary_card.dart';
import 'package:feme/widgets/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerDashboardScreen extends StatefulWidget {
  const CustomerDashboardScreen({super.key});

  @override
  State<CustomerDashboardScreen> createState() =>
      _CustomerDashboardScreenState();
}

class _CustomerDashboardScreenState extends State<CustomerDashboardScreen> {
  int _selectedIndex = 0;
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _userProvider = context.read<UserProvider>();
      _loadUsers();
    });
  }

  Future<void> _loadUsers() async {
    await _userProvider.fetchUsers();
  }

  // Get executives only (filter out non-executive users)
  List<User> get executives => _userProvider.users
      .where((user) => user.userType == 'executive')
      .toList();

  // Get online executives (favorites)
  List<User> get onlineAndFavorite => executives
      .where((user) => user.isOnline)
      .take(3) // Show first 3 as favorites
      .toList();

  // Get other online executives not in favorites
  List<User> get onlineOnly => executives
      .where((user) => user.isOnline && 
          !onlineAndFavorite.any((fav) => fav.id == user.id))
      .toList();

  // Get busy executives
  List<User> get busy => executives
      .where((user) => user.isBusy)
      .toList();

  // Get offline executives
  List<User> get offline => executives
      .where((user) => user.isOffline)
      .toList();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            actions: [
              Stack(
                children: [
                  const Icon(Icons.notifications_none_outlined, color: Color(0xff4B5563)),
                  if (userProvider.isLoading)
                    const Positioned(
                      right: 0,
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 10),
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
                    child: userProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : userProvider.error != null
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Error loading users: ${userProvider.error}',
                              style: const TextStyle(color: Colors.red),
                            ),
                          )
                        : userProvider.users.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('No users found'),
                            )
                          : Column(
                              children: [
                                if (onlineAndFavorite.isNotEmpty) ...[
                                  _buildSectionHeader(
                                    icon: Icons.star,
                                    label: 'Favorites',
                                    status: '${onlineAndFavorite.length} online',
                                    isFavorite: true,
                                  ),
                                  const SizedBox(height: 8),
                                  ...onlineAndFavorite.map((user) => ContactCard(
                                    name: user.name,
                                    role: user.email,
                                    imageUrl: user.avatar ?? 'assets/images/img2.png',
                                    isOnline: user.isOnline,
                                    isFavorite: true,
                                    onAudioCall: () {},
                                    onVideoCall: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) => const VideoCallPage()),
                                      );
                                    },
                                  )).toList(),
                                ],

                                if (onlineOnly.isNotEmpty) ...[
                                  const SizedBox(height: 24),
                                  _buildSectionHeader(
                                    icon: Icons.circle,
                                    label: 'Online',
                                    status: '${onlineOnly.length} online',
                                    isFavorite: false,
                                  ),
                                  const SizedBox(height: 8),
                                  ...onlineOnly.map((user) => ContactCard(
                                    name: user.name,
                                    role: user.email,
                                    imageUrl: user.avatar ?? 'assets/images/img1.png',
                                    isOnline: true,
                                    isFavorite: false,
                                    onAudioCall: () {},
                                    onVideoCall: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) => const VideoCallPage()),
                                      );
                                    },
                                  )).toList(),
                                ],

                                if (busy.isNotEmpty) ...[
                                  const SizedBox(height: 24),
                                  _buildSectionHeader(
                                    icon: Icons.circle,
                                    label: 'Busy',
                                    status: '${busy.length} busy',
                                    isFavorite: false,
                                  ),
                                  const SizedBox(height: 8),
                                  ...busy.map((user) => ContactCard(
                                    name: user.name,
                                    role: user.email,
                                    imageUrl: user.avatar ?? 'assets/images/img1.png',
                                    isOnline: false,
                                    isFavorite: false,
                                    onAudioCall: () {},
                                    onVideoCall: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) => const VideoCallPage()),
                                      );
                                    },
                                  )).toList(),
                                ],

                                if (offline.isNotEmpty) ...[
                                  const SizedBox(height: 24),
                                  _buildSectionHeader(
                                    icon: Icons.circle_outlined,
                                    label: 'Offline',
                                    status: '${offline.length} offline',
                                    isFavorite: false,
                                  ),
                                  const SizedBox(height: 8),
                                  ...offline.map((user) => ContactCard(
                                    name: user.name,
                                    role: user.email,
                                    imageUrl: user.avatar ?? 'assets/images/img2.png',
                                    isOnline: false,
                                    isFavorite: false,
                                    onAudioCall: () {},
                                    onVideoCall: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) => const VideoCallPage()),
                                      );
                                    },
                                  )).toList(),
                                ],
                              ],
                            ),
                  ),
                ],
              ),
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
