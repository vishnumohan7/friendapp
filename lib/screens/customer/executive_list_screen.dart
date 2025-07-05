import 'package:feme/core/textstyles.dart';
import 'package:feme/models/contact_model.dart';
import 'package:feme/widgets/bottom_navigation.dart';
import 'package:feme/widgets/coin_badge_action.dart';
import 'package:feme/widgets/executive_card.dart';
import 'package:flutter/material.dart';


class ExecutiveListScreen extends StatefulWidget {
  const ExecutiveListScreen({super.key});

  @override
  State<ExecutiveListScreen> createState() => _ExecutiveListScreenState();
}

class _ExecutiveListScreenState extends State<ExecutiveListScreen> {
  int selectedTab = 0;
  final List<String> tabs = ['All', 'Online', 'Favorites'];

  final List<Contact> contacts = [
    Contact(
      name: "Sarah Johnson",
      role: "Business Consultant",
      imageUrl: "assets/images/img1.png",
      rating: 4.9,
      status: "online",
      isFavorite: true,
    ),
    Contact(
      name: "Emma Wilson",
      role: "Marketing Expert",
      imageUrl: "assets/images/img2.png",
      rating: 4.2,
      status: "online",
      isFavorite: false,
    ),
    Contact(
      name: "Lisa Chen",
      role: "Life Coach",
      imageUrl: "assets/images/img3.png",
      rating: 4.8,
      status: "online",
      isFavorite: false,
    ),
    Contact(
      name: "Maria Garcia",
      role: "Financial Advisor",
      imageUrl: "assets/images/img1.png",
      rating: 4.3,
      status: "busy",
      isFavorite: false,
    ),
    Contact(
      name: "Rachel Brown",
      role: "Career Counselor",
      imageUrl: "assets/images/img2.png",
      rating: 4.7,
      status: "offline",
      isFavorite: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Contact> filteredList = selectedTab == 0
        ? contacts
        : selectedTab == 1
        ? contacts.where((c) => c.status == 'online').toList()
        : contacts.where((c) => c.isFavorite).toList();

    final favOnline = filteredList
        .where((c) => c.status == 'online' && c.isFavorite)
        .toList();
    final online = filteredList
        .where((c) => c.status == 'online' && !c.isFavorite)
        .toList();
    final busy = filteredList.where((c) => c.status == 'busy').toList();
    final offline = filteredList.where((c) => c.status == 'offline').toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          
          iconTheme: const IconThemeData(color: Colors.black54),
          title: Text('Executives', style: AppTextStyles.heading3),
          centerTitle: false,
          actions: const [
            CoinBadge(coins: 2050),
            SizedBox(width: 5),
            Icon(Icons.notifications),
            SizedBox(width: 10),
          ],
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 2),
        body: Column(
          children: [
            // Tab Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  for (int i = 0; i < tabs.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = i;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: selectedTab == i
                                ? const Color(0xffE0ECFF)
                                : const Color(0xffF3F4F6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            tabs[i],
                            style: TextStyle(
                              color: selectedTab == i
                                  ? const Color(0xff2563EB)
                                  : Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  const Spacer(),
                  const Icon(
                    Icons.filter_alt_rounded,
                    color: Color(0xff6B7280),
                  ),
                ],
              ),
            ),

            // Filtered List
            Expanded(
              child: ListView(
                // padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  if (favOnline.isNotEmpty)
                    _buildSection('Favorites Online', favOnline),
                  if (online.isNotEmpty) _buildSection('Online Now', online),
                  if (busy.isNotEmpty) _buildSection('Busy', busy),
                  if (offline.isNotEmpty) _buildSection('Offline', offline),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Contact> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(title, style: AppTextStyles.heading3),
        const SizedBox(height: 10),
        ...items.map(
          (contact) => ExecutiveCard(
            name: contact.name,
            role: contact.role,
            imageUrl: contact.imageUrl,
            rating: contact.rating,
            status: contact.status,
            isFavorite: contact.isFavorite,
            onCall: () {},
            onVideoCall: () {},
            onFavorite: () {},
          ),
        ),
      ],
    );
  }
}
