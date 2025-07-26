
import 'package:feme/models/contact_model.dart';
import 'package:feme/models/user_model.dart';
import 'package:feme/screens/video_call/video_call_main.dart';
import 'package:feme/widgets/contact_card.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  final List<dynamic> contacts;

  const ContactList({
    Key? key,
    required this.contacts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        
        // Handle both Contact and User models
        if (contact is Contact) {
          return ContactCard(
            name: contact.name,
            role: contact.role,
            imageUrl: contact.imageUrl,
            isOnline: contact.isOnline,
            isFavorite: contact.isFavorite,
            onAudioCall: () {},
            onVideoCall: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const VideoCallPage()),
              );
            },
          );
        } else if (contact is User) {
          return ContactCard(
            name: contact.name,
            role: contact.email, // Using email as role for now
            imageUrl: contact.avatar ?? 'assets/images/placeholder.png',
            isOnline: contact.isOnline,
            isFavorite: false, // You might want to implement favorites later
            onAudioCall: () {},
            onVideoCall: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const VideoCallPage()),
              );
            },
          );
        }
        
        return const SizedBox.shrink(); // Fallback for unsupported types
      },
    );
  }
}

// Sample data (can be removed if not needed)
final contactList = [
  Contact(
    name: "Alice John",
    role: "Senior Executive",
    imageUrl: "assets/images/img1.png",
    isOnline: true,
    isFavorite: true,
    status: 'online',
    rating: 5,
  ),
  // ... other sample contacts
];
//     required this.name,
//     required this.role,
//     required this.imageUrl,
//     required this.isOnline,
//     required this.isFavorite,
//     required this.status, // ✅
//   });
// }
